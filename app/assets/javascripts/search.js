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
    $('#deg').html("<%= escape_javaScript(@result) %>");
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