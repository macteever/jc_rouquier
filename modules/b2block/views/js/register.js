(function () {
  'use strict';

  var form = document.querySelector('[data-register-wizard]');
  if (!form) {
    return;
  }

  var steps = Array.prototype.slice.call(form.querySelectorAll('[data-step]')).sort(function (a, b) {
    return Number(a.getAttribute('data-step')) - Number(b.getAttribute('data-step'));
  });

  if (!steps.length) {
    return;
  }

  var payloadInput = form.querySelector('[data-register-payload]');
  var initialStepFromServer = Number(window.b2blockRegisterCurrentStep || 0);
  var currentStepInput = form.querySelector('[data-current-step]');
  if (!currentStepInput) {
    currentStepInput = document.createElement('input');
    currentStepInput.type = 'hidden';
    currentStepInput.name = 'current_step';
    currentStepInput.setAttribute('data-current-step', '');
    currentStepInput.value = String(initialStepFromServer > 0 ? initialStepFromServer : 1);
    form.appendChild(currentStepInput);
  }

  var initialStep = initialStepFromServer > 0
    ? initialStepFromServer
    : (currentStepInput ? Number(currentStepInput.value || '1') : 1);
  var currentStep = Number.isNaN(initialStep) ? 1 : initialStep;
  var totalSteps = steps.length;

  var progressRoot = form.querySelector('[data-register-progress]');
  var progressCurrentStep = form.querySelector('[data-register-current-step]');
  var progressStepTitle = form.querySelector('[data-register-step-title]');
  var progressFill = form.querySelector('[data-register-progress-fill]');
  var progressBar = progressRoot ? progressRoot.querySelector('.b2block-register__progress-bar') : null;

  if (currentStep < 1 || currentStep > 5) {
    currentStep = 1;
  }

  function getErrorContainer() {
    var existing = document.querySelector('.b2block-register__errors');
    if (existing) {
      return existing;
    }

    var container = document.createElement('div');
    container.className = 'b2block-register__errors';
    container.setAttribute('role', 'alert');
    form.insertBefore(container, form.firstChild);

    return container;
  }

  function clearErrors() {
    var container = getErrorContainer();
    container.innerHTML = '';
    container.style.display = 'none';

    var invalidFields = form.querySelectorAll('.is-invalid');
    Array.prototype.forEach.call(invalidFields, function (field) {
      field.classList.remove('is-invalid');
    });
  }

  function showErrors(errors) {
    var container = getErrorContainer();

    if (!errors.length) {
      container.innerHTML = '';
      container.style.display = 'none';
      return;
    }

    var html = '<ul>';
    errors.forEach(function (message) {
      html += '<li>' + message + '</li>';
    });
    html += '</ul>';

    container.innerHTML = html;
    container.style.display = '';
  }

  function fieldValue(name) {
    var field = form.querySelector('[name="' + name + '"]');
    if (!field) {
      return '';
    }

    if (field.type === 'checkbox') {
      return field.checked ? '1' : '';
    }

    return (field.value || '').trim();
  }

  function markInvalid(field, errors, message) {
    errors.push(message);

    if (field) {
      field.classList.add('is-invalid');
    }
  }

  function validateCurrentStep() {
    clearErrors();

    var currentStepEl = form.querySelector('[data-step="' + currentStep + '"]');
    if (!currentStepEl) {
      return true;
    }

    var errors = [];
    var firstInvalidField = null;

    function invalidate(name, message) {
      var field = currentStepEl.querySelector('[name="' + name + '"]');
      markInvalid(field, errors, message);
      if (!firstInvalidField && field) {
        firstInvalidField = field;
      }
    }

    function required(name, message) {
      if (!fieldValue(name)) {
        invalidate(name, message);
        return false;
      }

      return true;
    }

    if (currentStep === 1) {
      required('firstname', 'Le prenom est obligatoire.');
      required('lastname', 'Le nom est obligatoire.');

      var emailField = currentStepEl.querySelector('[name="email"]');
      var emailValue = fieldValue('email');
      if (!emailValue) {
        invalidate('email', 'Adresse email invalide.');
      } else if (!emailField || !emailField.checkValidity()) {
        invalidate('email', 'Adresse email invalide.');
      }

      var phoneValue = fieldValue('phone');
      if (!phoneValue) {
        invalidate('phone', 'Le telephone est obligatoire.');
      } else if (phoneValue.replace(/\D+/g, '').length !== 10) {
        invalidate('phone', 'Le téléphone doit contenir 10 chiffres.');
      }
    }

    if (currentStep === 2) {
      required('company_name', 'Le nom de societe est obligatoire.');
      required('company_legal', 'La raison sociale est obligatoire.');

      var siretValue = fieldValue('siret');
      if (!siretValue) {
        invalidate('siret', 'Le SIRET est obligatoire.');
      } else if (siretValue.replace(/\D+/g, '').length !== 14) {
        invalidate('siret', 'Le SIRET doit contenir 14 chiffres.');
      }
    }

    if (currentStep === 3) {
      required('address1', 'L adresse est obligatoire.');

      var postcodeValue = fieldValue('postcode');
      if (!postcodeValue) {
        invalidate('postcode', 'Le code postal est obligatoire.');
      } else if (postcodeValue.replace(/\D+/g, '').length !== 5) {
        invalidate('postcode', 'Le code postal doit contenir 5 chiffres.');
      }

      required('city', 'La ville est obligatoire.');

      if (!fieldValue('country')) {
        invalidate('country', 'Le pays selectionne est invalide.');
      }
    }

    if (currentStep === 4) {
      var passwordValue = fieldValue('password');
      var passwordConfirmValue = fieldValue('password_confirm');

      if (!passwordValue || passwordValue.length < 8) {
        invalidate('password', 'Le mot de passe doit contenir au moins 8 caracteres.');
      }

      if (!passwordConfirmValue) {
        invalidate('password_confirm', 'La confirmation du mot de passe est obligatoire.');
      } else if (passwordValue && passwordValue !== passwordConfirmValue) {
        invalidate('password_confirm', 'Les mots de passe ne correspondent pas.');
      }
    }

    if (currentStep === 5) {
      if (!fieldValue('certify_cgv')) {
        invalidate('certify_cgv', 'Vous devez certifier l acceptation des CGV.');
      }
    }

    if (errors.length) {
      showErrors(errors);
      if (firstInvalidField && typeof firstInvalidField.focus === 'function') {
        firstInvalidField.focus();
      }
      return false;
    }

    showErrors([]);
    return true;
  }

  function setStep(stepNumber) {
    currentStep = stepNumber;

    if (currentStepInput) {
      currentStepInput.value = String(currentStep);
    }

    updateProgressUI();

    steps.forEach(function (stepEl) {
      var step = Number(stepEl.getAttribute('data-step'));
      var isActive = step === currentStep;
      stepEl.hidden = !isActive;

      var fields = stepEl.querySelectorAll('input, select, textarea');
      Array.prototype.forEach.call(fields, function (field) {
        if (field.type === 'hidden') {
          return;
        }

        if (isActive) {
          field.removeAttribute('disabled');
        } else {
          field.setAttribute('disabled', 'disabled');
          field.classList.remove('is-invalid');
        }
      });
    });

    showErrors([]);
  }

  function updateProgressUI() {
    if (!progressRoot) {
      return;
    }

    var currentStepEl = form.querySelector('[data-step="' + currentStep + '"]');
    var currentTitle = '';

    if (currentStepEl) {
      currentTitle = currentStepEl.getAttribute('data-step-title') || '';
      if (!currentTitle) {
        var stepTitleEl = currentStepEl.querySelector('h2');
        currentTitle = stepTitleEl ? stepTitleEl.textContent.trim() : '';
      }
    }

    if (progressCurrentStep) {
      progressCurrentStep.textContent = String(currentStep);
    }

    if (progressStepTitle) {
      progressStepTitle.textContent = currentTitle;
    }

    if (progressFill) {
      progressFill.style.width = ((currentStep / totalSteps) * 100) + '%';
    }

    if (progressBar) {
      progressBar.setAttribute('aria-valuenow', String(currentStep));
    }
  }

  function buildPayload() {
    var payload = {};
    var fields = form.querySelectorAll('[name]');

    Array.prototype.forEach.call(fields, function (field) {
      var name = field.getAttribute('name');

      if (!name) {
        return;
      }

      if (
        name === 'csrf_token'
        || name === 'current_step'
        || name === 'b2block_register_payload'
        || name === 'b2block_register_submit'
      ) {
        return;
      }

      if (field.type === 'checkbox') {
        payload[name] = field.checked ? '1' : '';
        return;
      }

      payload[name] = field.value || '';
    });

    return payload;
  }

  form.addEventListener('click', function (event) {
    var nextButton = event.target.closest('[data-next-step]');
    if (nextButton) {
      event.preventDefault();

      if (validateCurrentStep() && currentStep < 5) {
        setStep(currentStep + 1);
      }

      return;
    }

    var prevButton = event.target.closest('[data-prev-step]');
    if (prevButton) {
      event.preventDefault();

      if (currentStep > 1) {
        setStep(currentStep - 1);
      }
    }
  });

  form.addEventListener('submit', function (event) {
    if (!validateCurrentStep()) {
      event.preventDefault();
      return;
    }

    if (payloadInput) {
      var payload = buildPayload();
      payload.current_step = String(currentStep);
      payloadInput.value = JSON.stringify(payload);
    }
  });

  setStep(currentStep);
}());
