<?php
declare(strict_types=1);

class B2blockRegisterModuleFrontController extends ModuleFrontController
{

    public function initContent(): void
    {
        parent::initContent();

        $csrfToken = Tools::getToken(false);
        $countries = $this->getCountries();
        $errors = [];
        $success = false;
        $currentStep = $this->resolveCurrentStep();
        $formData = $this->getDefaultFormData();

        if (Tools::isSubmit('b2block_register_submit')) {
            $submittedToken = (string) Tools::getValue('csrf_token');
            if (!hash_equals($csrfToken, $submittedToken)) {
                $errors[] = 'Le jeton de securite est invalide. Merci de recharger la page.';
            }

            $submittedData = $this->getSubmittedData();
            $formData = array_merge($formData, $submittedData);

            $this->validateSubmittedData($formData, $countries, $errors);

            if (empty($errors)) {
                $success = $this->createPendingCustomer($formData, $errors);
                if ($success) {
                    $formData = $this->getDefaultFormData();
                    $currentStep = 1;
                }
            }
        }

        Media::addJsDef([
            'b2blockRegisterCurrentStep' => $currentStep,
        ]);

        $this->context->smarty->assign([
            'actionUrl' => $this->context->link->getModuleLink($this->module->name, 'register'),
            'countries' => $countries,
            'csrf_token' => $csrfToken,
            'success' => $success,
            'errors' => $errors,
            'current_step' => $currentStep,
            'form_data' => $formData,
        ]);

        $this->setTemplate('module:b2block/views/templates/front/register.tpl');
    }

    private function getCountries(): array
    {
        $rawCountries = Country::getCountries((int) $this->context->language->id, true);
        $countries = [];

        foreach ($rawCountries as $country) {
            $id = isset($country['id_country']) ? (int) $country['id_country'] : 0;
            $name = '';

            if (isset($country['name']) && is_string($country['name'])) {
                $name = $country['name'];
            } elseif (isset($country['country']) && is_string($country['country'])) {
                $name = $country['country'];
            }

            if ($id > 0 && $name !== '') {
                $countries[] = [
                    'id_country' => $id,
                    'name' => $name,
                ];
            }
        }

        return $countries;
    }

    private function getDefaultFormData(): array
    {
        return [
            'firstname' => '',
            'lastname' => '',
            'email' => '',
            'phone' => '',
            'company_name' => '',
            'company_legal' => '',
            'siret' => '',
            'vat_number' => '',
            'address1' => '',
            'postcode' => '',
            'city' => '',
            'country' => '',
            'password' => '',
            'password_confirm' => '',
            'certify_cgv' => '',
        ];
    }

    private function getSubmittedData(): array
    {
        $data = [];
        $payload = Tools::getValue('b2block_register_payload');

        if (is_string($payload) && $payload !== '') {
            $decoded = json_decode($payload, true);
            if (is_array($decoded)) {
                $data = $decoded;
            }
        }

        if (empty($data)) {
            $data = [
                'firstname' => Tools::getValue('firstname'),
                'lastname' => Tools::getValue('lastname'),
                'email' => Tools::getValue('email'),
                'phone' => Tools::getValue('phone'),
                'company_name' => Tools::getValue('company_name'),
                'company_legal' => Tools::getValue('company_legal'),
                'siret' => Tools::getValue('siret'),
                'vat_number' => Tools::getValue('vat_number'),
                'address1' => Tools::getValue('address1'),
                'postcode' => Tools::getValue('postcode'),
                'city' => Tools::getValue('city'),
                'country' => Tools::getValue('country'),
                'password' => Tools::getValue('password'),
                'password_confirm' => Tools::getValue('password_confirm'),
                'certify_cgv' => Tools::getValue('certify_cgv'),
            ];
        }

        foreach ($data as $key => $value) {
            if (is_string($value)) {
                $data[$key] = trim($value);
            }
        }

        return $data;
    }

