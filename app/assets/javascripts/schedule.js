function show_filter() {
  document.getElementById('filter_class').style.display = 'block';
  $('#showSearch').attr('class', 'active');
  document.getElementById('recommendation').style.display = 'none';
  $('#showRec').attr('class', '');
}

function show_recommendation() {
  document.getElementById('filter_class').style.display = 'none';
  $('#showSearch').attr('class', '');
  document.getElementById('recommendation').style.display = 'block';
  $('#showRec').attr('class', 'active');
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

$('#search').bind('click', function (event) {

});

$('#clear').bind('click', function (event) {
  for (var i = 1; i < 8; i++){
    $('#day_' + i).checked = false;
  }
});