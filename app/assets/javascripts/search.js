var details = [];

function print_result(data) {
  var string = '';
  for (var i = 0; i < data.length; i++) {
    string += "<div class = 'class_block'><table class='table table-hover table-bordered'>";
    string += "<thead><tr><th colspan='4'>" + data[i].name + '</th>';
    string += "<td class='manual_button' id='details" + i + "'>Details";
    string += "<span align='right' class='icon-arrow-right'></span></td></tr>";
    string += "<tr class='subhead'><th>Section</th><th>SpireID</th><th>Days & Times</th><th>Room</th><th>Instructor</th></tr>";
    string += "</thead><tbody>";
    for (var j = 0; j < data[i].sections.length; j++) {
      string += "<tr><td>" + data[i].sections[j].number + "</td>";
      string += "<td>" + data[i].sections[j].id + "</td>";
      string += "<td>" + data[i].sections[j].day + " " + data[i].sections[j].time + "</td>";
      string += "<td>" + data[i].sections[j].room + "</td>";
      string += "<td>" + data[i].sections[j].instructor + "</td></tr>";
    }
    string += "</tbody></table></div>";

    
  }
  return string;
}

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
  string += '"day": "' + getDays('day', '') + '"';
  string += '}';
  //$('#deg').html(string);

  function onSuccess(data) {
    $('#deg').html(JSON.stringify(data));
    $('#list_class').html(print_result(data));
    for (var i = 0; i < data.length; i++)
      $('#details' + i).popover({
        "html": true,
        "title": data[i].name,
        "content": data[i].details
      });
  }

  function onSend() {
    $('#deg').html("Sending Ajax");
  }

  $.ajax({
    type: 'POST',
    contentType: "application/json",
    url: '/schedule/search', 
    data: string,
    success: onSuccess,
    beforeSend: onSend,
    dataType: 'json'
  })
});