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

const editPicker = document.querySelector(".datepicker-edit");

if (editPicker) {
  const birthdate = editPicker.getAttribute("age");
  if (birthdate === "") {
    flatpickr(".datepicker-edit", {
      altInput: true,
      altFormat: "j F Y",
      dateFormat: "d-m-Y",
    });
  } else {
    flatpickr(".datepicker-edit", {
      altInput: true,
      altFormat: "j F Y",
      dateFormat: "d-m-Y",
      defaultDate: new Date(birthdate)
    });
  }
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

const eventPicker = document.querySelector(".datepicker-event");

if (eventPicker) {
  flatpickr(".datepicker-event", {
    altInput: true,
    disableMobile: true,
    enableTime: true,
    defaultDate: new Date().fp_incr(1)
  });
}
