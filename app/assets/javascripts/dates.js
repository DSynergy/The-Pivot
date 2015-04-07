$.getScript("http://www.urimalo.com/assets/admin/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js", function(){
  var today = new Date();
  var FromEndDate = new Date();
  FromEndDate.setDate(today.getDate() + 30);

  var ToEndDate = new Date();
  ToEndDate.setDate(ToEndDate.getDate()+365);

  $('.from_date').datepicker({
    startDate: today,
    endDate: FromEndDate,
    autoclose: true,
  }).on('changeDate', function(selected){
    startDate = new Date(selected.date.valueOf());
    startDate.setDate(startDate.getDate(new Date(selected.date.valueOf())));
    $('.to_date').datepicker('setStartDate', startDate);
  });

  $('.to_date').datepicker({
    startDate: today,
    endDate: ToEndDate,
    autoclose: true
  })
  .on('changeDate', function(selected){
    FromEndDate = new Date(selected.date.valueOf());
    FromEndDate.setDate(FromEndDate.getDate(new Date(selected.date.valueOf())));
    $('.from_date').datepicker('setEndDate', FromEndDate);
  });
});


