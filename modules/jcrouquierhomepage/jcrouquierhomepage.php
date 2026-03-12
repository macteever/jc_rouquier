<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

class Jcrouquierhomepage extends Module
{
    public function __construct()
    {
        $this->name = 'jcrouquierhomepage';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'JC Rouquier';
        $this->need_instance = 0;
        $this->bootstrap = false;

        parent::__construct();

        $this->displayName = $this->trans('JC Rouquier Homepage', [], 'Modules.Jcrouquierhomepage.Admin');
        $this->description = $this->trans('Display custom homepage content for authenticated customers.', [], 'Modules.Jcrouquierhomepage.Admin');
        $this->ps_versions_compliancy = ['min' => '8.0.0', 'max' => _PS_VERSION_];
    }

    public function install()
    {
        return parent::install()
            && $this->registerHook('displayHome')
            && $this->registerHook('actionFrontControllerSetMedia');
    }

    public function uninstall()
    {
        return parent::uninstall();
    }

    public function hookActionFrontControllerSetMedia(array $params)
    {
        if (!$this->context || !$this->context->controller) {
            return;
        }

        $controller = $this->context->controller;
        $controllerName = isset($controller->php_self) ? (string) $controller->php_self : '';

        if ($controllerName !== 'index') {
            return;
        }

        $controller->registerStylesheet(
            'module-jcrouquierhomepage-homepage',
            'modules/' . $this->name . '/views/css/homepage.css',
            [
                'media' => 'all',
                'priority' => 150,
            ]
        );
    }

    public function hookDisplayHome(array $params)
    {
        if (!$this->context->customer->isLogged()) {
            return '';
        }

        $suppliers = [
            [
                'name' => 'Aalberts',
                'logo' => $this->_path . 'views/img/aalberts.png',
                'url' => '#',
            ],
            [
                'name' => 'Armacell',
                'logo' => $this->_path . 'views/img/armacell.png',
                'url' => '#',
            ],
            [
                'name' => 'Lapesa',
                'logo' => $this->_path . 'views/img/lapesa.png',
                'url' => '#',
            ],
            [
                'name' => 'rehau',
                'logo' => $this->_path . 'views/img/rehau.png',
                'url' => '#',
            ],
            [
                'name' => 'rems',
                'logo' => $this->_path . 'views/img/rems.png',
                'url' => '#',
            ],
            [
                'name' => 'uponor',
                'logo' => $this->_path . 'views/img/uponor.png',
                'url' => '#',
            ],
        ];

        $this->context->smarty->assign([
            'suppliers' => $suppliers,
        ]);

        return $this->fetch('module:jcrouquierhomepage/views/templates/hook/homepage.tpl');
    }
}
