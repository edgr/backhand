import flatpickr from 'flatpickr';
import 'flatpickr/dist/themes/material_blue.css';

const signupPicker = document.querySelector(".datepicker-signup");

if (signupPicker) {
  flatpickr(".datepicker-signup", {
    altInput: true,
    altFormat: "j F Y",
    dateFormat: "d-m-Y",
    defaultDate: "01-01-2000"
  });
}

const matchPicker = document.querySelector(".datepicker-match");

if (matchPicker) {
  flatpickr(".datepicker-match", {
    altInput: true,
    disableMobile: true,
    altFormat: "j F Y",
    dateFormat: "d-m-Y",
    defaultDate: "today"
  });
}
