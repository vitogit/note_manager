$(function() {

  $("#main").on('keydown', '.content',  function(event) {
    return handleKeyPress(event, this);
  })

  //update hidden field while writing to allow update note
  $("#main").on('keyup', '.content',  function(event) {
    var currentText = $(this).text().trim()
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

  //handle letters(keyup) and delete(keydown)
  $('#searcher').on('keydown keyup', function(e) {
    handleSearch(this)
  });

  $("#container").on('click', '.tag_link', function(e) {
    e.preventDefault()
    search_tag($(this).text());
  })

  $("#container").on('click', '.tag_link_reset', function(e) {
    e.preventDefault()
    reset_filters() ;
  })

  function reset_filters() {
    $('#searcher').val("");
    $('#searcher').keyup();
    return false
  }

  function search_tag(tag_name) {
    $('#searcher').val(tag_name);
    $('#searcher').keyup();
    return false
  }

  function handleKeyPress(e, el) {
    var keyCode = e.keyCode || e.which;
    var shiftKey = e.shiftKey;
    console.log("keyCode________"+keyCode)
    if (keyCode == '13'){
      // Enter pressed, add sibling
      $(el).parent().parent().find('.add_sibling_action').click()
      updateNote(el)
      return false
    }

    if ($(el).text()=="" && keyCode == '8'){
      // delete pressed and is empty, delete
      destroyNote(el)
      return false
    }
    
    if (shiftKey && keyCode == '9'){
      // Shift+Tab pressed, convert to sibling
      e.preventDefault()
      updateNote(el)
      setUpperSibling($(el).parents('.note'))
      return false
    }

    if (keyCode == '9'){
      updateNote(el)
      // Tab pressed, convert to children
      e.preventDefault()
      setUpperParent($(el).parents('.note'))
      return false
    }

    if (keyCode == '38'){
      // up arrow pressed, move up
      e.preventDefault()
      moveUp(el);
      return false
    }
    
    if (keyCode == '40'){
      // down arrow pressed, move down
      e.preventDefault()
      moveDown(el)
      return false
    }
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
  
  function destroyNote(el) {
    $(el).parent().parent().find('.destroy_action').click()
  }
  
  function moveDown(el) {
    var current_note = $(el).closest('.note').first();
    var next_note = current_note.next()
    if (next_note.length) {
      next_note.find('.content').first().focus();
    } else {
      current_note.find('.note').first().find('.content').first().focus()
    }
  }

  function moveUp(el) {
    var current_note = $(el).closest('.note').first();
    var prev_note = current_note.prev()
    if (prev_note.length) {
      prev_note.find('.content').first().focus();
    } else {
      current_note.parents('.note').first().find('.content').first().focus()
    }
  }


  function handleSearch(el) {
    var currentText = $(el).val()
    $( ".note" ).each(function( index ) {
      var content = $(this).find('.content').text()
      if (content && content.indexOf(currentText) >= 0) {
        $(this).show()
        $(this).parents().show()
      } else {
        $(this).hide()
      }
    });
  }
});
