$(function() {
	$('#toggle_turn_boys').change(function(e) {
	  if (this.checked) {
	    $('.turn_boys_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.turn_boys_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-turn_boys').click(function(){
	  if ($(".turn_boys_table input:checked").length < 1)
	  {
	    alert("You have not selected any turn boys to be deleted.");
	    return false;
	  }
	  else
	  {
	    turn_boys_array = []
	    $(".turn_boys_table input:checked").each(function(){
	      turn_boys_array.push($(this).attr('value'))
	    });
	    $('#delete_turn_boys').val(turn_boys_array);
	    // contact_num = ("#turn_boys_table input:checked").length;
	    $('#delete_turn_boy_modal #lbl-msg').html('You are about to delete '+String(turn_boys_array.length)+' turn boys');
	    $('#delete_turn_boy_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-turn_boy').click(function(){
	  if ($(".turn_boys_table input:checked").length < 1)
	  {
	    alert("You have not selected any turn boy to be edited.");
	    return false;
	  }
	  else if ($(".turn_boys_table input:checked").length > 1)
	  {
	    alert("You have selected more than one turn boy. You can only edit one turn boy at a time.");
	    return false;
	  }
	  else
	  {
	    turn_boys_array = []
	    $(".turn_boys_table input:checked").each(function(){
	      turn_boys_array.push($(this).attr('value'))
	    });
	  	var id = turn_boys_array[0];
	  	document.location = '/turn_boys/' + id + '/edit'
	  }
	});
});