function printSchedule(data) {
  var string = '';
  string += '<th width="10%">Lectures</th>';
  for (var i = 0; i < data.length; i++) {
    string += '<td align="center">';
    string += data[i].class_string + '<br>';
    string += data[i].name + '<br>';
    string += Math.floor(data[i].min_beg / 60) + ':';
    if (data[i].min_beg % 60 === 0)
    	string += '00';
    else if (data[i].min_beg % 60 === 5)
    	string += '0' + data[i].min_beg % 60;
    else
    	string += data[i].min_beg % 60;
    string += ' - ';
    string += Math.floor(data[i].min_end / 60) + ':';
    if (data[i].min_end % 60 === 0)
    	string += '00';
    else if (data[i].min_end % 60 === 5)
    	string += '0' + data[i].min_end % 60;
    else
    	string += data[i].min_end % 60;
    string += '</td>';
  }

  string += '</tr><tr><th>Discussions</th>';
  for (var i = 0; i < data.length; i++) {
    string += '<td>'
    if (data[i].discussion == undefined) {
      string += '&nbsp;';
    } else {
      string += data[i].discussion.name + '<br>';
      string += data[i].discussion.day + '<br>';
      string += data[i].discussion.beg_time + ' - ' + data[i].discussion.end_time;
    }
    string += '</td>';
  }

  string += '</tr><tr><th>Laboratory</th>';
  for (var i = 0; i < data.length; i++) {
    string += '<td>'
    if (data[i].laboratory == undefined) {
      string += '&nbsp;';
    } else {
      string += data[i].laboratory.name + '<br>';
      string += data[i].laboratory.day + '<br>';
      string += data[i].laboratory.beg_time + ' - ' + data[i].laboratory.end_time;
    }
    string += '</td>';
  }
  return string;
} 

function print_recommendation (data) {
	var string = '<table class="table table-bordered table-striped"><tr>';
	   string += '<td rowspan="4" width = "20%">';
	   string += '<a href="#save" role="button" class="btn" data-toggle="modal">Save This Schedule</a>';
	   string += '<div id="save" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 800px">';
	   string += '<div class="modal-header">You are going to save the following schedule:</div>';

	   string += '<table class="table table-bordered table-striped"><tr>';
	   string += printSchedule(data);
	   string += '</tr></table>';

	   string += 'Name of This Schedule: <input type="text" name="name_of_save" id="name_of_save">';
     string += '<div class="modal-footer">';
     string += '<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>';
     string += '<button class="btn btn-primary" data-dismiss="modal" aria-hidden="true" id="save_btn" >Save</button>';
     string += '</div></div></td>';

     string += printSchedule(data);

     string += '</tr><tr><td>&nbsp;</td>';

  $.each(data, function (index, value) {
  	string += '<td><a role="button" class="btn btn-warning No_' + value.id + '">I don\'t want this class</a></td>';
  });

  string += '</tr></table>';

  $('#recommendations').html(string);

  $.each(data, function(i, v) {
    $('a.No_' + v.id).bind('click', function (event) {
      console.log("No Class " + v.class_string);
      dontwant.push(v.class_string);
      getRecommendation();
    });
  });

  $('#save_btn_').bind('click', function (event) {
  	$('#string').html('your schedule saved with name ' + $('#name_of_save').val());

  	/**
  	 * Encapsulation of Saving Schedule
  	 * {
		 *   "schedule_name": The name of schedule we want to save.
		 *                    The name will be appeared in schedule
		 * 										page.
		 *   "schedule": The entire schedule shown
  	 * }
  	 */
  	var send_data = {'schedule_name': $('#name_of_save').val()};
  	send_data['schedule'] = data;

  	$('#string').html(JSON.stringify(send_data));

  	// $.ajax({
	  //   // type: "POST",
	  //   // contentType: "application/json",
	  //   // url: /** save schedule URL **/, data: JSON.stringify(data),
	  //   // success: function(data, text_status, jqXHR) {
	  //   //   print_recommendation(data);

	  //   //  },
	  //   // beforeSend: function() {
	  //   //   $('#recommendations').html("Please wait... I am looking for schedules which are suitable for you :)");
	  //   // },
	  //   // fail: function(jqXHR, textStatus, errorThrown) {
	  //   //   alert("panic");
	  //   // }
	  // });
  });
}