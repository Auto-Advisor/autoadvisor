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

var newConstraint = function (type, operator, value) {
  var c = Object.create(constraint(num_constraint));
  constraints.push(c);
  var id = num_constraint;
  var html = '<tr id="constraint_row_';
     html += id;
     html += '"><th width="2%">';
     html += id+1;
     html += '.</th>';
     html += '<td width="20%"><select style="width: 200px" name="constraint" onChange="relation(this.value, ';
     html += id;
     html += ')" id="constraint_';
     html += id;
     html += '"><option value="major">Major</option>';
     html += '<option value="major_course">Number of Major Courses</option>';
     html += '<option value="course_number">Course Number Range</option>';
     html += '<option value="num_course">Number of Courses</option>';
     html += '<option value="c_time">Time</option>';
     html += '<option value="unit_per_course">Unit Per Course</option>';
     html += '<option value="credit">Credit</option>';
     html += '<option value="spe_course">Specified Courses</option>';
     html += '<option value="spe_section">Specified Sections</option>';
     html += '<option value="day">Class Days</option>';
     html += '<option value="dis">Discussion</option>';
     html += '<option value="lab">Laboratory</option>';
     html += '<option value="gened">GenEd</option>';
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