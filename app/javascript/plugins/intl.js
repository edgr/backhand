import intlTelInput from 'intl-tel-input';

const input = document.querySelector("#user_phone_number");
if (input) {
  intlTelInput(input);
}

