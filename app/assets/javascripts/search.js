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
  var search = [];
  if ($('#major').val()) {
    search.push({'type': 'major', 'major': $('#major').val()})
  }

  if ($('#csmall').val()) {
    var course_range = {'type': 'course_range'};
    course_range['lower'] = $('#csmall').val();
    if ($('#clarge').val()) {
      course_range['upper'] = $('#clarge').val();
    }
    search.push(course_range);
  }

  if ($('#course_unit_low').val()) {
    var course_unit = {'type': 'units', 'lower': $('#course_unit_low').val()};
    if ($('#course_unit_high').val()) {
      course_unit['upper'] = $('#course_unit_high').val();
    }
    search.push(course_unit);
  }

  else if ($('#course_unit_high').val()) {
    search.push({'type': 'units', 'upper': $('#course_unit_high').val()})
  }

  search.push({'type': 'time', 'lower': $('#time_from').val(),
               'upper': $('#time_to').val()});

  search.push({'type': 'days', 'days': getDays('day', '')});

  if ($('#lab').prop('checked')) {
    search.push({'type': 'lab', 'lab': true});
  }

  if ($('#dis').prop('checked')) {
    search.push({'type': 'dis', 'discussion': true});
  }

  if ($('#gened').val()) {
    search.push({'type': 'gened', 'string': $('#gen').val()});
  }

  $('#deg').html(JSON.stringify(search));

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

  // $.ajax({
  //   type: 'POST',
  //   contentType: "application/json",
  //   url: '/schedule/search', 
  //   data: string,
  //   success: onSuccess,
  //   beforeSend: onSend,
  //   dataType: 'json'
  // })
});