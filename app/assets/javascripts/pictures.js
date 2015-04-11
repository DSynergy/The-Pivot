$(document).ready(function(){
  $('li img').on('click',function(){
    var src = $(this).attr('src');
    var img = '<img src="' + src + '" class="img-responsive"/>';
    var left = '<a> < </a>';
    var right = '<a class="right-arrow"> > </a>';
    $('#modal-gallery').modal();
    $('#modal-gallery').on('shown.bs.modal', function(){
      $('#modal-gallery .modal-body').html([img, left, right]);
    });
  });
})
