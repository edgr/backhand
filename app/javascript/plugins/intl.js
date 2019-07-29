import intlTelInput from 'intl-tel-input';

const input = document.querySelector("#user_phone_number");
if (input) {
  intlTelInput(input, {
    formatOnInit: true,
    separateDialCode: true,
    autoPlaceholder: "aggressive",
    onlyCountries: ['at', 'be', 'bg', 'cz', 'dk', 'de', 'ee', 'ie', 'el', 'es', 'fr', 'hr', 'it', 'cy', 'lv', 'lt', 'lu', 'hu', 'mt', 'nl', 'pl', 'pt', 'ro', 'si', 'sk', 'fi', 'se', 'uk'],
    initialCountry: "es",
  });
}

