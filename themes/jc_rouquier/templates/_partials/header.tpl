<header class="header">

  {* Ligne 1 : logo + compte + panier *}
  <div class="header-top">
    <div class="container">
      <div class="menu-top-nav flex-row justify-content-between align-items-center">
        <div class="hidden-lg-up">
          <button
            class="mobile-menu-toggle"
            type="button"
            aria-label="Ouvrir le menu"
            aria-expanded="false"
            aria-controls="mobile-menu"
            data-mobile-menu-toggle
          >
            <span class="mobile-menu-toggle__line"></span>
            <span class="mobile-menu-toggle__line"></span>
            <span class="mobile-menu-toggle__line"></span>
          </button>
        </div>

        <div class="header-logo">
          <a href="{$urls.base_url}">
            <img src="{$shop.logo_details.src}" alt="{$shop.name}">
          </a>
        </div>

        <div class="header-search">
          {hook h='displaySearch'}
        </div>

        <div class="header-actions flex-row gap-20">
          {hook h='displayNav1'}
        </div>
      </div>


    </div>
  </div>

  {* Ligne 2 : menu catégories *}
  <div class="header-nav">
    <div class="container">
      <div class="flex-row gap-10 justify-content-center align-items-center">
        <span class="color-white">Nos fournisseurs :</span>
        {hook h='displayNav2'}
      </div>
    </div>
  </div>

  <div class="mobile-menu" id="mobile-menu" aria-hidden="true">
    <div class="mobile-menu__overlay" data-mobile-menu-close></div>
    <div class="mobile-menu__panel">
      <div class="mobile-menu__header">
        <span class="fw-400">Fournisseurs</span>
        <button type="button" class="mobile-menu__close" aria-label="Fermer le menu" data-mobile-menu-close>
          <span>&times;</span>
        </button>
      </div>
      <nav class="mobile-menu__nav" aria-label="Navigation mobile">
        {hook h='displayNav2'}
      </nav>
    </div>
  </div>

</header>
