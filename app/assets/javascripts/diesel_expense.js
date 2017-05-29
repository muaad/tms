function replaceNull(value) {
    return (value == null) ? "" : value
}

function refreshDieselTable(tbl, url, data) {
	$.ajax({
	    type: "POST",
	    url: url,
	    dataType: 'json',
	    // contentType: 'application/json',
	    data: data,
	    success: function(data, textStatus, jqXhr) {
	      var check = '<td class="sorting_1"><input type="checkbox" name="expense[expense.id]" id="expense_expense.id" value="' + data.id + '"></td>'
	      var date = '<td>' + replaceNull(data.date) + '</td>'
	      var lpo = '<td>' + data.lpo + '</td>'
	      var truck = '<td>' + data.truck + '</td>'
	      var company = '<td>' + data.entity + '</td>'
	      var quantity = '<td>' + replaceNull(data.quantity) + '</td>'
	      var unit_price = '<td>' + replaceNull(data.unit_price) + '</td>'
	      var amount = '<td>' + data.amount + '</td>'
	      var description = '<td>' + data.description + '</td>'
	      var currency = '<td>' + data.currency + '</td>'
	      $('#new-expenses-inline').after('<tr>' + check + date + lpo + truck + company + quantity + unit_price + amount + currency + description + '</tr>');
	      $('#total-expense').html(data.total_expense)
      	}
  	})
};
function price() {
	var company_id = $('select[id="diesel_companies"] :selected').val()
	if (company_id !== undefined) {
		$.get('/diesel_companies/' + company_id + '.json', function(data) {
			$('#expense_unit_price').val(data.price)
		});
	}
}

