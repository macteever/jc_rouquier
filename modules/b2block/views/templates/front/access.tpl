{extends file='layouts/layout-portal.tpl'}
{* {extends file='layouts/layout-full-width.tpl'} *}

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
      <section class="b2block-access" aria-labelledby="b2block-login-title">
        <div>
          <h1 id="b2block-login-title" class="b2block-access__card-title">Espace professionnel</h1>
          <p>Accédez à votre compte pour commander votre matériel</p>
        </div>
        <article class="" aria-labelledby="b2block-login-title">

          {if isset($notifications) && $notifications}
            <div class="b2block-access__notice" role="alert">
              {include file='_partials/notifications.tpl' notifications=$notifications}
            </div>
          {elseif isset($errors) && $errors}
            <div class="b2block-access__errors" role="alert">
              <ul>
                {foreach from=$errors item=error}
                  <li>{$error|escape:'htmlall':'UTF-8'}</li>
                {/foreach}
              </ul>
            </div>
          {else}
            <!-- TODO errors: afficher ici les erreurs de connexion si disponibles -->
          {/if}

          <form action="{$login_url|escape:'htmlall':'UTF-8'}" method="post" class="b2block-access__form">
            <div class="b2block-access__form-container">
              {if isset($static_token) && $static_token}
                <input type="hidden" name="token" value="{$static_token|escape:'htmlall':'UTF-8'}">
              {else}
                <!-- TODO token: ajouter le token CSRF si requis par la configuration -->
              {/if}

              <div class="b2block-access__field">
                <label class="b2block-access__label" for="b2block-email">Email</label>
                <input
                  class="b2block-access__input"
                  id="b2block-email"
                  name="email"
                  type="email"
                  autocomplete="email"
                  required
                  value="{if isset($email)}{$email|escape:'htmlall':'UTF-8'}{/if}"
                >
              </div>

              <div class="b2block-access__field">
                <label class="b2block-access__label" for="b2block-password">Mot de passe</label>
                <input
                  class="b2block-access__input"
                  id="b2block-password"
                  name="password"
                  type="password"
                  autocomplete="current-password"
                  required
                >
              </div>
            </div>

            <div class="b2block-access__actions">
              <a class="b2block-access__link lost-password" href="{$forgot_url|escape:'htmlall':'UTF-8'}">Mot de passe oublié</a>
              <button type="submit" name="submitLogin" value="1" class="b2block-access__btn b2block-access__btn--primary">Se connecter</button>
              {if isset($register_url) && $register_url}
                <div class="flex-row justify-content-between flex-wrap">
                  <p>Pas encore de compte ?</p>
                  <a class="b2block-access__btn b2block-access__btn signin fs-14 color-secondary fw-600" href="{$register_url|escape:'htmlall':'UTF-8'}">Créer un compte professionnel</a>
                </div>
              {else}
                <div class="flex-row justify-content-between flex-wrap gap-5 pt-20 pb-20 bb-light-blue">
                  <p class="mb-0 fs-14">Pas encore de compte ?</p>
                  <a class="b2block-access__btn signin fs-14 color-secondary fw-600" href="#">Créer un compte professionnel</a>
                </div>
                 <!-- TODO register_url: renseigner l'URL cible de la demande d'accès pro -->
               {/if}
            </div>

            <div class="flex-row gap-1 tag-info mt-20">  
              <img src="{$smarty.const._MODULE_DIR_}b2block/views/img/icons/security.svg" alt="sécurité" loading="lazy">
              <p class="mb-0">Accès réservé aux professionnels de la plomberie et du chauffage</p>
            </div>
          </form>
        </article>
      </section>
    </section>
  </main>
{/block}
