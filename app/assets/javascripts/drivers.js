$(function() {
	$('#toggle_drivers').change(function(e) {
	  if (this.checked) {
	    $('.drivers_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.drivers_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-drivers').click(function(){
	  if ($(".drivers_table input:checked").length < 1)
	  {
	    alert("You have not selected any drivers to be deleted.");
	    return false;
	  }
	  else
	  {
	    drivers_array = []
	    $(".drivers_table input:checked").each(function(){
	      drivers_array.push($(this).attr('value'))
	    });
	    $('#delete_drivers').val(drivers_array);
	    // contact_num = ("#drivers_table input:checked").length;
	    $('#delete_driver_modal #lbl-msg').html('You are about to delete '+String(drivers_array.length)+' drivers');
	    $('#delete_driver_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-driver').click(function(){
	  if ($(".drivers_table input:checked").length < 1)
	  {
	    alert("You have not selected any driver to be edited.");
	    return false;
	  }
	  else if ($(".drivers_table input:checked").length > 1)
	  {
	    alert("You have selected more than one driver. You can only edit one driver at a time.");
	    return false;
	  }
	  else
	  {
	    drivers_array = []
	    $(".drivers_table input:checked").each(function(){
	      drivers_array.push($(this).attr('value'))
	    });
	  	var id = drivers_array[0];
	  	document.location = '/drivers/' + id + '/edit'
	  }
	});
});