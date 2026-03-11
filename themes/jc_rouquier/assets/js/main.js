document.addEventListener('DOMContentLoaded', function () {
  var mobileMenu = document.getElementById('mobile-menu');
  var menuToggles = document.querySelectorAll('[data-mobile-menu-toggle]');
  var menuCloseTriggers = document.querySelectorAll('[data-mobile-menu-close]');

  if (!mobileMenu || !menuToggles.length) {
    return;
  }

  function setMenuState(isOpen) {
    mobileMenu.classList.toggle('is-open', isOpen);
    mobileMenu.setAttribute('aria-hidden', String(!isOpen));
    document.body.classList.toggle('mobile-menu-open', isOpen);

    menuToggles.forEach(function (toggle) {
      toggle.setAttribute('aria-expanded', String(isOpen));
    });
  }

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
});
