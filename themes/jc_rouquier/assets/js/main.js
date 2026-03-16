document.addEventListener('DOMContentLoaded', function () {
  var mobileMenu = document.getElementById('mobile-menu');
  var menuToggles = document.querySelectorAll('[data-mobile-menu-toggle]');
  var menuCloseTriggers = document.querySelectorAll('[data-mobile-menu-close]');

  function setMenuState(isOpen) {
    mobileMenu.classList.toggle('is-open', isOpen);
    mobileMenu.setAttribute('aria-hidden', String(!isOpen));
    document.body.classList.toggle('mobile-menu-open', isOpen);

    menuToggles.forEach(function (toggle) {
      toggle.setAttribute('aria-expanded', String(isOpen));
    });
  }

  if (mobileMenu && menuToggles.length) {
    menuToggles.forEach(function (toggle) {
      toggle.addEventListener('click', function () {
        var shouldOpen = !mobileMenu.classList.contains('is-open');
        setMenuState(shouldOpen);
      });
    });

    menuCloseTriggers.forEach(function (trigger) {
      trigger.addEventListener('click', function () {
        setMenuState(false);
      });
    });

    document.addEventListener('keydown', function (event) {
      if (event.key === 'Escape' && mobileMenu.classList.contains('is-open')) {
        setMenuState(false);
      }
    });
  }

  var productTabs = document.querySelector('.product-tabs');
  if (productTabs) {
    var tabButtons = productTabs.querySelectorAll('.tabs-header [data-tab]');
    var tabPanels = productTabs.querySelectorAll('.tab-panel');

    function setActiveTab(tabId) {
      tabButtons.forEach(function (button) {
        var isActive = button.getAttribute('data-tab') === tabId;
        button.classList.toggle('is-active', isActive);
        button.setAttribute('aria-selected', String(isActive));
      });

      tabPanels.forEach(function (panel) {
        var isActive = panel.id === tabId;
        panel.classList.toggle('is-active', isActive);
      });
    }

    if (tabButtons.length) {
      setActiveTab(tabButtons[0].getAttribute('data-tab'));
    }

    tabButtons.forEach(function (button) {
      button.addEventListener('click', function () {
        var tabId = button.getAttribute('data-tab');
        setActiveTab(tabId);
      });
    });
  }

  // Swiper
  var similarSwipers = document.querySelectorAll('.product-similar-swiper');
  if (similarSwipers.length && typeof Swiper !== 'undefined') {
    similarSwipers.forEach(function (swiperEl) {
      var parentSection = swiperEl.closest('.product-similar');
      var nextEl = parentSection ? parentSection.querySelector('.product-similar-next') : null;
      var prevEl = parentSection ? parentSection.querySelector('.product-similar-prev') : null;

      new Swiper(swiperEl, {
        slidesPerView: 1.2,
        spaceBetween: 10,
        loop: true,
        navigation: {
          nextEl: nextEl,
          prevEl: prevEl,
        },
        breakpoints: {
          768: {
            slidesPerView: 2.3,
            spaceBetween: 20,
          },
          1024: {
            slidesPerView: 3.3,
          },
          1440: {
            slidesPerView: 4.3,
          },
        },
      });
    });
  }

  // Add to cart
  document.addEventListener('click', function(e) {

    if (e.target.classList.contains('qty-up')) {
      const input = e.target.parentNode.querySelector('.qty-input');
      input.stepUp();
    }

    if (e.target.classList.contains('qty-down')) {
      const input = e.target.parentNode.querySelector('.qty-input');
      input.stepDown();
    }

  });
});
