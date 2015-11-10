function userRecord(element, data) {
	var userType = element.split("_")[0];
	$(element).each(function() {
	   var elem = $(this);

	   // Save current value of element
	   elem.data('oldVal', elem.val());

	   // Look for changes in the value
	   elem.bind("propertychange change click keyup input paste", function(event){
	      // If value has changed...
	      if (elem.data('oldVal') != elem.val()) {
	       // Updated stored value
	       var nameField = $(userType + '_name');
	       var addressField = $(userType + '_address');
	       var idField = $(userType + '_id_number');
	       var phoneField = $(userType + '_phone_number');
	       nameField.val("");
	       addressField.val("");
	       // idField.val("");
	       phoneField.val("");
	       elem.data('oldVal', elem.val());
	       var id = elem.data('oldVal');

	       for (var i = data.length - 1; i >= 0; i--) {
	       	if (data[i].id_number === id){
	       		record = data[i];
	       		if (record != null) {
	       			var nameField = $(userType + '_name');
	       			var addressField = $(userType + '_address');
	       			var idField = $(userType + '_id_number');
	       			var phoneField = $(userType + '_phone_number');
	       			nameField.val(record.name);
	       			addressField.val(record.address);
	       			idField.val(record.id_number);
	       			phoneField.val(record.phone_number);
	       			if (userType === "#owner") {
	       				var ownerType = record.entity_type
	       				$('select[name="owner_type"] option[value="'+ ownerType +'"]').attr('selected', 'selected');
	       			};
	       		}
	       	}
	       };
	     }
	   });
	});
}

$(function() {
	$('#toggle_trucks').change(function(e) {
	  if (this.checked) {
	    $('.trucks_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.trucks_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	var editPage = window.location.pathname.indexOf("edit") >= 0 && window.location.pathname.indexOf("trucks") >= 0
	if (window.location.pathname === "/trucks/new" || editPage) {
		$.get('/truck_owners.json', function(data) {
			userRecord('#owner_id_number', data);
		});
		$.get('/drivers.json', function(data) {
			userRecord('#driver_id_number', data);
		});
		$.get('/turn_boys.json', function(data) {
			userRecord('#turnboy_id_number', data);
		});
	}

	if (editPage) {
		var ownerType = $('#ownerType').attr('value')
		$('select[name="owner_type"] option[value="'+ ownerType +'"]').attr('selected', 'selected');
	};

	$('#delete-trucks').click(function(){
	  if ($(".trucks_table input:checked").length < 1)
	  {
	    alert("You have not selected any trucks to be deleted.");
	    return false;
	  }
	  else
	  {
	    trucks_array = []
	    $(".trucks_table input:checked").each(function(){
	      trucks_array.push($(this).attr('value'))
	    });
	    $('#delete_trucks').val(trucks_array);
	    // contact_num = ("#trucks_table input:checked").length;
	    $('#delete_truck_modal #lbl-msg').html('You are about to delete '+String(trucks_array.length)+' trucks');
	    $('#delete_truck_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-truck').click(function(){
	  if ($(".trucks_table input:checked").length < 1)
	  {
	    alert("You have not selected any truck to be edited.");
	    return false;
	  }
	  else if ($(".trucks_table input:checked").length > 1)
	  {
	    alert("You have selected more than one truck. You can only edit one truck at a time.");
	    return false;
	  }
	  else
	  {
	    trucks_array = []
	    $(".trucks_table input:checked").each(function(){
	      trucks_array.push($(this).attr('value'))
	    });
	  	var id = trucks_array[0];
	  	document.location = '/trucks/' + id + '/edit'
	  }
	});

	$('.document-link').imgPreview({
	    containerID: 'imgPreviewWithStyles',
	    imgCSS: {
	        // Limit preview size:
	        height: 200
	    },
	    // When container is shown:
	    onShow: function(link){
	        // Animate link:
	        $(link).stop().animate({opacity:0.4});
	        // Reset image:
	        $('img', this).stop().css({opacity:0});
	    },
	    // When image has loaded:
	    onLoad: function(){
	        // Animate image
	        $(this).animate({opacity:1}, 300);
	    },
	    // When container hides: 
	    onHide: function(link){
	        // Animate link:
	        $(link).stop().animate({opacity:1});
	    }
	});
});