    private function resolveCurrentStep(): int
    {
        $step = (int) Tools::getValue('current_step', Tools::getValue('step', 1));
        $payload = Tools::getValue('b2block_register_payload');

        if ($step <= 0 && is_string($payload) && $payload !== '') {
            $decoded = json_decode($payload, true);
            if (is_array($decoded) && isset($decoded['current_step'])) {
                $step = (int) $decoded['current_step'];
            }
        }

        if ($step < 1 || $step > 5) {
            return 1;
        }

        return $step;
    }

    private function validateSubmittedData(array &$data, array $countries, array &$errors): void
    {
        if (empty($data['firstname'])) {
            $errors[] = 'Le prénom est obligatoire.';
        }

        if (empty($data['lastname'])) {
            $errors[] = 'Le nom est obligatoire.';
        }

        $email = (string) ($data['email'] ?? '');
        if ($email === '' || !Validate::isEmail($email)) {
            $errors[] = 'Adresse email invalide.';
        } elseif ($this->emailExists($email)) {
            $errors[] = 'Cet email est déjà utilisé.';
        }

        if (empty($data['phone'])) {
            $errors[] = 'Le téléphone est obligatoire.';
        } else {
            $data['phone'] = $this->normalizeDigits((string) $data['phone']);
            if (strlen((string) $data['phone']) !== 10) {
                $errors[] = 'Le téléphone doit contenir 10 chiffres.';
            }
        }

        if (empty($data['company_name'])) {
            $errors[] = 'Le nom de societe est obligatoire.';
        }

        if (empty($data['company_legal'])) {
            $errors[] = 'La raison sociale est obligatoire.';
        }

        if (empty($data['siret'])) {
            $errors[] = 'Le SIRET est obligatoire.';
        } else {
            $data['siret'] = $this->normalizeDigits((string) $data['siret']);
            if (strlen((string) $data['siret']) !== 14) {
                $errors[] = 'Le SIRET doit contenir 14 chiffres.';
            } elseif ($this->siretExists((string) $data['siret'])) {
                $errors[] = 'Ce SIRET est déjà enregistré.';
            }
        }

        if (empty($data['address1'])) {
            $errors[] = 'Adresse est obligatoire.';
        }

        if (empty($data['postcode'])) {
            $errors[] = 'Le code postal est obligatoire.';
        } else {
            $data['postcode'] = $this->normalizeDigits((string) $data['postcode']);
            if (strlen((string) $data['postcode']) !== 5) {
                $errors[] = 'Le code postal doit contenir 5 chiffres.';
            }
        }

        if (empty($data['city'])) {
            $errors[] = 'La ville est obligatoire.';
        }

        $countryId = (int) ($data['country'] ?? 0);
        $allowedCountryIds = array_map(static function (array $country): int {
            return (int) $country['id_country'];
        }, $countries);

        if ($countryId <= 0 || !in_array($countryId, $allowedCountryIds, true)) {
            $errors[] = 'Le pays sélectionné est invalide.';
        }

        $password = (string) ($data['password'] ?? '');
        $passwordConfirm = (string) ($data['password_confirm'] ?? '');

        if (strlen($password) < 8) {
            $errors[] = 'Le mot de passe doit contenir au moins 8 caracteres.';
        }

        if ($passwordConfirm === '') {
            $errors[] = 'La confirmation du mot de passe est obligatoire.';
        }

        if ($password !== '' && $passwordConfirm !== '' && $password !== $passwordConfirm) {
            $errors[] = 'Les mots de passe ne correspondent pas.';
        }

        if (empty($data['certify_cgv']) || !in_array((string) $data['certify_cgv'], ['1', 'on', 'true'], true)) {
            $errors[] = 'Vous devez certifier l\'acceptation des CGV.';
        }
    }

