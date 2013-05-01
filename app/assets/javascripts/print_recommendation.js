function printSchedule(data) {
  var string = '';
  var spire_id = [];
  string += '<th width="10%">Lectures</th>';
  for (var i = 0; i < data.length; i++) {
    string += '<td align="center" id="' + data[i].spire_id + '">';
    spire_id.push(data[i].spire_id);
    string += data[i].class_string + '<br>';
    string += data[i].name + '<br>';
    string += data[i].days + ' ' + data[i]["time_start"] + ' - ' + data[i]["time_end"];
    string += '</td>';
  }

  string += '</tr><tr><th>Discussions</th>';
  for (var i = 0; i < data.length; i++) {
    string += '<td>'
    if (data[i].discussion == undefined) {
      string += '&nbsp;';
    } else {
      string += data[i].discussion.class_string + '<br>';
      string += data[i].discussion.name + '<br>';
      string += data[i].discussion['time_start'] + ' - ' + data[i].discussion['time_end'];
    }
    string += '</td>';
  }

  string += '</tr><tr><th>Laboratory</th>';
  for (var i = 0; i < data.length; i++) {
    string += '<td>'
    if (data[i].laboratory == undefined) {
      string += '&nbsp;';
    } else {
      string += data[i].laboratory.class_string + '<br>';
      string += data[i].laboratory.name + '<br>';
      string += data[i].laboratory['time_start'] + ' - ' + data[i].laboratory['time_end'];
    }
    string += '</td>';
  }
  return {'string': string, 'spire_id': spire_id};
} 

function getSections(data) {
	var sections = [];
	$.each(data, function (index, value) {
		sections.push(value.spire_id);
		if (value.discussion != undefined)
			sections.push(value.discussion.spire_id);
		if (value.laboratory != undefined)
			sections.push(value.laboratory.spire_id);
	});
	return sections;
}

function print_recommendation (data) {
  var schedule = printSchedule(data);
	var string = '<table class="table table-bordered table-striped"><tr>';
	   string += '<td rowspan="4" width = "20%">';
	   string += '<a href="#save" role="button" class="btn" data-toggle="modal">Save This Schedule</a>';
	   string += '<div id="save" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 800px">';
	   string += '<div class="modal-header">You are going to save the following schedule:</div>';

	   string += '<table class="table table-bordered table-striped"><tr>';
	   string += schedule.string;
	   string += '</tr></table>';

	   string += 'Name of This Schedule: <input type="text" name="name_of_save" id="name_of_save">';
     string += '<div class="modal-footer">';
     string += '<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>';
     string += '<button class="btn btn-primary" data-dismiss="modal" aria-hidden="true" id="save_btn" >Save</button>';
     string += '</div></div></td>';

     string += schedule.string;

     string += '</tr><tr><td>&nbsp;</td>';

  $.each(data, function (index, value) {
  	string += '<td><a role="button" class="btn btn-warning No_' + value.id + '">I don\'t want this class</a></td>';
  });

  string += '</tr></table>';

  $('#recommendations').html(string);

  var spire_id = schedule.spire_id;

  $.each(spire_id, function (index, value) {
    console.log(value);
    $('td#' + value).bind('click', function (event) {
      console.log(value + 'clicked');
      $('#string').html(value);
    });
  });

  $.each(data, function(i, v) {
    $('a.No_' + v.id).bind('click', function (event) {
      console.log("No Class " + v.class_string);
      dontwant.push(v.class_string);
      $.each(data, function (index, value) {
        if (value.class_string != v.class_string) {
          inclusion.courses.push(value.class_string);
        }
      });
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
		 *   "sections": The SPIRE ID of the schedule shown
  	 * }
  	 */
  	var send_data = {'schedule_name': $('#name_of_save').val()};
  	send_data['sections'] = getSections(data);

  	$('#string').html(JSON.stringify(send_data));

  	/**
  	 * TODO: 
  	 *
  	 * 1. get the save query URL
  	 *
  	 * 2. page effect on success
  	 * 3. page effect on send
  	 * 4. page effect on fail
  	 */
  	// $.ajax({
	  //   type: "POST",
	  //   contentType: "application/json",
	  //   url: /** save schedule URL **/, data: JSON.stringify(send_data),
	  //   success: function(data, text_status, jqXHR) {
	  //     print_recommendation(data);

	  //    },
	  //   beforeSend: function() {
	  //     $('#recommendations').html("Please wait... I am looking for schedules which are suitable for you :)");
	  //   },
	  //   fail: function(jqXHR, textStatus, errorThrown) {
	  //     alert("panic");
	  //   }
	  // });
  });
}