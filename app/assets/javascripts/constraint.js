/**
 * Constraint object constructor is in ./constraint_helper/constraint_list.js
 * newConstraint function is in ./constraint_helper/new_constraint.js
 */

var num_constraint = 0;
var constraints = [];
var dontwant = [];
var inclusion = {'type': 'specified', 'courses': [], 'sections': []};

/**
 * Change Details within one constraints
 *
 * relation is the middle dropdown box
 * input is the right input items
 *
 * Once constraint type is set, the activation of
 * that row is that constraint
 */
function relation(val, c) {
  var relation = '';
  var input = '';
  if (val === 'major'){
    relation += constraints[c].major.relation;
    input += constraints[c].major.input;
  }
  else if (val === 'c_time') {
    relation += constraints[c].c_time.relation;
    input += constraints[c].c_time.input;
  }
  else if (val === 'credit') {
    relation += constraints[c].credit.relation;
    input += constraints[c].credit.input;
  }
  else if (val === 'num_course') {
    relation += constraints[c].num_course.relation;
    input += constraints[c].num_course.input;
  }
  else if (val === 'spe_course') {
    relation += constraints[c].spe_course.relation;
    input += constraints[c].spe_course.input;
  }
  else if (val === 'spe_section') {
    relation += constraints[c].spe_section.relation;
    input += constraints[c].spe_section.input;
  }
  else if (val === 'day') {
    relation += constraints[c].day.relation;
    input += constraints[c].day.input;
  }
  else if (val === 'course_number') {
    relation += constraints[c].course_number.relation;
    input += constraints[c].course_number.input;
  }
  else if (val === 'dis') {
    relation += constraints[c].dis.relation;
    input += constraints[c].dis.input;
  }
  else if (val === 'lab') {
    relation += constraints[c].lab.relation;
    input += constraints[c].lab.input;
  }
  else if (val === 'gened') {
    relation += constraints[c].gened.relation;
    input += constraints[c].gened.input;
  }
  else if (val === 'major_course') {
    relation += constraints[c].major_course.relation;
    input += constraints[c].major_course.input;
  }
  else if (val === 'unit_per_course') {
    relation += constraints[c].unit_per_course.relation;
    input += constraints[c].unit_per_course.input;
  }

  constraints[c].active = val;
  $('#r_' + c).html(relation);
  $('#i_' + c).html(input);
}

/**
 * Bind "Add new constraint" to add one more row
 *
 * See new_constraint.js
 */
$('#additem').bind('click', function (event) {
  newConstraint();
});

/**
 * ==Not Necessary==
 * May remove next time
 * 
 * Convert Relation into simbolic form
 */
