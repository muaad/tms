// $(function() {
document.addEventListener("turbolinks:load", function() {
	$('#toggle_consignees').change(function(e) {
	  if (this.checked) {
	    $('.consignees_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.consignees_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-consignees').click(function(){
	  if ($(".consignees_table input:checked").length < 1)
	  {
	    swal("You have not selected any consignees to be deleted.");
	    return false;
	  }
	  else
	  {
	    consignees_array = []
	    $(".consignees_table input:checked").each(function(){
	      consignees_array.push($(this).attr('value'))
	    });
	    $('#delete_consignees').val(consignees_array);
	    // contact_num = ("#consignees_table input:checked").length;
	    $('#delete_consignee_modal #lbl-msg').html('You are about to delete '+String(consignees_array.length)+' consignees');
	    $('#delete_consignee_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-consignee').click(function(){
	  if ($(".consignees_table input:checked").length < 1)
	  {
	    swal("You have not selected any consignee to be edited.");
	    return false;
	  }
	  else if ($(".consignees_table input:checked").length > 1)
	  {
	    swal("You have selected more than one consignee. You can only edit one consignee at a time.");
	    return false;
	  }
	  else
	  {
	    consignees_array = []
	    $(".consignees_table input:checked").each(function(){
	      consignees_array.push($(this).attr('value'))
	    });
	  	var id = consignees_array[0];
	  	document.location = '/consignees/' + id + '/edit'
	  }
	});
});