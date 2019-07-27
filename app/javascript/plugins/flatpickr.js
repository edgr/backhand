import flatpickr from 'flatpickr';
import 'flatpickr/dist/themes/material_blue.css';

flatpickr(".datepicker", {
  altInput: true,
  disableMobile: true,
  altFormat: "j F Y",
  dateFormat: "d-m-Y",
  defaultDate: "16-07-2007"
})
