$(document).ready(function(){
  $('li img').on('click',function(){
    var src = $(this).attr('src');
    var img = '<img src="' + src + '" class="img-responsive"/>';
    var index = $(this).parent('li').index();
    var html = '';
    html += img;
    html += '<div style="height:25px;clear:both;display:block;">';
    html += '<a class="controls previous" href="' + (index) + '">&laquo; prev</a>';
    html += '<a style="margin-left:404px;" class="controls next" href="'+ (index+2) + '">next &raquo;</a>';
    html += '</div>';

    $('#modal-gallery').modal();
    $('#modal-gallery').on('shown.bs.modal', function(){
      $('#modal-gallery .modal-body').html(html);
    })
    $('#modal-gallery').on('hidden.bs.modal', function(){
      $('#modal-gallery .modal-body').html('');
    });
  });
})

$(document).on('click', 'a.controls', function(){
  var index = $(this).attr('href');
  var src = $('ol li:nth-child('+ index +') img').attr('src');
  $('.modal-body img').attr('src', src);

  var newPrevIndex = parseInt(index) - 1;
  var newNextIndex = parseInt(newPrevIndex) + 2;

  if($(this).hasClass('previous')){
    $(this).attr('href', newPrevIndex);
    $('a.next').attr('href', newNextIndex);
  }else{
    $(this).attr('href', newNextIndex);
    $('a.previous').attr('href', newPrevIndex);
  }
  return false;
});

