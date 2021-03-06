<?php

declare(strict_types=1);

namespace PH\Bundle\PayumBundle\DependencyInjection;

use Sylius\Bundle\ResourceBundle\SyliusResourceBundle;
use Symfony\Component\Config\Definition\Builder\TreeBuilder;
use Symfony\Component\Config\Definition\ConfigurationInterface;

/**
 * This is the class that validates and merges configuration from your app/config files.
 *
 * To learn more see {@link http://symfony.com/doc/current/cookbook/bundles/configuration.html}
 */
final class Configuration implements ConfigurationInterface
{
    /**
     * {@inheritdoc}
     */
    public function getConfigTreeBuilder()
    {
        $treeBuilder = new TreeBuilder();
        $rootNode = $treeBuilder->root('ph_payum');

        $rootNode
            ->addDefaultsIfNotSet()
                ->children()
                ->scalarNode('driver')->defaultValue(SyliusResourceBundle::DRIVER_DOCTRINE_ORM)->end()
                ->scalarNode('thank_you_url')->defaultValue('%ph_payum_redirect_thank_you_url%')->end()
                ->scalarNode('cancel_url')->defaultValue('%ph_payum_redirect_cancel_url%')->end()
            ->end()
        ;

        return $treeBuilder;
    }
}