    private function createPendingCustomer(array $data, array &$errors): bool
    {
        $customer = new Customer();
        $customer->firstname = (string) $data['firstname'];
        $customer->lastname = (string) $data['lastname'];
        $customer->email = (string) $data['email'];
        $customer->passwd = Tools::hash((string) $data['password']);
        $customer->active = 0;
        $customer->is_guest = 0;
        $customer->id_default_group = (int) Configuration::get('PS_CUSTOMER_GROUP');
        $customer->id_lang = (int) $this->context->language->id;
        $customer->id_shop = (int) $this->context->shop->id;
        $customer->id_shop_group = (int) $this->context->shop->id_shop_group;

        // Stockage des donnees entreprise non natives dans la note client.
        $customer->note = sprintf(
            "Raison sociale juridique: %s\nSIRET: %s",
            (string) $data['company_legal'],
            (string) $data['siret']
        );

        if (!$customer->add()) {
            $errors[] = 'Impossible de créer le client pour le moment.';
            return false;
        }

        $address = new Address();
        $address->id_customer = (int) $customer->id;
        $address->id_country = (int) $data['country'];
        $address->alias = 'Professionnel';
        $address->firstname = (string) $data['firstname'];
        $address->lastname = (string) $data['lastname'];
        $address->address1 = (string) $data['address1'];
        $address->postcode = (string) $data['postcode'];
        $address->city = (string) $data['city'];
        $address->phone_mobile = (string) $data['phone'];
        $address->company = (string) $data['company_name'];

        if (!empty($data['vat_number'])) {
            $address->vat_number = (string) $data['vat_number'];
        }

        // Stockage du SIRET dans le champ DNI de l'adresse (fallback).
        $address->dni = (string) $data['siret'];

        if (!$address->add()) {
            $customer->delete();
            $errors[] = 'Impossible de créer l\'adresse pour le moment.';
            return false;
        }

        $this->notifyCustomerRequest($data);
        $this->notifyAdmin($data, (int) $customer->id);

        return true;
    }

    private function notifyCustomerRequest(array $data): void
    {
        $idLang = (int) $this->context->language->id;
        $shopEmail = (string) Configuration::get('PS_SHOP_EMAIL');
        $shopName = (string) Configuration::get('PS_SHOP_NAME');

        $sent = Mail::Send(
            $idLang,
            'customer_request',
            'Demande recue - en attente de validation',
            $this->buildMailTemplateVars($data),
            (string) $data['email'],
            trim((string) $data['firstname'] . ' ' . (string) $data['lastname']),
            $shopEmail,
            $shopName,
            null,
            null,
            _PS_MODULE_DIR_ . $this->module->name . '/mails/',
            false,
            (int) $this->context->shop->id
        );

        if (!$sent) {
            PrestaShopLogger::addLog(
                sprintf('B2block: échec envoi email client demande (email=%s).', (string) $data['email']),
                2,
                null,
                'Customer',
                0,
                true
            );
        }
    }

    private function notifyAdmin(array $data, int $customerId): void
    {
        $adminEmail = (string) Configuration::get('PS_SHOP_EMAIL');
        $adminName = (string) Configuration::get('PS_SHOP_NAME');
        $shopEmail = (string) Configuration::get('PS_SHOP_EMAIL');
        $shopName = (string) Configuration::get('PS_SHOP_NAME');
        $idLang = (int) Configuration::get('PS_LANG_DEFAULT');

        $boCustomerUrl = '';
        try {
            $boCustomerUrl = (string) $this->context->link->getAdminLink('AdminCustomers', true, [], [
                'id_customer' => $customerId,
                'viewcustomer' => 1,
            ]);
        } catch (Exception $e) {
            $boCustomerUrl = '';
        }

        $templateVars = $this->buildMailTemplateVars($data);
        $templateVars['{bo_customer_url}'] = $boCustomerUrl !== '' ? $boCustomerUrl : 'ID customer: ' . $customerId;

        $sent = Mail::Send(
            $idLang,
            'admin_request',
            'Nouvelle demande d\'inscription pro',
            $templateVars,
            $adminEmail,
            $adminName,
            $shopEmail,
            $shopName,
            null,
            null,
            _PS_MODULE_DIR_ . $this->module->name . '/mails/',
            false,
            (int) $this->context->shop->id
        );

        if (!$sent) {
            PrestaShopLogger::addLog(
                sprintf('B2block: échec envoi email admin demande (customer_id=%d, email=%s).', $customerId, (string) $data['email']),
                2,
                null,
                'Customer',
                $customerId,
                true
            );
        }
    }

