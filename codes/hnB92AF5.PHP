<?php
/**
 * @author Ilson Nóbrega <ilson@inobrega.com.br>
 * @version 2.1
 * @since 24/05/2015
 */

namespace Portal;

return array(
    'doctrine' => array(
        'driver' => array(
            __NAMESPACE__ . '_driver' => array(
                'class' => 'Doctrine\ORM\Mapping\Driver\AnnotationDriver',
                'cache' => 'array',
                'paths' => array(
                                __DIR__ . '/../src/' . __NAMESPACE__ . 'Admin/Entity/RBR',
                                __DIR__ . '/../src/' . __NAMESPACE__ . 'Admin/Entity/Publico',
                                __DIR__ . '/../src/' . __NAMESPACE__ . 'Admin/Entity/Views'
                           )
            ),
            'orm_default' => array(
                'drivers' => array(
                    __NAMESPACE__ . 'Admin\Entity\RBR' => __NAMESPACE__ . '_driver',
                    __NAMESPACE__ . 'Admin\Entity\Publico' => __NAMESPACE__ . '_driver',
                    __NAMESPACE__ . 'Admin\Entity\Views' => __NAMESPACE__ . '_driver'
                ),
            ),
        ),
        'fixture' => array(
            'PortalAdmin_fixture' => __DIR__ . '/../src/PortalAdmin/Fixture',
        )
    ),
    'router' => array(
        'routes' => array(
            'portal-home' => array(
                'type' => 'Zend\Mvc\Router\Http\Literal',
                'options' => array(
                    'route'    => '/',
                    'defaults' => array(
                        'controller' => 'Portal\Controller\Index',
                        'action'     => 'index',
                    ),
                ),
            ),
            'auth' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/auth[/:action[/:param]]',
                    'constraints' => array(
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*'
                    ),
                    'defaults' => array(
                        'controller' => 'auth',
                        'action'     => 'index',
                    ),
                ),
            ),
            'portal-admin' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/:controller[/[:action][/[:param]][/:param2][/:param3]]',
                    'constraints' => array(
                        'controller' => '[a-zA-Z][a-zA-Z0-9_-]+',
                        'action'     => '[a-zA-Z][a-zA-Z0-9_-]+',
                        'param'     => '[0-9_-]+'
                    ),
                    'defaults' => array(
                        'controller' => 'admin',
                        'action'     => 'index',
                    ),
                ),
            ),
        ),
    ),
    'controllers' => array(
        'invokables' => array(
            'Portal\Controller\Index' => 'Portal\Controller\IndexController',
            'principal' => 'PortalAdmin\Controller\IndexController',
            'admin' => 'PortalAdmin\Controller\IndexController',
            'auth' => 'PortalAdmin\Controller\AuthController',
            'base' => 'PortalAdmin\Controller\BaseController',
            'transportador' => 'PortalAdmin\Controller\TransportadoraController',
            'ofertar-transportes' => 'PortalAdmin\Controller\OfertarTransporteController',
            'solicitar-transportes' => 'PortalAdmin\Controller\SolicitarTransporteController',
            'produto' => 'PortalAdmin\Controller\ProdutoController',
            'agricultor' => 'PortalAdmin\Controller\AgricultorFamiliarController',
            'dominio' => 'PortalAdmin\Controller\DominioController',
            'fornecedor' => 'PortalAdmin\Controller\FornecedorController',
            'setor-privado' => 'PortalAdmin\Controller\SetorPrivadoController',
            'setor-publico' => 'PortalAdmin\Controller\SetorPublicoController'
        ),
    ),
    'view_manager' => array(
        'display_not_found_reason' => true,
        'display_exceptions'       => true,
        'doctype'                  => 'HTML5',
        'not_found_template'       => 'error/404',
        'exception_template'       => 'error/index',
        'template_map' => array(
            'layout/layout'           => __DIR__ . '/../view/layout/layout.phtml',
            'portal/index/index' => __DIR__ . '/../view/portal/index/index.phtml',
            'error/404'               => __DIR__ . '/../view/error/404.phtml',
            'error/index'             => __DIR__ . '/../view/error/index.phtml',
        ),
        'template_path_stack' => array(
            __DIR__ . '/../view',
        ),
        'strategies' => array(
            'ViewJsonStrategy'
        )
    ),
    // Placeholder for console routes
    'console' => array(
        'router' => array(
            'routes' => array(
            ),
        ),
    ),
);