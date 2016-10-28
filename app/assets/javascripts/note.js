$(function() {

  //update hidden field while writing to allow update note
  $('.content').keyup(function(event){
    var currentText = $(this).html()
    $(this).parent().parent().find('.hidden_text').val(currentText)
  })

  $("#main").on('mouseover', '.note .row',  function(e) {
    $(this).children('.actions').show();
    e.stopPropagation();
  })

  $("#main").on('mouseout', '.note .row', function(e) {
    $(this).children('.actions').hide();
  })

  $('#searcher').keyup(function(event){
    var currentText = $(this).val()
    $( ".note" ).each(function( index ) {
      var content = $(this).find('.content').html()
      if (content && content.indexOf(currentText) >= 0) {
        $(this).show()
        $(this).parents().show()
      } else {
        $(this).hide()
      }
    });
  })
  
});
