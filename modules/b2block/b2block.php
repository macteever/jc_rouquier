<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

class B2block extends Module
{
    /** @var array<int, int> */
    private static $customerActiveStateCache = [];

    public function __construct()
    {
        $this->name = 'b2block';
        $this->version = '1.0.1';
        $this->author = 'Local';
        $this->need_instance = 0;

        parent::__construct();

        $this->displayName = 'B2B Lock (redirect guests)';
        $this->description = 'Redirect non-logged visitors to landing page, except login/forgot password.';
    }

    public function install()
    {
        return parent::install()
            && $this->registerHook('actionDispatcherBefore')
            && $this->registerHook('actionFrontControllerSetMedia')
            && $this->registerHook('actionObjectCustomerUpdateBefore')
            && $this->registerHook('actionObjectCustomerUpdateAfter');
    }

    public function hookActionFrontControllerSetMedia($params)
    {
        $controller = $this->context->controller;

        $currentController = (string) Tools::getValue('controller');
        $currentModule = (string) Tools::getValue('module');
        $currentFc = (string) Tools::getValue('fc');

        $isModuleFrontPage = (
            $currentFc === 'module'
            && $currentModule === $this->name
        );

        if (!$isModuleFrontPage) {
            return;
        }

        if ($currentController === 'access') {
            $controller->registerStylesheet(
                'b2block-access-css',
                'modules/' . $this->name . '/views/css/access.css',
                [
                    'media' => 'all',
                    'priority' => 150,
                    'version' => $this->version,
                ]
            );

            $controller->registerJavascript(
                'b2block-access-js',
                'modules/' . $this->name . '/views/js/access.js',
                [
                    'position' => 'bottom',
                    'priority' => 150,
                    'version' => $this->version,
                ]
            );
        }

        if ($currentController === 'register') {
            $controller->registerJavascript(
                'b2block-register-js',
                'modules/' . $this->name . '/views/js/register.js',
                [
                    'position' => 'bottom',
                    'priority' => 150,
                    'version' => $this->version,
                ]
            );
        }
    }

    public function hookActionObjectCustomerUpdateBefore($params)
    {
        if (!isset($params['object']) || !($params['object'] instanceof Customer)) {
            return;
        }

        /** @var Customer $customer */
        $customer = $params['object'];
        $customerId = (int) $customer->id;

        if ($customerId <= 0) {
            return;
        }

        $existingCustomer = new Customer($customerId);
        self::$customerActiveStateCache[$customerId] = (int) $existingCustomer->active;

        PrestaShopLogger::addLog(
            sprintf(
                'B2block DEBUG BEFORE customer update: customer_id=%d db_active=%d',
                $customerId,
                (int) $existingCustomer->active
            ),
            1,
            null,
            'Customer',
            $customerId,
            true
        );
    }

    public function hookActionObjectCustomerUpdateAfter($params)
    {
        if (!isset($params['object']) || !($params['object'] instanceof Customer)) {
            return;
        }

        /** @var Customer $customer */
        $customer = $params['object'];
        $customerId = (int) $customer->id;

        if ($customerId <= 0) {
            return;
        }

        $beforeActive = self::$customerActiveStateCache[$customerId] ?? null;
        unset(self::$customerActiveStateCache[$customerId]);

        PrestaShopLogger::addLog(
            sprintf(
                'B2block DEBUG AFTER customer update: customer_id=%d final_active=%d before_active=%s',
                $customerId,
                (int) $customer->active,
                $beforeActive === null ? 'null' : (string) $beforeActive
            ),
            1,
            null,
            'Customer',
            $customerId,
            true
        );

        if ($beforeActive !== 0 || (int) $customer->active !== 1) {
            return;
        }

        $this->notifyCustomerApproved($customer);
    }

