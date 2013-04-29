/**
 * Constraint object constructor is in ./constraint_helper/constraint_list.js
 * newConstraint function is in ./constraint_helper/new_constraint.js
 */

var num_constraint = 0;
var constraints = [];
var dontwant = [];

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
  else if (val === 'num_course') {
    relation += constraints[c].num_course.relation;
    input += constraints[c].num_course.input;
    constraints[c].active = 'num_course';
  }
  else if (val === 'spe_course') {
    relation += constraints[c].spe_course.relation;
    input += constraints[c].spe_course.input;
    constraints[c].active = 'spe_course';
  }
  else if (val === 'dayoff') {
    relation += constraints[c].day_off.relation;
    input += constraints[c].day_off.input;
    constraints[c].active = 'days_off';
  }
  else if (val === 'course_range') {
    relation += constraints[c].course_range.relation;
    input += constraints[c].course_range.input;
    constraints[c].active = 'course_range';
  }
  else if (val === 'dis') {
    relation += constraints[c].dis.relation;
    input += constraints[c].dis.input;
    constraints[c].active = 'dis';
  }
  else if (val === 'lab') {
    relation += constraints[c].lab.relation;
    input += constraints[c].lab.input;
    constraints[c].active = 'lab';
  }
  else if (val === 'gen') {
    relation += constraints[c].gen.relation;
    input += constraints[c].gen.input;
    constraints[c].active = 'gen';
  }
  else if (val === 'num_major_course') {
    relation += constraints[c].num_major_course.relation;
    input += constraints[c].num_major_course.input;
    constraints[c].active = 'num_major_course';
  }
  else if (val === 'unit_per_course') {
    relation += constraints[c].unit_per_course.relation;
    input += constraints[c].unit_per_course.input;
    constraints[c].active = 'unit_per_course';
  }

  $('#r_' + c).html(relation);
  $('#i_' + c).html(input);
}

$('#additem').bind('click', function (event) {
  newConstraint();
});

function getRelation (ind) {
  var relation = $('#relation_' + ind).val();
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
  });
  return string;
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

function getConstraints() {
  var array = $.map(constraints, function (value, index) {
    if (value.active === undefined) {
      return;
    }
    var hash = {"type": value.active};
    if (value.active === 'major') {
      hash['major'] = $('#major_' + index).val();
    }

    else if (value.active === 'course_range') {
      if (getRelation(index) === '\>\=') {
        hash['lower'] = $('#course_range_' + index).val();
      }
      else if (getRelation(index) === '\<\=') {
        hash['upper'] = $('#course_range_' + index).val();
      }
      else {
        hash['lower'] = $('#course_range_' + index).val();
        hash['upper'] = $('#course_range_' + index).val();
      }
    }

    else if (value.active === 'c_time') {

    }

    else if (value.active === 'num_course') {
      hash['type'] = 'target';
      if (getRelation(index) === '\>\=') {
        hash['lower'] = $('#num_course_' + index).val();
      }
      else if (getRelation(index) === '\<\=') {
        hash['upper'] = $('#num_course_' + index).val();
      }
      else {
        hash['lower'] = $('#num_course_' + index).val();
        hash['upper'] = $('#num_course_' + index).val();
      }
    }

    else if (value.active === 'credit') {
      hash['type'] = 'target';
      if (getRelation(index) === '\>\=') {
        hash['lower'] = $('#credit_' + index).val();
      }
      else if (getRelation(index) === '\<\=') {
        hash['upper'] = $('#credit_' + index).val();
      }
      else {
        hash['lower'] = $('#credit_' + index).val();
        hash['upper'] = $('#credit_' + index).val();
      }
    }

    else if (value.active === 'spe_course') {

    }

    else if (value.active === 'days_off') {
      hash['days_off'] = getDays('dayoff', index);

    }

    else if (value.active === 'dis') {
      if ($('#dis').prop('checked')) {
        hash['discussion'] = 'true';
      } else {
        hash['discussion'] = 'false';
      }
    }

    else if (value.active === 'lab') {
      if ($('#lab').prop('checked')) {
        hash['lab'] = 'true';
      } else {
        hash['lab'] = 'false';
      }
    }

    else if (value.active === 'gen') {
      if ($('#gen').prop('checked')) {
        hash['gen'] = 'true';
      } else {
        hash['gen'] = 'false';
      }
    }

    else if (value.active === 'num_major_course') {

    }

    else if (value.active === 'unit_per_course') {
      hash['type'] = 'units';
      if (getRelation(index) === '\>\=') {
        hash['lower'] = $('#unit_per_course_' + index).val();
      }
      else if (getRelation(index) === '\<\=') {
        hash['upper'] = $('#unit_per_course_' + index).val();
      }
      else {
        hash['lower'] = $('#unit_per_course_' + index).val();
        hash['upper'] = $('#unit_per_course_' + index).val();
      }
    }

    hash['invert'] = $('#not_' + index).hasClass('active') ? true : false;

    return hash;
  });

  /**
   * Exclusion List
   */
  var exclusion = {};
  exclusion['type'] = 'specified';
  exclusion['courses'] = [];
  $.each(dontwant, function (index, value) {
    exclusion['courses'].push(value);
  });
  exclusion['invert'] = true;
  array.push(exclusion);
  return array;
}

function getRecommendation() {
  $('#msg').html('Recommendation Clicked');

  var constraints_array = getConstraints();

  $('#string').html(JSON.stringify(constraints_array));

  function onSuccess (data) {
    
    console.log("Print");
    print_recommendation(data);

    var exclusion_list = '';
    if (dontwant.length != 0) {
      exclusion_list += '<table class="table table-hover table-bordered">';
      exclusion_list +=   '<thead>';
      exclusion_list +=     '<tr><td colspan="2">Exclusion List</td></tr>';
      exclusion_list +=   '</thead>';
      exclusion_list += '<tbody>';
      for (var i = 0; i < dontwant.length; i++) {
        exclusion_list += '<tr><td>' + dontwant[i] + '</td><td><a role="button" class="btn btn-danger" id="delete_exclusion_' + i + '">Delete</a></td></tr>'
      }
      exclusion_list += '</tbody></table>';
    }

    $('#exclusion_list').html(exclusion_list);

    $.each(dontwant, function(index, value) {
      $('#delete_exclusion_' + index).bind('click', function (event) {
        dontwant = jQuery.grep(dontwant, function(v) {
          return value != v;
        });
        getRecommendation();
      });
    });

    $.each(data, function(index, value) {
      $.each(value, function(i, v) {
        $('a.No_' + v.name).bind('click', function (event) {
          console.log("No Class " + v.name);
          dontwant.push(v.name);
          getRecommendation();
        });
      });
    });

    $.each(data, function(index, value) {
      $('#save_btn_' + index).bind('click', function (event) {
        console.log('schedule ' + index + ' saved');
      })
    });
  }

  function onSend() {
    $('#recommendations').html("Please wait... I am looking for schedules which suitable for you :)");
  }
  
  $.ajax({
    type: 'POST',
    contentType: "application/json",
    url: "/schedule/generate.json", data: JSON.stringify(constraints_array),
    success: onSuccess,
    beforeSend: onSend,
    dataType: "json"
  });
}

$('#getrecommend').bind('click', getRecommendation);



$('#constraint').prop('selectedIndex', -1)