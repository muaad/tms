function replaceNull(value) {
    return (value == null) ? "" : value
}

function refreshTable(tbl, url, data) {
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
      var category = '<td>' + data.expense_category + '</td>'
      var truck = '<td>' + data.truck + '</td>'
      var entity = '<td>' + data.entity + '</td>'
      var quantity = '<td>' + replaceNull(data.quantity) + '</td>'
      var unit_price = '<td>' + replaceNull(data.unit_price) + '</td>'
      var amount = '<td>' + data.amount + '</td>'
      var description = '<td>' + data.description + '</td>'
      $('#new-expenses-inline').after('<tr>' + check + date + lpo + category + truck + entity + quantity + unit_price + amount + description + '</tr>');
      }
  	})
};

function loadAmount(category) {
	if (category == "Spare Parts") {
		$("#product_id").change(function() {
			var id = $("#product_id").val()
			$.get('/products/' + id + '.json', function(data) {
				$('#expense_amount').val(data.price)
			});
		})
	}
}

function loadCombos(category) {
	// console.log(category)
	if (category === "Driver Salary") {
		var driver = '<div class="form-group"><input type="hidden" id="which-entity" value="driver"><label for="expense_driver" id="entity-type">Driver</label><select id = "expense_driver" class="form-control" name="expense[driver_id]"></select></div>'
        $('.expense-reason').html(driver)
        $.get('/drivers.json', function(data) {
        	for (var i = 0; i < data.length; i++) {
        		$('select[id="expense_driver"]').append('<option value="' + data[i].id + '">' + data[i].name + '</option>')
        	};
        });
        $('select[id="expense_driver"]').change()
        var driver_id = $('#expense_driver').val()
        $('select[id="expense_driver"] option[value="'+ driver_id +'"]').attr('selected', 'selected');
        $('#expense_unit_price').prop('disabled', true);
        $('#expense_unit_price').val("");
        $('#expense_quantity').prop('disabled', true);
        $('#expense_quantity').val("");
        // var driverID = $('#expense_driver').val()
        // var truck = $('#expense_truck_id').val()
        // var url ='/drivers/' + $('#expense_driver').val() + '.json?truck=' + truck
        // $.get(url, function(data) {
        // 	$('#expense_amount').val(data.salary)
        // });
	} 
	else if (category === "TurnBoy Salary"){
		var turn_boy = '<div class="form-group"><input type="hidden" id="which-entity" value="turn_boy"><label for="expense_turn_boy" id="entity-type">Turn Boy</label><select id = "expense_turn_boy" class="form-control" name="expense[turn_boy_id]"></select></div>'
        $('.expense-reason').html(turn_boy)
        $.get('/turn_boys.json', function(data) {
        	for (var i = 0; i < data.length; i++) {
        		$('select[id="expense_turn_boy"]').append('<option value="' + data[i].id + '">' + data[i].name + '</option>')
        	};
        });
        $('select[id="expense_turn_boy"]').change()
       	var turn_boy_id = $('#expense_turn_boy').val()
       	$('select[id="expense_turn_boy"] option[value="'+ turn_boy_id +'"]').attr('selected', 'selected');
       	$('#expense_unit_price').prop('disabled', true);
       	$('#expense_unit_price').val("");
       	$('#expense_quantity').prop('disabled', true);
       	$('#expense_quantity').val("");
	}
	else if (category === "Diesel"){
		// var diesel_company = '<div class="form-group"><input type="hidden" id="which-entity" value="diesel_company"><label for="diesel_company_id" id="entity-type">Diesel Company</label><select id="diesel_company_id" class="form-control" name="diesel_company_id"></select></div>'
  //       $('.expense-reason').html(diesel_company)
  //       $.get('/diesel_companies.json', function(data) {
  //       	for (var i = 0; i < data.length; i++) {
  //       		$('#diesel_company_id').append('<option value="' + data[i].id + '">' + data[i].name + '</option>')
  //       	};
  //       });
  //       $('#diesel_company_id').change()
  //       $('#expense_unit_price').prop('disabled', false);
  //       $('#expense_quantity').prop('disabled', false);
	} 
	else if (category === "Spare parts"){
		$('#expense_unit_price').prop('disabled', false);
		$('#expense_quantity').prop('disabled', false);
		var product = '<div class="form-group"><input type="hidden" id="which-entity" value="product"><label for="product_id" id="entity-type">Spart Parts</label><select id="product_id" class="form-control" name="expense[product_id]"></select></div>'
		$('.expense-reason').html(product)
        $.get('/products.json?type=Spare parts', function(data) {
        	for (var i = 0; i < data.length; i++) {
        		$("select[id='product_id']").append('<option value="' + data[i].id + '">' + data[i].name + '</option>')
        	};
        });
        $("select[id='product_id']").change()

	}
	else {
		var otherCategory = '<div class="form-group"><input type="hidden" id="which-entity" value="otherCategory"><label for="otherCategory" id="entity-type">No options available</label><select id="otherCategory" class="form-control" name="expense[otherCategory]"></select></div>'
		$('.expense-reason').html(otherCategory)
	};
}

