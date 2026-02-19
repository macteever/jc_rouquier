{extends file='layouts/layout-portal.tpl'}


{block name='page_content'}
  <main class="b2block-portal">
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

              {if isset($register_url) && $register_url}
                <button class="btn-white">
                  <a class="b2block-access__btn btn-white" href="{$register_url|escape:'htmlall':'UTF-8'}">Créer un compte professionnel</a>
                </button>
              {else}
                <button class="btn-white">
                  <a class="b2block-access__btn " href="#">Créer un compte professionnel</a>
                </button>
                <!-- TODO register_url: renseigner l'URL cible de la demande d'accès pro -->
              {/if}
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
      <section class="b2block-register" aria-labelledby="b2block-register-title">
        {if $success}
          <div class="b2block-register__success" role="status">
            <p>Votre demande a ete envoyee. Votre compte est maintenant en attente de validation manuelle.</p>
          </div>
        {else}
          {if isset($errors) && $errors}
            <div class="b2block-register__errors" role="alert">
              <ul>
                {foreach from=$errors item=error}
                  <li>{$error|escape:'htmlall':'UTF-8'}</li>
                {/foreach}
              </ul>
            </div>
          {/if}

          <form method="post" action="{$actionUrl|escape:'htmlall':'UTF-8'}" class="b2block-register__form" data-register-wizard>
            <input type="hidden" name="csrf_token" value="{$csrf_token|escape:'htmlall':'UTF-8'}">
            <input type="hidden" name="b2block_register_payload" value="" data-register-payload>

            <div data-step="1">
              <h2>Etape 1 - Contact</h2>
              <p>
                <label for="reg-firstname">Prenom</label>
                <input id="reg-firstname" type="text" name="firstname" value="{$form_data.firstname|default:''|escape:'htmlall':'UTF-8'}" required>
              </p>
              <p>
                <label for="reg-lastname">Nom</label>
                <input id="reg-lastname" type="text" name="lastname" value="{$form_data.lastname|default:''|escape:'htmlall':'UTF-8'}" required>
              </p>
              <p>
                <label for="reg-email">Email</label>
                <input id="reg-email" type="email" name="email" value="{$form_data.email|default:''|escape:'htmlall':'UTF-8'}" required>
              </p>
              <p>
                <label for="reg-phone">Telephone</label>
                <input id="reg-phone" type="text" name="phone" value="{$form_data.phone|default:''|escape:'htmlall':'UTF-8'}" required>
              </p>
              <p>
                <button type="button" data-next-step>Suivant</button>
              </p>
            </div>

            <div data-step="2" hidden>
              <h2>Etape 2 - Entreprise</h2>
              <p>
                <label for="reg-company-name">Nom de la societe</label>
                <input id="reg-company-name" type="text" name="company_name" value="{$form_data.company_name|default:''|escape:'htmlall':'UTF-8'}" required>
              </p>
              <p>
                <label for="reg-company-legal">Raison sociale</label>
                <input id="reg-company-legal" type="text" name="company_legal" value="{$form_data.company_legal|default:''|escape:'htmlall':'UTF-8'}" required>
              </p>
              <p>
                <label for="reg-siret">SIRET</label>
                <input id="reg-siret" type="text" name="siret" value="{$form_data.siret|default:''|escape:'htmlall':'UTF-8'}" required>
              </p>
              <p>
                <label for="reg-vat">Numero TVA (optionnel)</label>
                <input id="reg-vat" type="text" name="vat_number" value="{$form_data.vat_number|default:''|escape:'htmlall':'UTF-8'}">
              </p>
              <p>
                <button type="button" data-prev-step>Precedent</button>
                <button type="button" data-next-step>Suivant</button>
              </p>
            </div>

            <div data-step="3" hidden>
              <h2>Etape 3 - Adresse</h2>
              <p>
                <label for="reg-address1">Adresse</label>
                <input id="reg-address1" type="text" name="address1" value="{$form_data.address1|default:''|escape:'htmlall':'UTF-8'}" required>
              </p>
              <p>
                <label for="reg-postcode">Code postal</label>
                <input id="reg-postcode" type="text" name="postcode" value="{$form_data.postcode|default:''|escape:'htmlall':'UTF-8'}" required>
              </p>
              <p>
                <label for="reg-city">Ville</label>
                <input id="reg-city" type="text" name="city" value="{$form_data.city|default:''|escape:'htmlall':'UTF-8'}" required>
              </p>
              <p>
                <label for="reg-country">Pays</label>
                <select id="reg-country" name="country" required>
                  <option value="">Selectionnez un pays</option>
                  {foreach from=$countries item=country}
                    <option value="{$country.id_country|intval}" {if $form_data.country|default:'' == $country.id_country}selected{/if}>{$country.name|escape:'htmlall':'UTF-8'}</option>
                  {/foreach}
                </select>
              </p>
              <p>
                <button type="button" data-prev-step>Precedent</button>
                <button type="button" data-next-step>Suivant</button>
              </p>
            </div>

            <div data-step="4" hidden>
              <h2>Etape 4 - Mot de passe</h2>
              <p>
                <label for="reg-password">Mot de passe</label>
                <input id="reg-password" type="password" name="password" minlength="8" required>
              </p>
              <p>
                <label for="reg-password-confirm">Confirmation du mot de passe</label>
                <input id="reg-password-confirm" type="password" name="password_confirm" minlength="8" required>
              </p>
              <p>
                <button type="button" data-prev-step>Precedent</button>
                <button type="button" data-next-step>Suivant</button>
              </p>
            </div>

            <div data-step="5" hidden>
              <h2>Etape 5 - Validation</h2>
              <p>
                <label>
                  <input type="checkbox" name="certify_cgv" value="1" {if $form_data.certify_cgv|default:''}checked{/if} required>
                  Je certifie accepter les CGV et fournir des informations exactes.
                </label>
              </p>
              <p>
                <button type="button" data-prev-step>Precedent</button>
                <button type="submit" name="b2block_register_submit" value="1">Demander ouverture de mon compte</button>
              </p>
            </div>
          </form>
        {/if}
      </section>
    </section>
  </main>
{/block}
