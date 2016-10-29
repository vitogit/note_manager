$(function() {

  $("#main").on('keydown', '.content',  function(event) {
    return handleKeyPress(event, this);
  })

  //update hidden field while writing to allow update note
  $("#main").on('keyup', '.content',  function(event) {
      var currentText = $(this).html()
      $(this).parent().parent().find('.hidden_text').val(currentText)
  })

  $("#main").on('blur', '.content',  function(event) {
      updateNote(this)
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
    var shiftKey = e.shiftKey;

    if (keyCode == '13'){
      // Enter pressed, add sibling
      $(el).parent().parent().find('.add_sibling_action').click()
      updateNote(el)
      return false
    }
    if (shiftKey && keyCode == '9'){
      console.log('shiftab')
      // Shift+Tab pressed, convert to sibling
      e.preventDefault()
      updateNote(el)
      setUpperSibling($(el).parents('.note'))
      return false
    }

    if (keyCode == '9'){
      console.log('tab')
      updateNote(el)

      // Tab pressed, convert to children
      e.preventDefault()
      setUpperParent($(el).parents('.note'))
      return false
    }


    if (keyCode == '40'){
      // down arrow pressed, move down
      updateNote(el)
      e.preventDefault()
      //self.moveDown(e)
      return false
    }
    return true
  }

  function setUpperParent(current_note) {
    var current_id = current_note.data('id')
    var parent_id = current_note.prev().data('id')

    $.get('/note/'+current_id+'/change_parent/'+parent_id);
  }

  function setUpperSibling(current_note) {
    var current_id = current_note.data('id')
    $.get('/note/'+current_id+'/change_to_sibling');
  }

  function updateNote(el) {
    $(el).parent().parent().find('.update_action').click()
  }
});
