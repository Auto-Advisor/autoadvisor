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

$('#search').bind('click', function (event) {
  var string = '{';
  if($('#cnum').val()) {
    string += '"course_number_or_name": "' + $('#cnum').val() + '", ';
  }
  if($('#major').val()) {
    string += '"major": "' + $('#major').val() + '", ';
  }
  if($('#csmall').val()) {
    string += '"course_from": "' + $('#csmall').val() + '", ';
    if ($('#clarge').val()) {
      string += '"course_to": "' + $('#clarge').val() + '", ';
    }
    else{
      string += '"course_to": "' + $('#csmall').val() + '", ';
    }
  }
  string += '"time_from": "' + $('#time_from').val() + '", ';
  string += '"time_to": "' + $('#time_to').val() + '", ';
  string += '"day": "' + getDays('day') + '"';
  string += '}';
  $('#deg').html(string);
});

$('#clear').bind('click', function (event) {
  $('#deg').html('hi');
});
