{extends file='layouts/layout-portal.tpl'}
{* {extends file='layouts/layout-full-width.tpl'} *}

{block name='page_content'}
  <main class="b2block-portal">
    <section class="b2block-portal__left">
      <section class="b2block-access" aria-labelledby="b2block-access-title">
        <header class="b2block-access__header">
          <h1 id="b2block-access-title" class="b2block-access__title">Accès professionnel</h1>
          <p class="b2block-access__intro">Ce site est réservé aux professionnels. Connectez-vous ou demandez un accès. Les demandes sont validées manuellement.</p>
        </header>

        <article class="b2block-access__card" aria-labelledby="b2block-register-title">
          <h2 id="b2block-register-title" class="b2block-access__card-title">Demander un accès</h2>
          <p class="b2block-access__text">Votre demande d&apos;accès est vérifiée manuellement par notre équipe. Un numéro SIRET valide est obligatoire pour ouvrir votre compte professionnel.</p>

          <ul class="b2block-access__list">
            <li>Compte pro</li>
            <li>Tarifs réservés</li>
            <li>Validation manuelle</li>
          </ul>

          {if isset($register_url) && $register_url}
            <a class="b2block-access__btn b2block-access__btn--secondary" href="{$register_url|escape:'htmlall':'UTF-8'}">Demander un accès</a>
          {else}
            <a class="b2block-access__btn b2block-access__btn--secondary" href="#">Demander un accès</a>
            <!-- TODO register_url: renseigner l'URL cible de la demande d'accès pro -->
          {/if}
        </article>

        <footer class="b2block-access__footer">
          <p><strong>Contact :</strong> Tél. 00 00 00 00 00 - Email : contact@exemple.fr</p>
          <p>RGPD : vos données sont utilisées uniquement pour traiter votre demande d&apos;accès professionnel.</p>
        </footer>
      </section>
    </section>

    <section class="b2block-portal__right">
      <section class="b2block-access" aria-labelledby="b2block-login-title">
        <article class="b2block-access__card" aria-labelledby="b2block-login-title">
          <h2 id="b2block-login-title" class="b2block-access__card-title">Connexion</h2>

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

            <div class="b2block-access__actions">
              <button type="submit" name="submitLogin" value="1" class="b2block-access__btn b2block-access__btn--primary">Se connecter</button>
            </div>
          </form>

          <a class="b2block-access__link" href="{$forgot_url|escape:'htmlall':'UTF-8'}">Mot de passe oublié</a>
        </article>
      </section>
    </section>
  </main>
{/block}
