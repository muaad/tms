$(function() {
	$('#toggle_expenses').change(function(e) {
	  if (this.checked) {
	    $('.expenses_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.expenses_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-expenses').click(function(){
	  if ($(".expenses_table input:checked").length < 1)
	  {
	    alert("You have not selected any expenses to be deleted.");
	    return false;
	  }
	  else
	  {
	    expenses_array = []
	    $(".expenses_table input:checked").each(function(){
	      expenses_array.push($(this).attr('value'))
	    });
	    $('#delete_expenses').val(expenses_array);
	    // contact_num = ("#expenses_table input:checked").length;
	    $('#delete_expense_modal #lbl-msg').html('You are about to delete '+String(expenses_array.length)+' expenses');
	    $('#delete_expense_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-expense').click(function(){
	  if ($(".expenses_table input:checked").length < 1)
	  {
	    alert("You have not selected any expense to be edited.");
	    return false;
	  }
	  else if ($(".expenses_table input:checked").length > 1)
	  {
	    alert("You have selected more than one expense. You can only edit one expense at a time.");
	    return false;
	  }
	  else
	  {
	    expenses_array = []
	    $(".expenses_table input:checked").each(function(){
	      expenses_array.push($(this).attr('value'))
	    });
	  	var id = expenses_array[0];
	  	document.location = '/expenses/' + id + '/edit'
	  }
	});
});