function getRelation (ind) {
  var relation = $('#relation_' + ind).val();
  var string = '';
  if (relation === 'within') {
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

/**
 * Get Days from a set of Day Buttons
 *
 * return a string (eg. MTW)
 */
function getDays(type, i) {
  string = '';
  $('#' + type + '_' + i + ' .btn.active').each(function () {
    string += this.value;
  });
  return string;
}

/**
 * Get an array of constraints
 * Constructing each constraint to a json object
 *
 * The format of EACH JSON Object is:
 *
 */
function getConstraints() {
  var valid = true;
  var array = $.map(constraints, function (value, index) {
    if (value.active === undefined) {
      return;
    }

    var hash = {"type": value.active};
    if (value.active === 'major') {
      hash['major'] = $('#major_' + index).val();
    }

    else if (value.active === 'course_number') {
      if (getRelation(index) === '\>\=') {
        hash['lower'] = $('#course_number_' + index).val();
      }
      else if (getRelation(index) === '\<\=') {
        hash['upper'] = $('#course_number_' + index).val();
      }
      else {
        var lower = $('#course_number_' + index).val();
        var higher = $('#course_number_2_' + index).val();
        if (lower > higher) {
          valid = false;
        }
        else {
          hash['lower'] = lower;
          hash['upper'] = higher;
        }
      }
    }

    else if (value.active === 'c_time') {
      hash['type'] = 'time';
      if (getRelation(index) === '\>\=') {
        hash['lower'] = $('#time_' + index).val();
      }
      else if (getRelation(index) === '\<\=') {
        hash['upper'] = $('#time_' + index).val();
      }
      else {
        hash['lower'] = $('#time_' + index).val();
        hash['upper'] = $('#time_2_' + index).val();
      }
    }

    else if (value.active === 'num_course') {
      hash['type'] = 'target';
      hash['target_type'] = "number";
      if (getRelation(index) === '\>\=') {
        hash['lower'] = $('#num_course_' + index).val();
      }
      else if (getRelation(index) === '\<\=') {
        hash['upper'] = $('#num_course_' + index).val();
      }
      else {
        var lower = $('#num_course_' + index).val();
        var higher = $('#num_course_2_' + index).val();
        if (lower > higher) {
          valid = false;
        }
        else {
          hash['lower'] = lower;
          hash['upper'] = higher;
        }
      }
    }

    else if (value.active === 'credit') {
      hash['type'] = 'target';
      hash['target_type'] = "credits";
      if (getRelation(index) === '\>\=') {
        hash['lower'] = $('#credit_' + index).val();
      }
      else if (getRelation(index) === '\<\=') {
        hash['upper'] = $('#credit_' + index).val();
      }
      else {
        var lower = $('#credit_' + index).val();
        var higher = $('#credit_2_' + index).val();
        if (lower > higher) {
          valid = false;
        }
        else {
          hash['lower'] = lower;
          hash['upper'] = higher;
        }
      }
    }

    else if (value.active === 'spe_course') {
      var courses = $('#spe_course_' + index).val().split(', ');
      $.each(courses, function (index, value) {
        inclusion.courses.push(value);
      });
    }

    else if (value.active === 'spe_section') {
      var sections = $('#spe_section_' + index).val().split(', ');
      $.each(sections, function (index, value) {
        inclusion.sections.push(value);
      });
    }

    else if (value.active === 'days') {
      hash['days'] = getDays('day', index);

    }

    else if (value.active === 'dis') {
      if ($('#dis_' + index).prop('checked')) {
        hash['discussion'] = 'true';
      } else {
        hash['discussion'] = 'false';
      }
    }

    else if (value.active === 'lab') {
      if ($('#lab_' + index).prop('checked')) {
        hash['lab'] = 'true';
      } else {
        hash['lab'] = 'false';
      }
    }

    else if (value.active === 'gened') {
      hash['string'] = $('#gened_' + index).val();
    }

    /**
     * TODO
     */
    else if (value.active === 'major_course') {
      hash['type'] = 'major_course';
      if (getRelation(index) === '\>\=') {
        hash['lower'] = $('#major_course_' + index).val();
      }
      else if (getRelation(index) === '\<\=') {
        hash['upper'] = $('#major_course_' + index).val();
      }
      else {
        var lower = $('#major_course_' + index).val();
        var higher = $('#major_course_2_' + index).val();
        if (lower > higher) {
          valid = false;
        }
        else {
          hash['lower'] = lower;
          hash['upper'] = higher;
        }
      }
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
        var lower = $('#unit_per_course_' + index).val();
        var higher = $('#unit_per_course_2_' + index).val();
        if (lower > higher) {
          valid = false;
        }
        else {
          hash['lower'] = lower;
          hash['upper'] = higher;
        }
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
  array.push(inclusion);
  return array;
}

/**
 * Binded to "Show Me My Option"
 * 
 * 1. Send the array of JSON object created by
 *    getConstraints() function
 *
 * 2. Get data on Success and print the schedule
 *    ** See print_recommendation.js
 *
 * The format of JSON received is:
 *
 */
function getRecommendation() {
  $('#msg').html('Recommendation Clicked');

  var constraints_array = getConstraints();

  $('#string').html(JSON.stringify(constraints_array));

  function onSuccess (data) {
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