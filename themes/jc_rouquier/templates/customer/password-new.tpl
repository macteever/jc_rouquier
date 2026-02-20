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
{extends file='layouts/layout-portal.tpl'}

{block name='page_title'}
  {l s='Reset your password' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
    <main class="portal-reset-password">
      <section class="b2block-portal__left gutter-left">
        <section class="b2block-access" aria-labelledby="b2block-access-title">
          <div class="b2block-access__top">
            <header class="b2block-access__header">
              <img src="{$smarty.const._MODULE_DIR_}b2block/views/img/logo-white.svg" alt="logo jc rouquier" loading="lazy">
              <div>
                <h2 id="b2block-access-title" class="b2block-access__title">Votre partenaire en équipement professionnel</h2>
                <p class="b2block-access__intro">Accédez à notre catalogue complet de matériel de plomberie et de chauffage destiné aux professionnels du secteur</p>
              </div>
            </header>
            <div class="b2block-access__present">
              <div class="b2block-access__card" aria-labelledby="b2block-register-title">
                <h3 id="b2block-register-title" class="b2block-access__card-title">À propos de JC Rouquier</h3>
                <p class="b2block-access__text">JC Rouquier accompagne les professionnels de la plomberie et du chauffage avec une large gamme de matériels, des marques reconnues et un service dédié aux installateurs.</p>
                <button class="btn-white">
                  <a class="b2block-access__btn btn-white" href="{$link->getModuleLink('b2block', 'access')}">
                    Se connecter
                  </a>
                </button>
              </div>
              
              <div class="b2block-access__partners">
                <p><span>Nos partenaires</span></p>
                <ul class="portal-partners-logos">
                  <li><img src="{$smarty.const._MODULE_DIR_}b2block/views/img/partners/armacell.svg" alt="Fournisseur 1" loading="lazy"></li>
                  <li><img src="{$smarty.const._MODULE_DIR_}b2block/views/img/partners/rehau.svg" alt="Fournisseur 2" loading="lazy"></li>
                  <li><img src="{$smarty.const._MODULE_DIR_}b2block/views/img/partners/rems.svg" alt="Fournisseur 3" loading="lazy"></li>
                  <li><img src="{$smarty.const._MODULE_DIR_}b2block/views/img/partners/uponor.svg" alt="Fournisseur 3" loading="lazy"></li>
                </ul>
              </div>
            </div>
          </div>

            
          <footer class="b2block-access__footer">
            <p><strong>Besoin d'aide :</strong></p>
            <ul class="portal-services-logos">
              <li>
                <img class="icon-content" src="{$smarty.const._MODULE_DIR_}b2block/views/img/icons/phone.svg" alt="icon phone" loading="lazy">
                <div class="portal-services-infos">
                  <span>Téléphone</span>
                  <a href="#">01 23 45 67 89</a>
                </div>
              </li>
              <li>
                <img class="icon-content" src="{$smarty.const._MODULE_DIR_}b2block/views/img/icons/mail.svg" alt="icon email" loading="lazy">
                <div class="portal-services-infos">
                  <span>Email</span>
                  <a href="#">contact@jc-rouquier.fr</a>
                </div>
              </li>
            </ul>
            

            <ul class="portal-footer-logos">
              <li>
                <img class="icon-content" src="{$smarty.const._MODULE_DIR_}b2block/views/img/icons/storefront.svg" alt="logo boutique" loading="lazy">
                <p>+ 10 000 références</p>
              </li>
              <li>
                <img class="icon-content" src="{$smarty.const._MODULE_DIR_}b2block/views/img/icons/support_agent.svg" alt="logo support client" loading="lazy">
                <p>Livraison rapide</p>
              </li>
              <li>
                <img class="icon-content" src="{$smarty.const._MODULE_DIR_}b2block/views/img/icons/delivery_truck_speed.svg" alt="logo livraison" loading="lazy">
                <p>Support dédié</p>
              </li>
            </ul>
          </footer>
        </section>
      </section>
      <section class="b2block-portal__right gutter-right">
        <section class="b2block-access" aria-labelledby="b2block-login-title">
          <div>
            <h1 id="b2block-login-title" class="b2block-access__card-title">Votre nouveau mot de passe </h1>
            <header>
              <p class="send-renew-password-link">Créez et confirmez votre nouveau mot de passe</p>
            </header>
          </div
          <form action="{$urls.pages.password}" method="post">
            <ul class="ps-alert-error">
              {foreach $errors as $error}
                <li class="item">
                  <i>
                    <svg viewBox="0 0 24 24">
                      <path fill="#fff" d="M11,15H13V17H11V15M11,7H13V13H11V7M12,2C6.47,2 2,6.5 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M12,20A8,8 0 0,1 4,12A8,8 0 0,1 12,4A8,8 0 0,1 20,12A8,8 0 0,1 12,20Z"></path>
                    </svg>
                  </i>
                  <p>{$error}</p>
                </li>
              {/foreach}
            </ul>
            <section class="form-fields renew-password">
      
              <div class="email tag-info mb-20">
                <img src="{$urls.theme_dir}assets/img/icons/mail.svg" alt="Sécurité" loading="lazy">
                {l
                  s='Email address: %email%'
                  d='Shop.Theme.Customeraccount'
                  sprintf=['%email%' => $customer_email|stripslashes]}
              </div>
      
              <div class="field-password-policy">
                <div class="form-group">
                  <label class="form-control-label">{l s='New password' d='Shop.Forms.Labels'}</label>
                  <div class="js-input-column">
                  <input
                    class="form-control"
                    type="password"
                    data-validate="isPasswd"
                    name="passwd"
                    value=""
                    {if isset($configuration.password_policy.minimum_length)}data-minlength="{$configuration.password_policy.minimum_length}"{/if}
                    {if isset($configuration.password_policy.maximum_length)}data-maxlength="{$configuration.password_policy.maximum_length}"{/if}
                    {if isset($configuration.password_policy.minimum_score)}data-minscore="{$configuration.password_policy.minimum_score}"{/if}
                  >
                  </div>
                </div>
      
                <div class="form-group">
                  <label class="form-control-label">{l s='Confirmation' d='Shop.Forms.Labels'}</label>
                  <div>
                    <input class="form-control" type="password" data-validate="isPasswd" name="confirmation" value="">
                  </div>
                </div>
      
                <input type="hidden" name="token" id="token" value="{$customer_token}">
                <input type="hidden" name="id_customer" id="id_customer" value="{$id_customer}">
                <input type="hidden" name="reset_token" id="reset_token" value="{$reset_token}">
      
                <div class="form-group mb-0">
                  <div>
                    <button class="btn btn-primary" type="submit" name="submit">
                      {l s='Change Password' d='Shop.Theme.Actions'}
                    </button>
                  </div>
                </div>
              </div>
      
            </section>
          </form>
        </section>
      </section>
    </main>
{/block}

{block name='page_footer'}
  <ul>
    <li><a href="{$urls.pages.authentication}">{l s='Back to Login' d='Shop.Theme.Actions'}</a></li>
  </ul>
{/block}