    private function buildMailTemplateVars(array $data): array
    {
        $countryId = (int) ($data['country'] ?? 0);
        $countryName = $countryId > 0
            ? (string) Country::getNameById((int) $this->context->language->id, $countryId)
            : '';

        return [
            '{firstname}' => (string) ($data['firstname'] ?? ''),
            '{lastname}' => (string) ($data['lastname'] ?? ''),
            '{email}' => (string) ($data['email'] ?? ''),
            '{phone}' => (string) ($data['phone'] ?? ''),
            '{company_name}' => (string) ($data['company_name'] ?? ''),
            '{company_legal}' => (string) ($data['company_legal'] ?? ''),
            '{siret}' => (string) ($data['siret'] ?? ''),
            '{vat_number}' => (string) ($data['vat_number'] ?? ''),
            '{address1}' => (string) ($data['address1'] ?? ''),
            '{postcode}' => (string) ($data['postcode'] ?? ''),
            '{city}' => (string) ($data['city'] ?? ''),
            '{country}' => $countryName,
            '{shop_name}' => (string) Configuration::get('PS_SHOP_NAME'),
            '{shop_url}' => (string) $this->context->link->getPageLink('index', true),
        ];
    }

    private function normalizeDigits(string $value): string
    {
        return (string) preg_replace('/\D+/', '', $value);
    }

    private function emailExists(string $email): bool
    {
        if (method_exists('Customer', 'customerExists')) {
            return (bool) Customer::customerExists($email);
        }

        $query = new DbQuery();
        $query->select('c.id_customer');
        $query->from('customer', 'c');
        $query->where('c.email = "' . pSQL($email) . '"');
        $query->limit(1);

        try {
            return (bool) Db::getInstance()->getValue($query);
        } catch (Exception $e) {
            PrestaShopLogger::addLog(
                'B2block SQL ERROR: ' . (string) $query . ' / ' . $e->getMessage(),
                2,
                null,
                'Module',
                0,
                true
            );

            return false;
        }
    }

    private function siretExists(string $siret): bool
    {
        $queryAddress = new DbQuery();
        $queryAddress->select('a.id_address');
        $queryAddress->from('address', 'a');
        $queryAddress->where('a.dni = "' . pSQL($siret) . '"');
        $queryAddress->where('a.deleted = 0');
        $queryAddress->limit(1);

        try {
            if ((bool) Db::getInstance()->getValue($queryAddress)) {
                return true;
            }
        } catch (Exception $e) {
            PrestaShopLogger::addLog(
                'B2block SQL ERROR: ' . (string) $queryAddress . ' / ' . $e->getMessage(),
                2,
                null,
                'Module',
                0,
                true
            );

            return false;
        }

        $queryCustomer = new DbQuery();
        $queryCustomer->select('c.id_customer');
        $queryCustomer->from('customer', 'c');
        $queryCustomer->where('c.note LIKE "%' . pSQL($siret, true) . '%"');
        $queryCustomer->limit(1);

        try {
            return (bool) Db::getInstance()->getValue($queryCustomer);
        } catch (Exception $e) {
            PrestaShopLogger::addLog(
                'B2block SQL ERROR: ' . (string) $queryCustomer . ' / ' . $e->getMessage(),
                2,
                null,
                'Module',
                0,
                true
            );

            return false;
        }
    }
}
