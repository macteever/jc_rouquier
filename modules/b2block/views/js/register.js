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

  if (currentStep < 1 || currentStep > 5) {
    currentStep = 1;
  }

  function setStep(stepNumber) {
    currentStep = stepNumber;

    if (currentStepInput) {
      currentStepInput.value = String(currentStep);
    }

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
        }
      });
    });
  }

  function validateCurrentStep() {
    var currentStepEl = form.querySelector('[data-step="' + currentStep + '"]');
    if (!currentStepEl) {
      return true;
    }

    var fields = currentStepEl.querySelectorAll('input, select, textarea');
    for (var i = 0; i < fields.length; i += 1) {
      var field = fields[i];
      if (field.type === 'hidden' || field.disabled) {
        continue;
      }

      field.setCustomValidity('');

      if (!field.checkValidity()) {
        field.reportValidity();
        return false;
      }
    }

    if (currentStep === 4) {
      var password = form.querySelector('#reg-password');
      var confirm = form.querySelector('#reg-password-confirm');

      if (password && confirm && password.value !== confirm.value) {
        confirm.setCustomValidity('Les mots de passe ne correspondent pas.');
        confirm.reportValidity();
        return false;
      }

      if (confirm) {
        confirm.setCustomValidity('');
      }
    }

    return true;
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
