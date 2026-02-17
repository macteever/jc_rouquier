<?php
declare(strict_types=1);

class B2blockAccessModuleFrontController extends ModuleFrontController
{
    public function initContent(): void
    {
        parent::initContent();

        $this->context->smarty->assign([
            'login_url' => $this->context->link->getPageLink('authentication', true),
            'forgot_url' => $this->context->link->getPageLink('password', true),
        ]);

        $this->setTemplate('module:b2block/views/templates/front/access.tpl');
    }
}
