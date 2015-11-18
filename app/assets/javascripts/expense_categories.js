$(function() {
	$('#toggle_expense_categories').change(function(e) {
	  if (this.checked) {
	    $('.expense_categories_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.expense_categories_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-expense_categories').click(function(){
	  if ($(".expense_categories_table input:checked").length < 1)
	  {
	    swal("You have not selected any expense_categories to be deleted.");
	    return false;
	  }
	  else
	  {
	    expense_categories_array = []
	    $(".expense_categories_table input:checked").each(function(){
	      expense_categories_array.push($(this).attr('value'))
	    });
	    $('#delete_expense_categories').val(expense_categories_array);
	    // contact_num = ("#expense_categories_table input:checked").length;
	    $('#delete_expense_category_modal #lbl-msg').html('You are about to delete '+String(expense_categories_array.length)+' expense categories');
	    $('#delete_expense_category_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-expense_category').click(function(){
	  if ($(".expense_categories_table input:checked").length < 1)
	  {
	    swal("You have not selected any expense category to be edited.");
	    return false;
	  }
	  else if ($(".expense_categories_table input:checked").length > 1)
	  {
	    swal("You have selected more than one expense_category. You can only edit one expense category at a time.");
	    return false;
	  }
	  else
	  {
	    expense_categories_array = []
	    $(".expense_categories_table input:checked").each(function(){
	      expense_categories_array.push($(this).attr('value'))
	    });
	  	var id = expense_categories_array[0];
	  	document.location = '/expense_categories/' + id + '/edit'
	  }
	});
});