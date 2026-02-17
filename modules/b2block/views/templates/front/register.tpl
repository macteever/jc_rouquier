{extends file='layouts/layout-full-width.tpl'}

{block name='header'}{/block}
{block name='footer'}{/block}

{block name='content'}
  <main class="b2block-portal">
    <section class="b2block-portal__left">
      <section class="b2block-register" aria-labelledby="b2block-register-title">
        <h1 id="b2block-register-title">Demande d'ouverture de compte professionnel</h1>
      </section>
    </section>

    <section class="b2block-portal__right">
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
