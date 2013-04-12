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

function printDayOff(days) {
  var day = '';
  for (var i = 0; i < days.length; i++) {
    if (days[i].checked) {
      day += days[i].value;
    }
  }
  return day;
}

$('#constraint').prop('selectedIndex', -1)

$('#search').bind('click', function (event) {
  var result = '<b>Your Search Criterial</b><br />Course Name/Number: '
             + $('input#cnum').val() + '<br />'
             + 'Course From: ' 
             + $('select#major').val() + $('input#csmall').val()
             + ' to '
             + $('select#major').val() + $('input#clarge').val() + '<br />'
             + 'Time from: '
             + $('select#tfrom').val()
             + ' to '
             + $('select#tto').val() + '<br />'
             + 'Day-off: '
             + printDayOff($('.day'))
          // + a list of tables
               ;
  $('div#list_class').html(result);
});

$('#recommend').bind('click', function (event) {
  $('div#recommendations').html('This is your recommendation');
});