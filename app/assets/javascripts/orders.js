$(document).ready(function () {

  var $orders = $('.order');
  $('#order_filter_status').on('change', function() {
    var currentStatus = this.value;

    if(currentStatus == "all") {
      $orders.show();
    } else {
      $orders.each(function(index, order) {
        $order = $(order);
        if ($order.data('status') == currentStatus) {
          $order.show();
        } else {
          $order.hide();
        }
      });
    }
  });

});
