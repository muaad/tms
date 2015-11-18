function loadAmount() {
	$('#expense_driver, #expense_truck_id').change(function() {
		var id = $('#expense_driver').val()
		var truck = $('#expense_truck_id').val()
		$.get('/drivers/' + id + '.json?truck=' + truck, function(data) {
			$('#expense_amount').val(data.salary)
		});
	})
	$('#expense_turn_boy').change(function() {
		var id = $('#expense_turn_boy').val()
		$.get('/turn_boys/' + id + '.json', function() {
			
		});
	})
	$('#diesel_company_id').change(function() {
		var id = $('#diesel_company_id').val()
		$.get('/diesel_companies/' + id + '.json', function() {
			
		});
	})
	$("#product_id").change(function() {
		var id = $("#product_id").val()
		$.get('/products/' + id + '.json', function() {
			
		});
	})
}

function loadCombos(category) {
	if (category === "Driver Salary") {
		var driver = '<div class="form-group"><label for="expense_driver">Driver</label><select id = "expense_driver" class="form-control" name="expense[driver_id]"></select></div>'
        $('.expense-reason').html(driver)
        $.get('/drivers.json', function(data) {
        	for (var i = 0; i < data.length; i++) {
        		$('#expense_driver').append('<option value="' + data[i].id + '">' + data[i].name + '</option>')
        	};
        });
        var driver_id = $('#expense_driver').val()
        $('select[id="expense_driver"] option[value="'+ driver_id +'"]').attr('selected', 'selected');
        // var driverID = $('#expense_driver').val()
        // var truck = $('#expense_truck_id').val()
        // var url ='/drivers/' + $('#expense_driver').val() + '.json?truck=' + truck
        // $.get(url, function(data) {
        // 	$('#expense_amount').val(data.salary)
        // });
	} 
	else if (category === "TurnBoy Salary"){
		var turn_boy = '<div class="form-group"><label for="expense_turn_boy">Turn Boy</label><select id = "expense_turn_boy" class="form-control" name="expense[turn_boy_id]"></select></div>'
        $('.expense-reason').html(turn_boy)
        $.get('/turn_boys.json', function(data) {
        	for (var i = 0; i < data.length; i++) {
        		$('#expense_turn_boy').append('<option value="' + data[i].id + '">' + data[i].name + '</option>')
        	};
        });
	} 
	// else if (category === "Diesel"){
	// 	var diesel_company = '<div class="form-group"><label for="diesel_company_id">Diesel Company</label><select id="diesel_company_id" class="form-control" name="diesel_company_id"></select></div>'
 //        $('.expense-reason').html(diesel_company)
 //        $.get('/diesel_companies.json', function(data) {
 //        	for (var i = 0; i < data.length; i++) {
 //        		$('#diesel_company_id').append('<option value="' + data[i].id + '">' + data[i].name + '</option>')
 //        	};
 //        });
	// } 
	else if (category === "Spare parts"){
		var product = '<div class="form-group"><label for="product_id">Spart Parts</label><select id="product_id" class="form-control" name="expense[product_id]"></select></div>'
		$('.expense-reason').html(product)
        $.get('/products.json?type=Spare parts', function(data) {
        	for (var i = 0; i < data.length; i++) {
        		console.log(i)
        		$("#product_id").append('<option value="' + data[i].id + '">' + data[i].name + '</option>')
        	};
        });
	};
}

function loadDetails(editPage) {
	$('#expense_truck_id').change(function() {
		console.log('truck changed')
		$.get('/trucks/' + $('#expense_truck_id').val() + '.json', function(data) {
			$('#expense_amount').val(data.driver_salary)
			$('select[id="expense_driver"] option[value="'+ data.driver.id +'"]').attr('selected', 'selected');
			// $('select[name="expense[trip_id]"]').html('')
			// for (var i = 0; i < data.trips.length; i++) {
			// 	var tripName = data.registration_number + " - " + data.trips[i].date
			// 	$('select[name="expense[trip_id]"]').append('<option value="' + data.trips[i].id + '">' + tripName + '</option>');
			// };
		})
		// loadAmount();
	})

	$('#expense_category').change(function() {
		console.log('category changed')
		var category = $('#expense_category :selected').html().trim();
		loadCombos(category);
		if (!editPage) {
			loadAmount();
		};
	})
}

function price(company_id) {
	$.get('/diesel_companies/' + company_id + '.json', function(data) {
		$('#expense_unit_price').val(data.price)
	});
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
});