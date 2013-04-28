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

	   string += 'Name of This Schedule: <input type="text" name="name_of_save">';
     string += '<div class="modal-footer">';
     string += '<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>';
     string += '<button class="btn btn-primary" id="save_btn" >Save</button>';
     string += '</div></div></td>';

     string += printSchedule(data);

     string += '</tr><tr><td>&nbsp;</td>';

  $.each(data, function (index, value) {
  	string += '<td><a role="button" class="btn btn-warning No_' + value.name + '">I don\'t want this class</a></td>';
  });

  string += '</tr></table>';

  return string;
}