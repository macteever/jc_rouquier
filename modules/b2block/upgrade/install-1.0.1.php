<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_0_1($module)
{
    $hookNames = [
        'actionObjectCustomerUpdateBefore',
        'actionObjectCustomerUpdateAfter',
        'actionDispatcherBefore',
        'actionFrontControllerSetMedia',
    ];

    foreach ($hookNames as $hookName) {
        $hookId = (int) Hook::getIdByName($hookName);

        if ($hookId > 0 && $module->isRegisteredInHook($hookId)) {
            continue;
        }

        if (!$module->registerHook($hookName)) {
            return false;
        }
    }

    return true;
}
