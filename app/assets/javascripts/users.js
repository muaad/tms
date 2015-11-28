$(function() {
	$('#toggle_users').change(function(e) {
	  if (this.checked) {
	    $('.users_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.users_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-users').click(function(){
	  if ($(".users_table input:checked").length < 1)
	  {
	    swal("You have not selected any users to be deleted.");
	    return false;
	  }
	  else
	  {
	    users_array = []
	    $(".users_table input:checked").each(function(){
	      users_array.push($(this).attr('value'))
	    });
	    $('#delete_users').val(users_array);
	    // contact_num = ("#users_table input:checked").length;
	    $('#delete_user_modal #lbl-msg').html('You are about to delete '+String(users_array.length)+' users');
	    $('#delete_user_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-user').click(function(){
	  if ($(".users_table input:checked").length < 1)
	  {
	    swal("You have not selected any user to be edited.");
	    return false;
	  }
	  else if ($(".users_table input:checked").length > 1)
	  {
	    swal("You have selected more than one user. You can only edit one user at a time.");
	    return false;
	  }
	  else
	  {
	    users_array = []
	    $(".users_table input:checked").each(function(){
	      users_array.push($(this).attr('value'))
	    });
	  	var id = users_array[0];
	  	document.location = '/users/' + id + '/edit'
	  }
	});
});