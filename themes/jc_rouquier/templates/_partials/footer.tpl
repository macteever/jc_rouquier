{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

<div class="footer-container">
  <div class="container">
    <div class="main-footer flex-row justify-content-between align-items-start">
      <div class="flex-col footer-logo gap-20">
        <img class="" src="{$smarty.const._THEME_DIR_}/assets/img/logo-white.svg" alt="Fournisseur 3" loading="lazy">
        <p>
          Fournisseur d'équipements professionnels de plomberie et chauffage depuis 1985.
        </p>
      </div>
      <div class="flex-row flex-wrap gap-50">
        {block name='hook_footer'}
          {hook h='displayFooter'}
        {/block}
    
      </div>
    </div>
    {* Subfooter *}
    <div class="flex-row subfooter">
      <div class="col-md-12">
        <p class="text-center mb-0">
          {block name='copyright_link'}
            {l s='%copyright% %year% - JC ROUQUIER - Tous droits réservés - Accès réservé aux professionnels' sprintf=['%prestashop%' => 'PrestaShop™', '%year%' => 'Y'|date, '%copyright%' => '©'] d='Shop.Theme.Global'}
          {/block}
        </p>
      </div>
    </div>
  </div>
</div>
