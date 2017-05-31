function loadDieselPrice(company_id, priceField) {
	// var company_id = $('select[id="diesel_company_id"] :selected').val()
	if (company_id !== undefined) {
		$.get('/diesel_companies/' + company_id + '.json', function(data) {
			priceField.val(data.price)
		});
	}
}

$(function() {
	$('#toggle_trips').change(function(e) {
	  if (this.checked) {
	    $('.trips_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.trips_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-trips').click(function(){
	  if ($(".trips_table input:checked").length < 1)
	  {
	    swal("You have not selected any trips to be deleted.");
	    return false;
	  }
	  else
	  {
	    trips_array = []
	    $(".trips_table input:checked").each(function(){
	      trips_array.push($(this).attr('value'))
	    });
	    $('#delete_trips').val(trips_array);
	    // contact_num = ("#trips_table input:checked").length;
	    $('#delete_trip_modal #lbl-msg').html('You are about to delete '+String(trips_array.length)+' trips');
	    $('#delete_trip_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	var truck_id = $('#trip-truck').val()
	$('select[name="trip[truck_id]"] option[value="'+ truck_id +'"]').attr('selected', 'selected').change();

	var editPage = window.location.pathname.indexOf("edit") >= 0 && window.location.pathname.indexOf("trips") >= 0
	if (window.location.pathname === "/trips/new" || editPage) {
		if (editPage) {
			var truck_id = $('#trip-truck').val()
			$('select[name="trip[truck_id]"] option[value="'+ truck_id +'"]').attr('selected', 'selected').change();
			var consignee_id = $('#trip-consignee').val()
			$('select[name="trip[consignee_id]"] option[value="'+ consignee_id +'"]').attr('selected', 'selected').change();
			var depot_id = $('#trip-depot').val()
			$('select[name="trip[depot_id]"] option[value="'+ depot_id +'"]').attr('selected', 'selected').change();
			var destination_id = $('#trip-destination').val()
			$('select[name="trip[destination_id]"] option[value="'+ destination_id +'"]').attr('selected', 'selected').change();
			var product_id = $('#trip-product').val()
			$('select[name="trip[product_id]"] option[value="'+ product_id +'"]').attr('selected', 'selected').change();
		};
		$.get('/trucks/' + $('select[name="trip[truck_id]"]').val() + '.json', function(data) {
			$('select[name="trip[driver_id]"] option[value="'+ data.driver.id +'"]').attr('selected', 'selected');
			$('select[name="trip[turn_boy_id]"] option[value="'+ data.turn_boy.id +'"]').attr('selected', 'selected');
		})

		$('select[name="trip[truck_id]"]').change(function() {
			$.get('/trucks/' + $('select[name="trip[truck_id]"]').val() + '.json', function(data) {
				$('select[name="trip[driver_id]"] option[value="'+ data.driver.id +'"]').attr('selected', 'selected');
				$('select[name="trip[turn_boy_id]"] option[value="'+ data.turn_boy.id +'"]').attr('selected', 'selected');
			})
		})

		$.get('/products/' + $('select[name="trip[product_id]"]').val() + '.json', function(data) {
			$('#trip_rate').val(data.price);
		})

		$('select[name="trip[product_id]"]').change(function() {
			$.get('/products/' + $('select[name="trip[product_id]"]').val() + '.json', function(data) {
				$('#trip_rate').val(data.price);
			})
		})
	}

	$('#trip_quantity, #trip_rate').on("propertychange change click keyup input paste", function(evt) {
		var amount = $('#trip_quantity').val() * $('#trip_rate').val();
		$('#trip_amount').val(amount);
	})

	$(document).on('click', '#add_diesel', function() {
		var id = $(this).data('index') + 1
		$.get('/trips/diesel_expense', function(data) {
			$('#add_diesel').data('index', id)
			$('#diesel_expenses_section').append(data)
			var company_id = $(".diesel_company_id[data-index='" + id + "']").val()
			var priceField = $(".price_per_litre[data-index='" + id + "']")
			loadDieselPrice(company_id, priceField)
		})
	})

	$(document).on('click', '.remove_diesel_row', function() {
		var id = $(this).data('index')
		$('#row_' + id).hide('slow', function(){ $('#row_' + id).remove(); });
	})

	$(document).on("propertychange change click keyup input paste", '.no_of_litres, .price_per_litre', function(evt) {
		var index = $(evt.target).data('index')
		var litres = $(".no_of_litres[data-index='" + index + "']").val()
		var price = $(".price_per_litre[data-index='" + index + "']").val()
		var amount = litres * price
		$(".total_amount[data-index='" + index + "']").val(amount)
	})

	// $('#two_no_of_litres, #two_price_per_litre').on("propertychange change click keyup input paste", function(evt) {
	// 	var amount = $('#two_no_of_litres').val() * $('#two_price_per_litre').val();
	// 	$('#two_total_amount').val(amount);
	// })
	var company_id = $('.diesel_company_id').val()
	var index = $('.diesel_company_id').data('index')
	var priceField = $(".price_per_litre[data-index='" + index + "']")
	loadDieselPrice(company_id, priceField)
	$(document).on('change', '.diesel_company_id', function() {
		var company_id = $(this).val()
		var index = $(this).data('index')
		var priceField = $(".price_per_litre[data-index='" + index + "']")
		loadDieselPrice(company_id, priceField)
	})
	// loadDieselPrice($('#two_diesel_company_id').val(), $('#two_price_per_litre'))

	// $('#one_diesel_company_id').change(function() {
	// 	loadDieselPrice($('#one_diesel_company_id').val(), $('#one_price_per_litre'))
	// })

	// $('#two_diesel_company_id').change(function() {
	// 	loadDieselPrice($('#two_diesel_company_id').val(), $('#two_price_per_litre'))
	// })

	$('#edit-trip').click(function(){
	  if ($(".trips_table input:checked").length < 1)
	  {
	    swal("You have not selected any trip to be edited.");
	    return false;
	  }
	  else if ($(".trips_table input:checked").length > 1)
	  {
	    swal("You have selected more than one trip. You can only edit one trip at a time.");
	    return false;
	  }
	  else
	  {
	    trips_array = []
	    $(".trips_table input:checked").each(function(){
	      trips_array.push($(this).attr('value'))
	    });
	  	var id = trips_array[0];
	  	document.location = '/trips/' + id + '/edit'
	  }
	});
});
