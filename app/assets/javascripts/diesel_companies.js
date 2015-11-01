$(function() {
	$('#toggle_diesel_companies').change(function(e) {
	  if (this.checked) {
	    $('.diesel_companies_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.diesel_companies_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-diesel_companies').click(function(){
	  if ($(".diesel_companies_table input:checked").length < 1)
	  {
	    alert("You have not selected any diesel companies to be deleted.");
	    return false;
	  }
	  else
	  {
	    diesel_companies_array = []
	    $(".diesel_companies_table input:checked").each(function(){
	      diesel_companies_array.push($(this).attr('value'))
	    });
	    $('#delete_diesel_companies').val(diesel_companies_array);
	    // contact_num = ("#diesel_companies_table input:checked").length;
	    $('#delete_diesel_company_modal #lbl-msg').html('You are about to delete '+String(diesel_companies_array.length)+' diesel companies');
	    $('#delete_diesel_company_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-diesel_company').click(function(){
	  if ($(".diesel_companies_table input:checked").length < 1)
	  {
	    alert("You have not selected any diesel company to be edited.");
	    return false;
	  }
	  else if ($(".diesel_companies_table input:checked").length > 1)
	  {
	    alert("You have selected more than one diesel company. You can only edit one diesel company at a time.");
	    return false;
	  }
	  else
	  {
	    diesel_companies_array = []
	    $(".diesel_companies_table input:checked").each(function(){
	      diesel_companies_array.push($(this).attr('value'))
	    });
	  	var id = diesel_companies_array[0];
	  	document.location = '/diesel_companies/' + id + '/edit'
	  }
	});
});