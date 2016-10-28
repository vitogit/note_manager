$(function() {
  
  //update hidden field while writing to allow update note
  $("#main").on('keydown', '.content',  function(e) {
    var continue_keys_output = handleKeyPress(event, this);
    if (continue_keys_output) {
      var currentText = $(this).html()
      $(this).parent().parent().find('.hidden_text').val(currentText)
    }
    return continue_keys_output
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

  $("#container").on('click', '.tag_link', function(e) {
    search_tag($(this).text());
  })
  
  $("#container").on('click', '.tag_link_reset', function(e) {
    reset_filters() ;
  })
  
  function reset_filters() {
    $('#searcher').val("");
    $('#searcher').keyup();
    return false
  }
  
  function search_filter(tag_name) {
    $('#searcher').val(tag_name);
    $('#searcher').keyup();
    return false
  }
  
  function handleKeyPress(e, el) {
    var keyCode = e.keyCode || e.which;
    if (keyCode == '13'){
      console.log(el)
      // Enter pressed, add sibling
      $(el).parent().parent().find('.add_sibling_action').click()
      return false
    }
    if (keyCode == '9'){
      // Tab pressed, convert to children
      e.preventDefault()
      return false
    }   
    if (keyCode == '40'){
      // down arrow pressed, move down
      e.preventDefault()
      //self.moveDown(e)
      return false
    }      
    return true
  }  
  
});
