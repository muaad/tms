function switchOwners(ownerType, ownerID) {
	var owner = ownerType.slice(0,-1);
	var lbl = '<label id="owner_type_label" for="attachment_' + owner + '_id">' + $('#attachment_type :selected').html() + '</label>'
	var slct = '<select class="form-control" id="attachment_owner_list" name="attachment[' + owner + '_id]"></select>'
	$('#attachment_owner').html(lbl + slct)
	$.get('/' + ownerType + '.json', function(data) {
		for (var i = 0; i < data.length; i++) {
			if (ownerType === "trucks") {
				var name = data[i].registration_number;
			} else{
				var name = data[i].name;
			};
			$('#attachment_owner_list').append('<option value=' + data[i].id + '>' + name + '</option>')
		};
	})
	if (ownerID != 0) {
		$('#attachment_type option[value="'+ ownerType +'"]').attr('selected', 'selected');
		$('#attachment_owner_list option[value="'+ ownerID +'"]').attr('selected', 'selected');
		$('#owner_type_label').html($('#attachment_type :selected').html())
	};
}

$(function() {
	var editPage = window.location.pathname.indexOf("edit") >= 0 && window.location.pathname.indexOf("attachments") >= 0
	var ownerType = $('#ownerType').val();
	var ownerID = $('#ownerID').val();
	if (editPage || (ownerType != null && ownerID != null)) {
		$('#attachment_owner_list option[value="'+ $('#ownerID').val() +'"]').attr('selected', 'selected');
		switchOwners(ownerType, ownerID);
	}
	if (window.location.pathname === "/attachments/new") {
		$('#attachment_type').change(function() {
			switchOwners($('#attachment_type').val(), 0);
		})
	}

	$('#update_expiry').click(function(e){
		e.preventDefault();
		$('#attachment_id').val($('#fix_expiry').data("attachment"))
	  $.ajax({
  	  type: "PUT",
  	  url: "/attachments/" + $('#attachment_id').val() + ".json",
  	  dataType: 'json',
  	  data: {"attachment[date_of_expiry]": $('#attachment_date_of_expiry').val()},
  	  success: function(data, textStatus, jqXhr) {
  	    location.reload();
  	  }
  	});
	});
});
