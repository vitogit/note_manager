// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  
  //update hidden field while writing to allow update note
  $('.content').keyup(function(event){
    var currentText = $(this).html()
    $('.content').parent().find('.hidden_text').val(currentText)
  })

  $(".note").mouseover(function(e) {
    $(this).children('.actions').show();
    e.stopPropagation();
  }).mouseout(function(e) {
    $(this).children('.actions').hide();
  })
});
