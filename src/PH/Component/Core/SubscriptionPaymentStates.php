<?php

declare(strict_types=1);

namespace PH\Component\Core;

final class SubscriptionPaymentStates
{
    const STATE_NEW = 'new';
    const STATE_AWAITING_PAYMENT = 'awaiting_payment';
    const STATE_PARTIALLY_PAID = 'partially_paid';
    const STATE_CANCELLED = 'cancelled';
    const STATE_PAID = 'paid';
    const STATE_PARTIALLY_REFUNDED = 'partially_refunded';
    const STATE_REFUNDED = 'refunded';

    private function __construct()
    {
    }
}
