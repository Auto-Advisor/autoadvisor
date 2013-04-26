/**
 * Constraint object constructor is in ./constraint_helper/constraint_list.js
 */

var num_constraint = 0;
var constraints = [];

function relation(val, c) {
  var relation = '';
  var input = '';
  if (val === 'major'){
    relation += constraints[c].major.relation;
    input += constraints[c].major.input;
    constraints[c].active = 'major';
  }
  else if (val === 'c_time') {
    relation += constraints[c].c_time.relation;
    input += constraints[c].c_time.input;
    constraints[c].active = 'c_time';
  }
  else if (val === 'credit') {
    relation += constraints[c].credit.relation;
    input += constraints[c].credit.input;
    constraints[c].active = 'credit';
  }
  else if (val === 'num-course') {
    relation += constraints[c].num_course.relation;
    input += constraints[c].num_course.input;
    constraints[c].active = 'num-course';
  }
  else if (val === 'spe-course') {
    relation += constraints[c].spe_course.relation;
    input += constraints[c].spe_course.input;
    constraints[c].active = 'spe-course';
  }
  else if (val === 'dayoff') {
    relation += constraints[c].day_off.relation;
    input += constraints[c].day_off.input;
    constraints[c].active = 'dayoff';
  }
  else if (val === 'course_range') {
    relation += constraints[c].course_range.relation;
    input += constraints[c].course_range.input;
    constraints[c].active = 'course_range';
  }
  else if (val === 'dis_lab') {
    relation += constraints[c].dis_lab.relation;
    input += constraints[c].dis_lab.input;
    constraints[c].active = 'dis_lab';
  }
  else if (val === 'gen') {
    relation += constraints[c].gen.relation;
    input += constraints[c].gen.input;
    constraints[c].active = 'gen';
  }

  $('#r_' + c).html(relation);
  $('#i_' + c).html(input);
}

$('#additem').bind('click', function () {
  var c = Object.create(constraint(num_constraint));
  constraints.push(c);
  var id = num_constraint;
  $('div#msg').html('clicked');
  var html = '<tr id="constraint_row_';
     html += id;
     html += '"><th>';
     html += id+1;
     html += '.</th>';
     html += '<td><select name="constraint" onChange="relation(this.value, ';
     html += id;
     html += ')" id="constraint_';
     html += id;
     html += '"><option value="major">Major</option>';
     html += '<option value="course_range">Course Number Range</option>';
     html += '<option value="c_time">Time</option>';
	   html += '<option value="num-course">Number of Courses</option>';
     html += '<option value="credit">Credit</option>';
	   html += '<option value="spe-course">Specific Courses</option>';
	   html += '<option value="dayoff">No Class Days</option>';
     html += '<option value="dis_lab">Discussion Or Laboratory</option>';
     html += '<option value="gen">GenEd</option>'
     html += '</select></td>'
     html += '<td><div id="r_';
     html += id;
     html += '"><select><option></option></select></div></td>';
     html += '<td><div id="i_';
     html += id;
     html += '"><select><option></option></select></div></td>';
     html += '<td><a href="#" onclick="remove(';
     html += id;
     html += ')"><img class="remove" id="';
     html += id;
     html += '"src="http://www.clker.com/cliparts/1/1/9/2/12065738771352376078Arnoud999_Right_or_wrong_5.svg.hi.png" width="30px" height="30px"/></a></td>'
     html += '</tr>';
     
  $('table#constraints').append(html);
  $('#constraint_' + id).prop('selectedIndex', -1);
  num_constraint++;
});

function remove(i) {
  constraints[i].active = undefined;
  $('#constraint_row_' + i).hide();
}

function getRelation (ind) {
  var relation = $('#relation_' + ind).val();
  console.log(relation);
  var string = '';
  if (relation === 'equal') {
    string += "\=";
  }
  else if (relation === 'less than') {
    string += "\<\=";
  }
  else if (relation === 'greater than') {
    string += "\>\=";
  }
  return string;
}

function getDays(type, i) {
  string = '';
  $('#' + type + '_' + i + ' .btn.active').each(function () {
    string += this.value;
  })
  return string;
}

