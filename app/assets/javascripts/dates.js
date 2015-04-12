//add a data attribute on listings show page, pass listing id
//make an ajax get request to retrieve listing data and booking data
//parse response and get access to: start_date, end_date, unavailable_dates
//pluggin into the datepicker as available

$(document).ready(function(){

    var today = new Date();
    var FromEndDate = new Date();
    var ToEndDate = new Date();
    ToEndDate.setDate(ToEndDate.getDate()+ 365);
    FromEndDate.setDate(today.getDate());

  $('.from_date').datepicker({
      startDate: today,
//     startDate: '04/10/2015',
 //    endDate: '04/20/2015',
     datesDisabled: ["04/15/2015"]
  })

.on('changeDate', function(selected){
    startDate = new Date(selected.date.valueOf());
  startDate.setDate(startDate.getDate(new Date(selected.date.valueOf())));
 $('.to_date').datepicker('setStartDate', startDate);
 });

  $('.to_date').datepicker({
    startDate: today,
   // endDate: ToEndDate,
    autoclose: true
  })
  .on('changeDate', function(selected){
    FromEndDate = new Date(selected.date.valueOf());
    FromEndDate.setDate(FromEndDate.getDate(new Date(selected.date.valueOf())));
    $('.from_date').datepicker('setEndDate', FromEndDate);
  });
});

