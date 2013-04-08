function show_filter() {
  document.getElementById('filter_class').style.display = 'block';
  document.getElementById('recommendation').style.display = 'none';
}

function show_recommendation() {
  document.getElementById('filter_class').style.display = 'none';
  document.getElementById('recommendation').style.display = 'block';
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