function getString(cons_ind) {
  var string = '';
  if (constraints[cons_ind].active === 'major') {
    string += '"major": "' + $('#major_' + cons_ind).val() + '"';
  }
  else if (constraints[cons_ind].active === 'c_time') {
    string += '"time": {{"operator": "';
    string += getRelation(cons_ind) + '", "value": "';
    string += $('#time_' + cons_ind).val() + '"}, "on": "'
    string += getDays('timeday', cons_ind) + '"}';
  }
  else if (constraints[cons_ind].active === 'credit') {
    string += '"credit": {"operator": "';
    string += getRelation(cons_ind) + '", "value": "';
    string += $('#credit_' + cons_ind).val() + '"}';
  }
  else if (constraints[cons_ind].active === 'num-course') {
    string += '"num_course": {"operator": "';
    string += getRelation(cons_ind) + '", "value": "';
    string += $('#num_course_' + cons_ind).val() + '"}';
  }
  else if (constraints[cons_ind].active === 'spe-course') {
    string += '"spe_course": "';
    string += $('#spe_course_' + cons_ind).val() + '"';
  }
  else if (constraints[cons_ind].active === 'dayoff') {
    string += '"dayoff": "';
    string += getDays('dayoff', cons_ind) + '"';
  }
  else if (constraints[cons_ind].active === 'course_range') {
    string += '"course_range" : {"operator": "';
    string += getRelation(cons_ind) + '", "value": "';
    string += $('#course_range_' + cons_ind).val() + '"}';
  }
  else if (constraints[cons_ind].active === 'dis_lab') {
    string += '"dis": ';
    if ($('#dis').prop('checked')) {
      string += 'true';
    } else {
      string += 'false';
    }
    string += ', "lab": ';
    if ($('#lab').prop('checked')) {
      string += 'true';
    } else {
      string += 'false';
    }
  }
  else if (constraints[cons_ind].active === 'gen') {
    string += '"gen": ';
    if ($('#gen').prop('checked')) {
      string += 'true';
    } else {
      string += 'false';
    }
  }
  return string;
}

function firstThing() {
  var i = 0;
  for (i; i < constraints.length; i++) {
    if (constraints[i].active != undefined)
      return i;
  }
}

function printSchedule(data) {
  var string = '';
  string += '<th width="10%">Lectures</th>';
  for (var i = 0; i < data.length; i++) {
    string += '<td align="center">';
    string += data[i].name + '<br>';
    string += data[i].day + '<br>';
    string += data[i].beg_time + ' - ' + data[i].end_time;
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

$('#getrecommend').bind('click', function () {
  $('#msg').html('Recommendation Clicked');

  var c_string = '{';
  var i = firstThing();
  c_string += getString(i);
  for (i = i+1; i < constraints.length; i++) {
    if (constraints[i].active != undefined)
      c_string += ', ' + getString(i);
  }
  c_string += '}';

  $('#string').html(c_string);

  function onSuccess (data) {
    var string = '';
    for (var i = 0; i < data.length; i++){
      string += '<table class="table table-bordered table-striped"><tr>';
      string += '<td rowspan="3" width="20%">';
      string += '<a href="#save_' + i + '" role="button" class="btn" data-toggle="modal">Save This Schedule</a>';
      string += '<div id="save_' + i + '" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">'
      string += '<div class="modal-body">';
      string += 'You are going to save the following schedule:<br />';

      string += '<table class="table table-bordered table-striped"><tr>'
      string += printSchedule(data[i]);
      string += '</tr></table>';

      string += 'Name of This Schedule: <input type="text" name="name_of_save_0"></div>';
      string += '<div class="modal-footer">';
      string += '<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>';
      string += '<button class="btn btn-primary">Save</button>'
      string += '</div>'
      string += '</div>';
      string += '</td>';

      string += printSchedule(data[i]);
      
      string += '</tr></table>';

      $('#save_schedule_0').bind('click', function(event) {
        $('#save_0').html('You are going to save this schedule');
      })
      $('div#recommendations').html(string);
    }
  }

  function onSend() {
    $('#recommendations').html("Please wait... I am looking for schedules which suitable for you :)");
  }
  
  $.ajax({
    type: 'POST',
    contentType: "application/json",
    url: '/schedule/get_recommendations', data: c_string,
    success: onSuccess,
    beforeSend: onSend,
    dataType: "json"
  });
});



$('#constraint').prop('selectedIndex', -1)