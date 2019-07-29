import intlTelInput from 'intl-tel-input';
import $ from 'jquery';

const input = document.getElementById("user_phone_number");
const errorMsg = document.getElementById("error-msg");
const validMsg = document.getElementById("valid-msg");
const errorMap = ["Invalid number", "Invalid country code", "Too short", "Too long", "Invalid number"];

if (input) {
  const iti = intlTelInput(input, {
    initialCountry: "es",
    // formatOnInit: true,
    autoPlaceholder: "polite",
    preferredCountries: ['at', 'be', 'bg', 'cz', 'dk', 'de', 'ee', 'ie', 'el', 'es', 'fr', 'hr', 'it', 'cy', 'lv', 'lt', 'lu', 'hu', 'mt', 'nl', 'pl', 'pt', 'ro', 'si', 'sk', 'fi', 'se', 'uk'],
    utilsScript: "../../build/js/utils.js?1562189064761"
  });

  const reset = () => {
    input.classList.remove("error");
    errorMsg.innerHTML = "";
    errorMsg.classList.add("hide");
    validMsg.classList.add("hide");
  }

  input.addEventListener('blur', () => {
    reset();
    if (input.value.trim()) {
      if (iti.isValidNumber()) {
        validMsg.classList.remove("hide");
        input.value = iti.getNumber();
    } else {
      input.classList.add("error");
      const errorCode = iti.getValidationError();
      errorMsg.innerHTML = errorMap[errorCode];
      errorMsg.classList.remove("hide");
      }
    }
  });

  input.addEventListener('change', reset);
  input.addEventListener('keyup', reset);
}







