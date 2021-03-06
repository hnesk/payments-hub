@public_purchase
Feature: Paying offline during purchase
  In order to pay with cash or by external means
  As a HTTP Client
  I want to be able to complete purchase by paying offline

  Scenario: Paying for subscription
    Given the system has a payment method "Offline" with a code "off"
    And the system has also a new subscription priced at "$50"
    Then I add "Content-Type" header equal to "application/json"
    And I add "Accept" header equal to "application/json"
    And I send a "PUT" request to "/public-api/v1/purchase/payment/12345abcde" with body:
    """
        {
            "payments": [
                {
                    "method": "off"
                }
            ]
        }
    """
    Then the response status code should be 204
    Then I add "Content-Type" header equal to "application/json"
    And I add "Accept" header equal to "application/json"
    And I send a "GET" request to "/public-api/v1/purchase/12345abcde"
    Then the response status code should be 200
    And the JSON node "purchase_state" should be equal to "completed"
    And the JSON node "payment_state" should be equal to "awaiting_payment"
    And the JSON node "total" should be equal to "5000"
    And the JSON node "token_value" should not be null
    And I send a "GET" request to "/public-api/v1/purchase/pay/12345abcde"
    Then the response status code should be 302
    And I send a "GET" request to "/public-api/v1/purchase/12345abcde"
    Then the response status code should be 200
    And the JSON node "purchase_state" should be equal to "completed"
    And the JSON node "payment_state" should be equal to "awaiting_payment"
    And the JSON node "total" should be equal to "5000"
    And the JSON node "token_value" should be equal to "12345abcde"
    And the JSON node "state" should be equal to "new"

  Scenario: Completing successfully bought subscription
    Given the system has a payment method "Offline" with a code "off"
    And the system has also a new subscription priced at "$50"
    Then I add "Content-Type" header equal to "application/json"
    And I add "Accept" header equal to "application/json"
    And I send a "PUT" request to "/public-api/v1/purchase/payment/12345abcde" with body:
    """
        {
            "payments": [
                {
                    "method": "off"
                }
            ]
        }
    """
    Then the response status code should be 204
    Then I add "Content-Type" header equal to "application/json"
    And I add "Accept" header equal to "application/json"
    And I send a "GET" request to "/public-api/v1/purchase/12345abcde"
    Then the response status code should be 200
    And I send a "GET" request to "/public-api/v1/purchase/pay/12345abcde"
    Then the response status code should be 302
    And I am authenticated as "admin"
    And I add "Content-Type" header equal to "application/json"
    And I add "Accept" header equal to "application/json"
    And I send a "PUT" request to "/api/v1/subscriptions/1/payments/1/complete"
    Then the response status code should be 204
    And I add "Content-Type" header equal to "application/json"
    And I add "Accept" header equal to "application/json"
    And I send a "GET" request to "/public-api/v1/purchase/12345abcde"
    Then the response status code should be 200
    And the JSON node "purchase_state" should be equal to "completed"
    And the JSON node "state" should be equal to "fulfilled"
    And the JSON node "payment_state" should be equal to "paid"
