function show_filter() {
  document.getElementById('filter_class').style.display = 'block';
  document.getElementById('recommendation').style.display = 'none';
  document.getElementById('adv_search').style.display = 'none';
}

function show_recommendation() {
  document.getElementById('filter_class').style.display = 'none';
  document.getElementById('recommendation').style.display = 'block';
  document.getElementById('adv_search').style.display = 'none';
}

function adv_filter(){
  document.getElementById('filter_class').style.display = 'none';
  document.getElementById('recommendation').style.display = 'none';
  document.getElementById('adv_search').style.display = 'block';
}
function showClass() {
  document.getElementById('list_class').style.display = 'block';
}


$(document).ready(function(){
  $('button#course_description').click(function(){
    $('div#class_description').toggle();
	  return false;
  });
});

$('#major').prop('selectedIndex', -1);

$('#class_1').bind('click', function (event) {
  var details = $('.details');
  for (var i = 0; i < details.length; i++) {
    details[i].style.display = 'block';
  }
});

$('#clear').bind('click', function (event) {
  $('#deg').html('hi');
});

$('#details').popover({
  "html": true,
  "title": "Software Engineering",
  "content": "<h4>Description</h4><div class='description'>In this course, students learn and gain practical experience with software engineering principles and techniques. The practical experience centers on a semester-long team project in which a software development project is carried through all the stages of the software life cycle. Topics in this course include requirements analysis, specification, design, abstraction, programming style, testing, maintenance, communication, teamwork, and software project management. Particular emphasis is placed on communication and negotiation skills and on designing and developing maintainable software.  This course satisfies the Integrative Experience requirement for BS-CMPSCI and BA-CMPSCI majors.  Use of computer required. Several written assignments, in-class presentations, exams, and a term project.</div>"

});