    private function notifyCustomerApproved(Customer $customer)
    {
        $customerId = (int) $customer->id;
        $idLang = (int) ($customer->id_lang ?: Configuration::get('PS_LANG_DEFAULT'));
        $shopEmail = (string) Configuration::get('PS_SHOP_EMAIL');
        $shopName = (string) Configuration::get('PS_SHOP_NAME');

        $templateVars = [
            '{firstname}' => (string) $customer->firstname,
            '{lastname}' => (string) $customer->lastname,
            '{email}' => (string) $customer->email,
            '{phone}' => '',
            '{company_name}' => '',
            '{company_legal}' => '',
            '{siret}' => '',
            '{vat_number}' => '',
            '{address1}' => '',
            '{postcode}' => '',
            '{city}' => '',
            '{country}' => '',
            '{shop_name}' => $shopName,
            '{shop_url}' => (string) $this->context->link->getPageLink('index', true),
        ];

        $addressId = 0;
        if (property_exists($customer, 'id_address_default')) {
            $addressId = (int) $customer->id_address_default;
            if ($addressId > 0) {
                $defaultAddress = new Address($addressId);
                if (!Validate::isLoadedObject($defaultAddress)) {
                    $addressId = 0;
                }
            }
        }

        if ($addressId <= 0) {
            $db = Db::getInstance();
            $activeColumnResult = $db->executeS(
                'SHOW COLUMNS FROM `' . _DB_PREFIX_ . 'address` LIKE \'active\''
            );
            $hasActiveColumn = !empty($activeColumnResult);

            $addressQuery = '
                SELECT a.id_address
                FROM `' . _DB_PREFIX_ . 'address` a
                WHERE a.id_customer = ' . (int) $customerId . '
                  AND a.deleted = 0
            ';

            if ($hasActiveColumn) {
                $addressQuery .= ' AND a.active = 1';
            }

            $addressQuery .= ' ORDER BY a.id_address ASC';

            $addressId = (int) $db->getValue($addressQuery);
        }

        if ($addressId <= 0) {
            PrestaShopLogger::addLog(
                sprintf(
                    'B2block DEBUG notifyCustomerApproved: no address found for customer_id=%d',
                    $customerId
                ),
                2,
                null,
                'Customer',
                $customerId,
                true
            );
        }

        if ($addressId > 0) {
            $address = new Address($addressId);
            if (Validate::isLoadedObject($address)) {
                $templateVars['{phone}'] = (string) ($address->phone_mobile ?: $address->phone);
                $templateVars['{company_name}'] = (string) $address->company;
                $templateVars['{vat_number}'] = (string) $address->vat_number;
                $templateVars['{address1}'] = (string) $address->address1;
                $templateVars['{postcode}'] = (string) $address->postcode;
                $templateVars['{city}'] = (string) $address->city;
                $templateVars['{country}'] = (string) Country::getNameById($idLang, (int) $address->id_country);
                $templateVars['{siret}'] = (string) $address->dni;
            }
        }

        if (!empty($customer->note)) {
            if (preg_match('/Raison sociale juridique:\s*(.+)/i', (string) $customer->note, $matches)) {
                $templateVars['{company_legal}'] = trim((string) $matches[1]);
            }
        }

        PrestaShopLogger::addLog(
            sprintf(
                'B2block DEBUG notifyCustomerApproved: calling Mail::Send for customer_id=%d email=%s',
                $customerId,
                (string) $customer->email
            ),
            1,
            null,
            'Customer',
            $customerId,
            true
        );

        $sent = Mail::Send(
            $idLang,
            'customer_approved',
            $this->l('Your account is approved - you can log in now'),
            $templateVars,
            (string) $customer->email,
            trim((string) $customer->firstname . ' ' . (string) $customer->lastname),
            $shopEmail,
            $shopName,
            null,
            null,
            _PS_MODULE_DIR_ . 'b2block/mails/',
            false,
            (int) $this->context->shop->id
        );

        if (!$sent) {
            PrestaShopLogger::addLog(
                sprintf('B2block: echec envoi email validation client (customer_id=%d, email=%s).', $customerId, (string) $customer->email),
                2,
                null,
                'Customer',
                (int) $customer->id,
                true
            );
        }
    }

    public function hookActionDispatcherBefore($params)
    {
        $requestUri = (string) ($_SERVER['REQUEST_URI'] ?? '');
        $requestMethod = (string) ($_SERVER['REQUEST_METHOD'] ?? '');
        $fc = (string) Tools::getValue('fc');
        $module = (string) Tools::getValue('module');
        $controller = (string) Tools::getValue('controller');

        PrestaShopLogger::addLog(
            sprintf(
                'B2block dispatcher debug: REQUEST_URI=%s method=%s fc=%s module=%s controller=%s',
                $requestUri,
                $requestMethod,
                $fc,
                $module,
                $controller
            ),
            1,
            null,
            'Module',
            0,
            true
        );

        // 1) On ne bloque pas le back-office
        if ($this->context->employee) {
            return;
        }

        // 2) Si deja connecte (client), on ne bloque pas
        if ($this->context->customer && $this->context->customer->isLogged()) {
            return;
        }

        if (
            $controller === 'authentication'
            || $controller === 'password'
        ) {
            return;
        }

        if ($fc === 'module' && $module === 'b2block') {
            return;
        }

        if (strpos($requestUri, '/module/b2block/') !== false) {
            return;
        }

        PrestaShopLogger::addLog(
            'B2block redirect triggered',
            1,
            null,
            'Module',
            0,
            true
        );

        Tools::redirect($this->context->link->getModuleLink('b2block', 'access'));
    }
}
