function show_all_class() {
  document.getElementById('all_class').style.display = 'block';
  document.getElementById('filter_class').style.display = 'none';
  document.getElementById('recommendation').style.display = 'none';
  document.getElementById('search').style.display = 'none';
}

function show_filter() {
  document.getElementById('all_class').style.display = 'none';
  document.getElementById('filter_class').style.display = 'block';
  document.getElementById('recommendation').style.display = 'none';
  document.getElementById('search').style.display = 'none';
}

function show_recommendation() {
  document.getElementById('all_class').style.display ='none';
  document.getElementById('filter_class').style.display = 'none';
  document.getElementById('recommendation').style.display = 'block';
  document.getElementById('search').style.display = 'none';
}

function show_search() {
  document.getElementById('all_class').style.display = 'none';
  document.getElementById('filter_class').style.display = 'none';
  document.getElementById('recommendation').style.display = 'none';
  document.getElementById('search').style.display = 'block';
}

$(document).ready(function(){
  $('button#course_description').click(function(){
    $('div#class_description').toggle();
	return false;
  });
});