function loadSalary(category) {
	$.get('/trucks/' + $('select[id="expense_truck_id"]').val() + '.json', function(data) {
		if (category === "Driver Salary") {
			$('#expense_amount').val(data.driver_salary)
			$('select[id="expense_driver"] option[value="'+ data.driver.id +'"]').attr('selected', 'selected');
		}
		if (category === "TurnBoy Salary") {
			$('#expense_amount').val(data.turn_boy_salary)
			$('select[id="expense_turn_boy"] option[value="'+ data.turn_boy.id +'"]').attr('selected', 'selected');
		}
	})
}

function loadDetails(editPage) {
	$('#expense_category').change(function() {
		var category = $('select[id="expense_category"] :selected').html().trim();
		console.log(category)
		loadCombos(category);
		if (!editPage) {
			loadSalary(category);
			loadAmount(category);
		};
	})
	
	$('#expense_truck_id').change(function() {
		var category = $('select[id="expense_category"] :selected').html().trim();
		if (!editPage) {
			loadSalary(category);
		}
	})
}

function price(category) {
	if (category === "Diesel"){
		var company_id = $('select[id="diesel_company_id"] :selected').val()
		$.get('/diesel_companies/' + company_id + '.json', function(data) {
			$('#expense_unit_price').val(data.price)
		});
	}
	if (category === "Spare parts"){
		var product_id = $('select[id="product_id"] :selected').val()
		$.get('/products/' + product_id + '.json', function(data) {
			$('#expense_unit_price').val(data.price)
		});
	}
}

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
	    swal("You have not selected any expenses to be deleted.");
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
	    swal("You have not selected any expense to be edited.");
	    return false;
	  }
	  else if ($(".expenses_table input:checked").length > 1)
	  {
	    swal("You have selected more than one expense. You can only edit one expense at a time.");
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

	var truck_id = $('#expense_truck').val()
	$('select[id="expense_truck_id"] option[value="'+ truck_id +'"]').attr('selected', 'selected').change();

	var editPage = window.location.pathname.indexOf("edit") >= 0 && window.location.pathname.indexOf("/expenses") >= 0
	var editDieselPage = window.location.pathname.indexOf("edit") >= 0 && window.location.pathname.indexOf("diesel_expenses") >= 0
	if (window.location.pathname === "/expenses/new" || editPage) {
		if (editPage) {
			var truck_id = $('#expense_truck').val()
			$('select[id="expense_truck_id"] option[value="'+ truck_id +'"]').attr('selected', 'selected').change();
			var expense_category = $('#expense_category').val()
			$('select[id="expense_category"] option[value="'+ expense_category +'"]').attr('selected', 'selected').change();
			loadCombos($('select[id="expense_category"] :selected').html().trim());
			var expense_product = $('#expense_product').val()
			$('select[name="expense[product_id]"] option[value="'+ expense_product +'"]').attr('selected', 'selected').change();
		};
		loadDetails(editPage);
		$('#expense_quantity, #expense_unit_price').on("propertychange change click keyup input paste", function(evt) {
			var amount = $('#expense_quantity').val() * $('#expense_unit_price').val();
			$('#expense_amount').val(amount);
		})
	}
	if (window.location.pathname === "/diesel_expenses/new" || editDieselPage) {
		if (window.location.pathname === "/diesel_expenses/new") {
			price($("#diesel_company").val())
		};

		var company_id = $('#diesel-company').val()
		$('select[id="diesel_company"] option[value="'+ company_id +'"]').attr('selected', 'selected');

		var truck_id = $('#expense-truck').val()
		$('select[id="expense_truck_id"] option[value="'+ truck_id +'"]').attr('selected', 'selected');

		$('#diesel_company').change(function() {
			price($("#diesel_company").val());
		})

		$('#expense_quantity, #expense_unit_price').on("propertychange change click keyup input paste", function(evt) {
			var amount = $('#expense_quantity').val() * $('#expense_unit_price').val();
			$('#expense_amount').val(amount);
		})
	};

	if(window.location.pathname === "/expenses") {
		$('#new-expense').click(function(e) {
			e.preventDefault();
			if ($('#new-expenses-inline').length === 0) {
				$('.sidebar-toggle').click()
				// TODO:
				// Add date and discount √
				// Disable some fields for some categories
				// Calculate amount from fields
				// Fix bugs
				// Create record
				var check = '<td class="sorting_1"><input type="checkbox" name="expense[expense.id]" id="expense_expense.id" style="width: 15px;"></td>'
				var date = '<td><input class="form-control datepicker" type="text" name="expense[date]" id="expense_date" style="width: 100%;"></td>'
				var lpo = '<td><input class="form-control" type="text" name="expense[lpo]" id="expense_lpo" style="width: 80px;"></td>'
				var category = '<td><select class="form-control" name="expense[expense_category_id]" id="expense_category"></select></td>'
				var truck = '<td><select class="form-control" name="expense[truck_id]" id="expense_truck_id"></select></td>'
				var entity = '<td class="expense-reason"><select class="form-control" style="width: 100%;"></select></td>'
				var quantity = '<td><input class="form-control" type="text" name="expense[quantity]" id="expense_quantity" style="width: 80px;"></td>'
				var unit_price = '<td><input class="form-control" type="text" name="expense[unit_price]" id="expense_unit_price" style="width: 80px;"></td>'
				var amount = '<td><input class="form-control" type="text" name="expense[amount]" id="expense_amount" style="width: 100%;"></td>'
				// var discount = '<td><input class="form-control" type="text" name="expense[discount]" id="expense_discount" style="width: 100%;"></td>'
				var description = '<td><input class="form-control" type="text" name="expense[description]" id="expense_description" style="width: 100%;"></td>'
				$('#example').prepend('<tr id="new-expenses-inline">' + check + date + lpo + category + truck + entity + quantity + unit_price + amount + description + '</tr>');

				$.get('/trucks.json', function(data) {
					for (var i = 0; i < data.length; i++) {
						$('select[id="expense_truck_id"]').append('<option value="' + data[i].id + '">' + data[i].registration_number + '</option>')
					};
				});
				$.get('/expense_categories.json', function(data) {
					for (var i = 0; i < data.length; i++) {
						$('select[id="expense_category"]').append('<option value="' + data[i].id + '">' + data[i].name + '</option>')
					};
					$('select[id="expense_category"]').change();
				});
				$('.datepicker').datepicker();
			}
		})

		$(document).on('change', '#expense_category', function(e) {
			var category = $('select[id="expense_category"] :selected').html().trim();
			var entity_id = $('select[id="expense_category"] :selected').html().trim();
			loadCombos(category);
			$('label#entity-type').hide();
			loadSalary(category);
			// $('select[id="product_id"]').change();
			// console.log($('select[id="product_id"] :selected').val())
			// console.log(category)
			price(category);

			if (category === "Driver Salary" || category === "TurnBoy Salary") {
				
			};
		});

		$(document).on('change', '#expense_truck_id', function(e) {
			var category = $('select[id="expense_category"] :selected').html().trim();
			loadSalary(category);
		});

		$(document).on('change', '#diesel_company_id', function(e) {
			price("Diesel");
		});

		$(document).on('change', '#product_id', function(e) {
			price("Spare parts");
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
		    if(e.which == 13) {
		    	// Check category and use the selected one to get the right entity to post
		    	var token = $('meta[name=csrf-token]').attr("content");
		    	var category = $('#expense_category :selected').html();
		    	var entityKey = ""
		    	var entityValue = ""

		    	var data = {
		    		"expense[lpo]": $('#expense_lpo').val(), 
		    		"expense[expense_category_id]": $('#expense_category').val(), 
		    		"expense[amount]": $('#expense_amount').val(), 
		    		"expense[truck_id]": $('#expense_truck_id').val(), 
		    		"expense[product_id]": $("select[id='product_id']").val(), 
		    		"expense[description]": $('#expense_description').val(), 
		    		"expense[date]": $('#expense_date').val(), 
		    		"expense[quantity]": $('#expense_quantity').val(), 
		    		"expense[unit_price]": $('#expense_unit_price').val(), 
		    		authenticity_token: token
		    	}

		    	if (category === "Spare parts") {
		    		entityKey = "expense['product_id']"
		    		entityValue = $('#expense_product_id').val()
		    		data["expense['product_id']"] = $('#expense_product_id').val()
		    	}

		    	else if (category === "Driver Salary") {
		    		entityKey = "expense['driver_id']"
		    		entityValue = $('#expense_driver_id').val()
		    		data["expense['driver_id']"] = $('#expense_driver_id').val()
		    	}

		    	else if (category === "TurnBoy Salary") {
		    		entityKey = "expense['turn_boy_id']"
		    		entityValue = $('#expense_turn_boy_id').val()
		    		data["expense['turn_boy_id']"] = $('#expense_turn_boy_id').val()
		    	}
		    	console.log(data)
		    	refreshTable('#example', '/expenses/inline_create', data);
		    	$('#expense_lpo').val("")
		    	$('#expense_amount').val("")
		    	$('#expense_description').val("")
		    	$('#expense_quantity').val("")
		    }
		});
	}
});