$(document).ready(function() {
  $('input.datetime').daterangepicker({
    singleDatePicker: true,
    timePicker: true,
    startDate: moment().startOf('hour'),
    endDate: moment().startOf('hour').add(32, 'hour'),
    locale: {
      format: 'M/DD hh:mm A'
    }
  });

  var offset = new Date().getTimezoneOffset() * 60;
  for (let element of $(".offset")) {
    element.val(offset);
  }
})