$(function() {
	// $('#toggle_expenses').change(function(e) {
	//   if (this.checked) {
	//     $('.expenses_table').checkboxes('check');
	//     e.preventDefault();
	//   }
	//   else {
	//     $('.expenses_table').checkboxes('uncheck');
	//     e.preventDefault();
	//   }
	// });

	// $('#delete-expenses').click(function(){
	//   if ($(".expenses_table input:checked").length < 1)
	//   {
	//     swal("You have not selected any expenses to be deleted.");
	//     return false;
	//   }
	//   else
	//   {
	//     expenses_array = []
	//     $(".expenses_table input:checked").each(function(){
	//       expenses_array.push($(this).attr('value'))
	//     });
	//     $('#delete_expenses').val(expenses_array);
	//     // contact_num = ("#expenses_table input:checked").length;
	//     $('#delete_expense_modal #lbl-msg').html('You are about to delete '+String(expenses_array.length)+' expenses');
	//     $('#delete_expense_modal')
	//     .modal('setting', {
	//       onApprove: function(){
	//         $(this).find('form').submit();
	//       }
	//     })
	//     .modal('show');
	//   }
	// });

	// $('#edit-expense').click(function(){
	//   if ($(".expenses_table input:checked").length < 1)
	//   {
	//     swal("You have not selected any expense to be edited.");
	//     return false;
	//   }
	//   else if ($(".expenses_table input:checked").length > 1)
	//   {
	//     swal("You have selected more than one expense. You can only edit one expense at a time.");
	//     return false;
	//   }
	//   else
	//   {
	//     expenses_array = []
	//     $(".expenses_table input:checked").each(function(){
	//       expenses_array.push($(this).attr('value'))
	//     });
	//   	var id = expenses_array[0];
	//   	document.location = '/expenses/' + id + '/edit'
	//   }
	// });

	if(window.location.pathname === "/diesel_expenses") {
		$('#new-diesel-expense').click(function(e) {
			e.preventDefault();
			if ($('#new-expenses-inline').length === 0) {
				$('.sidebar-toggle').click()
				// TODO:
				// Add date and discount √
				// Disable some fields for some categories
				// Calculate amount from fields
				// Fix bugs
				// Create record
				var check = '<td class="sorting_1"><input type="checkbox" name="expense[expense.id]" id="expense_expense.id" style="width: 100%;"></td>'
				var date = '<td><input class="form-control datepicker" type="text" name="expense[date]" id="expense_date" style="width: 100%;"></td>'
				var lpo = '<td><input class="form-control" type="text" name="expense[lpo]" id="expense_lpo" style="width: 80px;"></td>'
				var truck = '<td><select class="form-control" name="expense[truck_id]" id="expense_truck_id"></select></td>'
				var company = '<td><select id="diesel_companies" class="form-control" style="width: 100%;"></select></td>'
				var quantity = '<td><input class="form-control" type="text" name="expense[quantity]" id="expense_quantity" style="width: 80px;"></td>'
				var unit_price = '<td><input class="form-control" type="text" name="expense[unit_price]" id="expense_unit_price" style="width: 80px;"></td>'
				var amount = '<td><input class="form-control" type="text" name="expense[amount]" id="expense_amount" style="width: 100%;"></td>'
				var currency = '<td><select id="expense_currency" class="form-control" name="expense[currency]" style="width: 100%;"><option value="Kenya Shilling">Kenya Shilling</option><option value="US Dollar">US Dollar</option></select></td>'
				// var discount = '<td><input class="form-control" type="text" name="expense[discount]" id="expense_discount" style="width: 100%;"></td>'
				var description = '<td><input class="form-control" type="text" name="expense[description]" id="expense_description" style="width: 100%;"></td>'
				$('#example').prepend('<tr id="new-expenses-inline">' + check + date + lpo + truck + company + quantity + unit_price + amount + currency + description + '</tr>');

				$.get('/trucks.json', function(data) {
					for (var i = 0; i < data.length; i++) {
						$('select[id="expense_truck_id"]').append('<option value="' + data[i].id + '">' + data[i].registration_number + '</option>')
					};
				});
				$.get('/diesel_companies.json', function(data) {
					for (var i = 0; i < data.length; i++) {
						$('select[id="diesel_companies"]').append('<option value="' + data[i].id + '">' + data[i].name + '</option>')
					};
					$('select[id="diesel_companies"]').change();
				});
				$('.datepicker').datepicker();
			}
		})

		$(document).on('change', 'select[id="diesel_companies"]', function(e) {
			var company_id = $('select[id="diesel_companies"] :selected').val()
			if (company_id !== undefined) {
				$.get('/diesel_companies/' + company_id + '.json', function(data) {
					$('#expense_unit_price').val(data.price)
				});
			}
		});

		$(document).on('propertychange change click keyup input paste', '#expense_quantity, #expense_unit_price', function(e) {
			var amount = $('#expense_quantity').val() * $('#expense_unit_price').val();
			$('#expense_amount').val(amount);
		});

		// $('#expense_quantity, #expense_unit_price').on("propertychange change click keyup input paste", function(evt) {
		// 	var amount = $('#expense_quantity').val() * $('#expense_unit_price').val();
		// 	$('#expense_amount').val(amount);
		// })

		$(document).on('keypress', '#expense_description', function(e) {
		    if(e.which == 13 || e.which == 9) {
		    	// Check category and use the selected one to get the right entity to post
		    	var token = $('meta[name=csrf-token]').attr("content");
		    	var data = {
		    		"expense[lpo]": $('#expense_lpo').val(), 
		    		"expense_category": "Diesel",
		    		"diesel_company": $('#diesel_companies').val(),
		    		"expense[amount]": $('#expense_amount').val(), 
		    		"expense[currency]": $('#expense_currency').val(), 
		    		"expense[truck_id]": $('#expense_truck_id').val(), 
		    		"expense[description]": $('#expense_description').val(), 
		    		"expense[date]": $('#expense_date').val(), 
		    		"expense[quantity]": $('#expense_quantity').val(), 
		    		"expense[unit_price]": $('#expense_unit_price').val(), 
		    		authenticity_token: token
		    	}
		    	console.log(data)
		    	refreshDieselTable('#example', '/expenses/inline_create', data);
		    	$('#expense_lpo').val("")
		    	$('#expense_amount').val("")
		    	$('#expense_description').val("")
		    	$('#expense_quantity').val("")
		    }
		});
	}
});