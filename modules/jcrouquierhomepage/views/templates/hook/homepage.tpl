<section class="home-hero" aria-label="Bannière principale">
  <div class="container">
    <div class="flex-col align-items-center w-full">
      <div class="hero-content ">
        <h1>Bienvenue sur votre espace professionnel JC Rouquier</h1>
        <p>Retrouvez l'ensemble de nos références et accédez rapidement à vos commandes, devis et informations commerciales.</p>
        <a href="/order" class="hero-cta btn-white">Commandes et devis en cours</a>
      </div>
    </div>

  </div>
</section>

<section class="home-suppliers" aria-label="Fournisseurs">
  <div class="container">
    <div class="flex-col align-items-center mb-30">
      <h2>Nos fournisseurs et partenaires</h2>
      <p>Trouvez vos produits parmi les marques les plus reconnues du secteur pour vous garantir qualité et fiabilité sur tous vos projets.</p>
    </div>
    <div class="suppliers-grid">
      {foreach $suppliers as $supplier}
        <a class="supplier-card" href="{$supplier.url|escape:'html':'UTF-8'}">
          <img src="{$supplier.logo|escape:'html':'UTF-8'}" alt="{$supplier.name|escape:'html':'UTF-8'}" loading="lazy">
          {* <span class="supplier-name">{$supplier.name|escape:'html':'UTF-8'}</span> *}
        </a>
      {/foreach}
    </div>
  </div>
</section>

<section class="home-quicklinks" aria-label="Accès rapide">
  <div class="container">
    <div class="mb-30">
      <h2>Accès rapide</h2>
    </div>
    <div class="quicklinks-grid">
      <a class="quicklink-card" href="/quotes">
        <span class="quicklink-icon">
          <i class="material-icons">assignment</i>
        </span>
        <div class="flex-col gap-10">
          <h3>Devis en cours</h3>
          <p>Suivez vos devis en attente</p>
        </div>
        <div class="flex-row gap-10 align-items-center">
          <span class="color-primary fw-500">Voir mes devis</span>
          <i class="material-icons color-primary fw-500">arrow_right_alt</i>
        </div>

      </a>

      <a class="quicklink-card" href="/order">
        <span class="quicklink-icon">
          <i class="material-icons">inventory</i>
        </span>
        <div class="flex-col gap-10">
          <h3>Commandes en cours</h3>
          <p>Suivez l'état de vos commandes</p>
        </div>
        <div class="flex-row gap-10 align-items-center">
          <span class="color-primary fw-500">Voir mes commandes</span>
          <i class="material-icons color-primary fw-500">arrow_right_alt</i>
        </div>
      </a>

      <a class="quicklink-card" href="/history">
        <span class="quicklink-icon">
          <i class="material-icons">history</i>
        </span>
        <div class="flex-col gap-10">
          <h3>Historique d'achats</h3>
          <p>Retrouvez et recommandez vos produits habituels</p>
        </div>
        <div class="flex-row gap-10 align-items-center">
          <span class="color-primary fw-500">Consultez l'historique</span>
          <i class="material-icons color-primary fw-500">arrow_right_alt</i>
        </div>
      </a>

      <div class="quicklink-card">
        <span class="quicklink-icon">
          <i class="material-icons">support_agent</i>
        </span>
        <div class="flex-col gap-10">
          <h3>Votre conseiller</h3>
          <p>Contactez votre interlocuteur</p>
        </div>
        <div class="flex-col gap-10 "> 
            <div class="flex-row gap-10 align-items-center"> 
                <i class="material-icons fs-14 color-primary">phone</i>
                <a  class="color-primary fw-500" href="tel:+33749909569">07 49 90 95 69</a> 
            </div>
            <div class="flex-row gap-10 align-items-center"> 
                <i class="material-icons fs-14 color-primary">mail</i>
                <a  class="color-primary fw-500" href="mailto:commercial@jcrouquier.com">commercial@jcrouquier.com</a> 
            </div>
        </div>

      </div>
    </div>
  </div>
</section>

<section class="home-reassurance" aria-label="Réassurance">
  <div class="container">
    <div class="reassurance-grid">
      <div class="reassurance-item">
        <span class="reassurance-icon">
          <i class="material-icons color-secondary">store</i>
        </span>
        <div class="flex-col justify-content-start align-items-start gap-5">
          <h3>+ 10000 références</h3>
          <p>Large catalogue de produits pour tous vos chantiers</p>
        </div>
      </div>

      <div class="reassurance-item">
        <span class="reassurance-icon">
          <i class="material-icons color-secondary">local_shipping</i>
        </span>
        <div class="flex-col justify-content-start align-items-start gap-5">
          <h3>Livraison rapide</h3>
          <p>Expédition sous 24h dans la Haute-Garonne (31)</p>
        </div>
        </div>
          
      <div class="reassurance-item">
        <span class="reassurance-icon">
          <i class="material-icons color-secondary">support_agent</i>
        </span>
        <div class="flex-col justify-content-start align-items-start gap-5">
          <h3>Support dédié</h3>
          <p>Conseils techniques et assistance professionnelle</p>
        </div>
      </div>

      <div class="reassurance-item">
        <span class="reassurance-icon">
          <i class="material-icons color-secondary">workspace_premium</i>
        </span>
        <div class="flex-col justify-content-start align-items-start gap-5">
          <h3>Marques premium</h3>
          <p>Partenariats avec les leaders du marché</p>
        </div>
      </div>
    </div>
  </div>
</section>
