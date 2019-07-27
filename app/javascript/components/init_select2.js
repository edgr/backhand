import 'select2';

const initSelect2 = () => {
  $('.select2').select2 ({
    theme: "bootstrap",
    width: '100%',
    placeholder: "If your club is not listed, let us know!",
    allowClear: true,
  });
};

export { initSelect2 };
