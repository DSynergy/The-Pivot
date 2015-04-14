$(document).ready(function(){

    var today = new Date();
    var FromEndDate = new Date();
    var ToEndDate = new Date();
    ToEndDate.setDate(ToEndDate.getDate()+ 365);
    FromEndDate.setDate(today.getDate());

    var $dateForm = $('.date-select');
    var startDate = $dateForm.data('start-date');
    var endDate = $dateForm.data('end-date');

  $('.from_date').datepicker({
      startDate: today,
       endDate: endDate
  })

.on('changeDate', function(selected){
    startDate = new Date(selected.date.valueOf());
  startDate.setDate(startDate.getDate(new Date(selected.date.valueOf())));
 $('.to_date').datepicker('setStartDate', startDate);
 });

  $('.to_date').datepicker({
    startDate: today,
    autoclose: true
  })
  .on('changeDate', function(selected){
    FromEndDate = new Date(selected.date.valueOf());
    FromEndDate.setDate(FromEndDate.getDate(new Date(selected.date.valueOf())));
    $('.from_date').datepicker('setEndDate', FromEndDate);
  });
});

