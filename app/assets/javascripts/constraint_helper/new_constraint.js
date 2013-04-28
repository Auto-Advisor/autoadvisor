var newConstraint = function (type, operator, value) {
	console.log(type + ' ' + operator + ' ' + value);
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
	   html += '<option value="num_course">Number of Courses</option>';
     html += '<option value="unit_per_course">Unit Per Course</option>';
     html += '<option value="credit">Credit</option>';
	   html += '<option value="spe_course">Specific Courses</option>';
	   html += '<option value="dayoff">No Class Days</option>';
     html += '<option value="dis">Discussion</option>';
     html += '<option value="lab">Laboratory</option>';
     html += '<option value="gen">GenEd</option>';
     html += '<option value="num_major_course">Number of Major Courses</option>';
     html += '</select></td>';
     html += '<td><div id="r_';
     html += id;
     html += '"><select><option></option></select></div></td>';
     html += '<td><div id="i_';
     html += id;
     html += '"><select><option></option></select></div></td>';
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