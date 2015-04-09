//add a data attribute on listings show page, pass listing id
//make an ajax get request to retrieve listing data and booking data
//parse response and get access to: start_date, end_date, unavailable_dates
//pluggin into the datepicker as available

$(document).ready(function(){
  $('.from_date').datepicker({
     startDate: '04/10/2015',
     endDate: '04/20/2015',
     datesDisabled: ["04/15/2015"]
  });

  $('.to_date').datepicker({

  });
});

  //var today = new Date();
  //var FromEndDate = new Date();
  //FromEndDate.setDate(today.getDate() + 365);

  //var ToEndDate = new Date();
  //ToEndDate.setDate(ToEndDate.getDate()+365);

  //var leftArrow = $('th.next');
  //var rightArrow = $('th.prev');

  //$('.from_date').on("click", function() {
  //  $('th.next').html('<p>></p>')
  //  $('th.prev').html('<p><</p>')
  //});

  //$('.to_date').on("click", function() {
  //  $('th.next').html('<p>></p>')
  //  $('th.prev').html('<p><</p>')
  //});


  //$('.from_date').datepicker({
  //  datesDisabled: ['04/06/2015', '04/21/2015'],
  //  startDate: today,
  //  endDate: FromEndDate,
  //  autoclose: true,
  //}).on('changeDate', function(selected){
  //  //startDate = new Date(selected.date.valueOf());
  //  //startDate.setDate(startDate.getDate(new Date(selected.date.valueOf())));
  //  //$('.to_date').datepicker('setStartDate', startDate);
  //});

  //$('.to_date').datepicker({
  //  startDate: today,
  //  endDate: ToEndDate,
  //  autoclose: true
  //})
  //.on('changeDate', function(selected){
  //  FromEndDate = new Date(selected.date.valueOf());
  //  FromEndDate.setDate(FromEndDate.getDate(new Date(selected.date.valueOf())));
  //  $('.from_date').datepicker('setEndDate', FromEndDate);
  //});
