// function refreshTable(tbl, url, data) {
// 	$.ajax({
//     type: "POST",
//     url: url,
//     dataType: 'json',
//     // contentType: 'application/json',
//     data: data,
//     success: function(data, textStatus, jqXhr) {
//     	console.log(data)
//       var check = '<td class="sorting_1"><input type="checkbox" name="user[user.id]" id="user_user.id" value="' + data.id + '"></td>'
//       var name = '<td>' + data.name + '</td>'
//       var email = '<td>' + data.email + '</td>'
//       var admin = '<td>' + data.is_admin + '</td>'
//       $('#example').prepend('<tr>' + check + name + email + admin + '</tr>');
//       }
//   })
// };
  

$(function() {
	$('#toggle_users').change(function(e) {
	  if (this.checked) {
	    $('.users_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.users_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-users').click(function(){
	  if ($(".users_table input:checked").length < 1)
	  {
	    swal("You have not selected any users to be deleted.");
	    return false;
	  }
	  else
	  {
	    users_array = []
	    $(".users_table input:checked").each(function(){
	      users_array.push($(this).attr('value'))
	    });
	    $('#delete_users').val(users_array);
	    // contact_num = ("#users_table input:checked").length;
	    $('#delete_user_modal #lbl-msg').html('You are about to delete '+String(users_array.length)+' users');
	    $('#delete_user_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-user').click(function(){
	  if ($(".users_table input:checked").length < 1)
	  {
	    swal("You have not selected any user to be edited.");
	    return false;
	  }
	  else if ($(".users_table input:checked").length > 1)
	  {
	    swal("You have selected more than one user. You can only edit one user at a time.");
	    return false;
	  }
	  else
	  {
	    users_array = []
	    $(".users_table input:checked").each(function(){
	      users_array.push($(this).attr('value'))
	    });
	  	var id = users_array[0];
	  	document.location = '/users/' + id + '/edit'
	  }
	});

	$('#new-user').click(function(e) {
		e.preventDefault();
		var check = '<td class="sorting_1"><input type="checkbox" name="user[user.id]" id="user_user.id"></td>'
		var name = '<td><input class="form-control" type="text" name="user[name]" id="user_name"></td>'
		var email = '<td><input class="form-control" type="email" value="" name="user[email]" id="user_email"></td>'
		var admin = '<td><div class="checkbox"><label><input name="user[is_admin]" id="user_is_admin" type="checkbox">Admin?</label></div></td>'
		$('#example').prepend('<tr>' + check + name + email + admin + '</tr>');
	})

	$(document).on('keypress', '#user_email', function(e) {
	    if(e.which == 13) {
	    	var token = $('meta[name=csrf-token]').attr("content");
	    	var data = {"user[name]": $('#user_name').val(), "user[email]": $('#user_email').val(), "user[is_admin]": $('#user_is_admin').val(), authenticity_token: token}
	    	// refreshTable('#example', '/users.json', data);
	    }
	});

	// var data = [
	//   ["Name", "Email", "Role"],
	//   [ 10, 11, 12],
	//   [ 20, 11, 14],
	//   [ 30, 15, 12]
	// ];

	// var container6 = document.getElementById('users-table');
	// var hot6;

	//   hot6 = new Handsontable(container6, {
	//     data: [
	//       model({id: 1, name: 'Ted Right', address: ''}),
	//       model({id: 2, name: 'Frank Honest', address: ''}),
	//       model({id: 3, name: 'Joan Well', address: ''}),
	//       model({id: 4, name: 'Gail Polite', address: ''}),
	//       model({id: 5, name: 'Michael Fair', address: ''})
	//     ],
	//     dataSchema: model,
	//     colHeaders: ['ID', 'Name', 'Address'],
	//     columns: [
	//       {data: property('id')},
	//       {data: property('name')},
	//       {data: property('address')}
	//     ],
	//     minSpareRows: 1
	//   });

	//   function model(opts) {
	//     var
	//       _pub = {},
	//       _priv = {
	//         "id": undefined,
	//         "name": undefined,
	//         "address": undefined
	//       };

	//     for (var i in opts) {
	//       if (opts.hasOwnProperty(i)) {
	//         _priv[i] = opts[i];
	//       }
	//     }

	//     _pub.attr = function (attr, val) {
	//       if (typeof val === 'undefined') {
	//         window.console && console.log("\t\tGET the", attr, "value of", _pub);
	//         return _priv[attr];
	//       }
	//       window.console && console.log("SET the", attr, "value of", _pub);
	//       _priv[attr] = val;

	//       return _pub;
	//     };

	//     return _pub;
	//   }

	//   function property(attr) {
	//     return function (row, value) {
	//       return row.attr(attr, value);
	//     }
	//   }

});