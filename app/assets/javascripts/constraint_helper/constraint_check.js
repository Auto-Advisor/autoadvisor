function hasElement (array, type, value) {

	for (var i = 0; i < array.length; i++) {
		if (array[i][type] === value)
			return true;
	}

	return false;
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
          $('#constraint_row_' + index).addClass('error');
          $('#err_' + index).html('<i class="icon-exclamation-sign">Logic Fail</i>');
          return {'type': 'failure'};
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
        var lower = $('#time_' + index).val();
        var upper = $('#time_2_' + index).val();
        hash['lower'] = lower;
        hash['upper'] = upper;
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
          $('#constraint_row_' + index).addClass('error');
          $('#err_' + index).html('<i class="icon-exclamation-sign">Logic Fail</i>');
          return {'type': 'failure'};
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
          $('#constraint_row_' + index).addClass('error');
          $('#err_' + index).html('<i class="icon-exclamation-sign">Logic Fail</i>');
          return {'type': 'failure'};
        }
        else {
          hash['lower'] = lower;
          hash['upper'] = higher;
        }
      }
    }

    else if (value.active === 'spe_course') {
      var courses = $('#spe_course_' + index).val().split(', ');
      $.each(courses, function (i, v) {
        if ($('#not_' + index).hasClass('active'))
          exclusion.by_input.push(v);
        else
          inclusion.courses.push(v);
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
      if (!hasElement(constraints, 'active', 'major')) {
        $('#constraint_row_' + index).addClass('error');
        $('#err_' + index).html('<i class="icon-exclamation-sign">No major</i>');
        return {'type': 'failure'};
      }
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
          $('#constraint_row_' + index).addClass('error');
          $('#err_' + index).html('<i class="icon-exclamation-sign">Logic Fail</i>');
          return {'type': 'failure'};
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
          $('#constraint_row_' + index).addClass('error');
          $('#err_' + index).html('<i class="icon-exclamation-sign">Logic Fail</i>');
          return {'type': 'failure'};
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
   * If there are any failue type, return an empty array
   */
  if (hasElement(array, 'type', 'failure')) {
    $('#recommendations').html('constraint fail');
    return constraintsss;
  }

  /**
   * Exclusion List
   */
  var final_exclusion = {};
  final_exclusion['type'] = 'specified';
  final_exclusion['courses'] = [];
  $.each(exclusion.by_click, function (index, value) {
    final_exclusion['courses'].push(value);
  });
  $.each(exclusion.by_input, function (index, value) {
    final_exclusion['courses'].push(value);
  });
  final_exclusion['invert'] = true;
  array.push(final_exclusion);
  array.push(inclusion);
  return array;
}