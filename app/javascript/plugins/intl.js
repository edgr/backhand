import intlTelInput from 'intl-tel-input';

const input = document.querySelector("#user_phone_number");
const errorMsg = document.querySelector("#intl-error-msg");
const validMsg = document.querySelector("#intl-valid-msg");
const errorMap = ["Invalid number", "Invalid country code", "Too short", "Too long", "Invalid number"];

const iti = intlTelInput(input, {
  formatOnInit: true,
  separateDialCode: true,
  autoPlaceholder: "aggressive",
  preferredCountries: ['at', 'be', 'bg', 'cz', 'dk', 'de', 'ee', 'ie', 'el', 'es', 'fr', 'hr', 'it', 'cy', 'lv', 'lt', 'lu', 'hu', 'mt', 'nl', 'pl', 'pt', 'ro', 'si', 'sk', 'fi', 'se', 'uk'],
  initialCountry: "es",
});

const reset = function() {
  input.classList.remove("error");
  errorMsg.innerHTML = "";
  errorMsg.classList.add("hidden");
  validMsg.classList.add("hidden");
};

input.addEventListener('blur', function() {
  reset();
  if (input.value.trim()) {
    if (iti.isValidNumber()) {
    // do nothing if valid, let it pass
    } else {
      input.classList.add("error");
      var errorCode = iti.getValidationError();
      errorMsg.innerHTML = errorMap[errorCode];
      errorMsg.classList.remove("hidden");
    }
  }
});

input.addEventListener('change', reset);
input.addEventListener('keyup', reset);
