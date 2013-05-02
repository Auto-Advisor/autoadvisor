function changeInput(type, id) {
  var relation = $('#relation_' + id);
  var input = $('#second_' + type + '_input_' + id);
  if (relation.val() != 'within') {
    input.hide();
  }
  else if (relation.val() === 'within') {
    input.show();
  }
}

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

var newConstraint = function (type, operator, value) {
  var c = Object.create(constraint(num_constraint));
  constraints.push(c);
  var id = num_constraint;
  var html = '<tr id="constraint_row_';
     html += id;
     html += '">';
     html += '<td width="20%"><select style="width: 200px" name="constraint" onChange="relation(this.value, ';
     html += id;
     html += ')" id="constraint_';
     html += id;

     /**
      * constraint obj: major
      */
     html += '"><option value="major">Major</option>';

     /**
      * constraint obj: major_course
      */
     html += '<option value="major_course">Number of Major Courses</option>';

     /**
      * constraint obj: course_number
      */
     html += '<option value="course_number">Course Number Range</option>';

     /**
      * constraint obj: num_course
      */
     html += '<option value="num_course">Number of Courses</option>';

     /**
      * constraint obj: c_time
      */
     html += '<option value="c_time">Time</option>';

     /**
      * constraint obj: unit per course
      */
     html += '<option value="unit_per_course">Unit Per Course</option>';

     /**
      * constraint obj: credit
      */
     html += '<option value="credit">Credit</option>';

     /**
      * constraint obj: spe_course
      */
     html += '<option value="spe_course">Specified Courses</option>';

     /**
      * constraint obj: spe_section
      */
     html += '<option value="spe_section">Specified Spire ID</option>';

     /**
      * constraint obj: days
      */
     html += '<option value="day">Class Days</option>';

     html += '</select></td>';
     html += '<td width="36%"><div id="r_';
     html += id;
     html += '">&nbsp;</div></td>';
     html += '<td width="34%"><div id="i_';
     html += id;
     html += '">&nbsp;</div></td>';
     html += '<td><a class="btn btn-danger" id="remove_constraint_' + id +'">Delete</a>';
     html += '</td>'
     html += '</tr>';

     $('table#constraints').append(html);
   
  if (type === 'spe-course') {
  	$('#constraint_' + id).prop('selectedIndex', 5);
  	relation('spe-course', id);
    $('#spe_course_' + id).val(value);
  } else {
	  $('#constraint_' + id).prop('selectedIndex', -1);
  }

  $('#remove_constraint_' + id).bind('click', function() {
    constraints[id].active = undefined;
    $('#constraint_row_' + id).hide();
  })
  num_constraint++;
};

/**
 * Bind "Add new constraint" to add one more row
 *
 * See new_constraint.js
 */
$('#additem').bind('click', function (event) {
  newConstraint();
});
