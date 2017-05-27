// $(function() {
document.addEventListener("turbolinks:load", function() {
	$('#toggle_truck_owners').change(function(e) {
	  if (this.checked) {
	    $('.truck_owners_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.truck_owners_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-truck_owners').click(function(){
	  if ($(".truck_owners_table input:checked").length < 1)
	  {
	    swal("You have not selected any truck owners to be deleted.");
	    return false;
	  }
	  else
	  {
	    truck_owners_array = []
	    $(".truck_owners_table input:checked").each(function(){
	      truck_owners_array.push($(this).attr('value'))
	    });
	    $('#delete_truck_owners').val(truck_owners_array);
	    // contact_num = ("#truck_owners_table input:checked").length;
	    $('#delete_truck_owner_modal #lbl-msg').html('You are about to delete '+String(truck_owners_array.length)+' truck owners');
	    $('#delete_truck_owner_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-truck_owner').click(function(){
	  if ($(".truck_owners_table input:checked").length < 1)
	  {
	    swal("You have not selected any truck owner to be edited.");
	    return false;
	  }
	  else if ($(".truck_owners_table input:checked").length > 1)
	  {
	    swal("You have selected more than one truck owner. You can only edit one truck owner at a time.");
	    return false;
	  }
	  else
	  {
	    truck_owners_array = []
	    $(".truck_owners_table input:checked").each(function(){
	      truck_owners_array.push($(this).attr('value'))
	    });
	  	var id = truck_owners_array[0];
	  	document.location = '/truck_owners/' + id + '/edit'
	  }
	});
});