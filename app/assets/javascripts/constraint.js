/**
 * Constraint object constructor is in ./constraint_helper/constraint_list.js
 */

var num_constraint = 0;
var constraints = [];
var dontwant = [];

function relation(row_element) {
  var rels = {
    "major": {
    "relation" : "<select><option value='equal'>Equal To</option></select>",
    "input" : "<select class='major'><option value='ACCOUNTG'>Accounting</option>"
      + "<option value='AEROSPAC'>Aerospace Studies</option>"
      + "<option value='AFROAM'>Afro-American Studies</option>"
      + "<option value='ANIMLSCI'>Animal Science</option>"
      + "<option value='ANTHRO'>Anthropology</option>"
      + "<option value='ARABIC'>Arabic</option>"
      + "<option value='ARCH-DES'>Architecture and Design</option>"
      + "<option value='ART'>Art</option>"
      + "<option value='ART-HIST'>Art History</option>"
      + "<option value='ASIAN-ST'>Asian Studies</option>"
      + "<option value='ASTRON'>Astronomy</option>"
      + "<option value='BDIC'>Bachelor's Deg W/indiv Conc.</option>"
      + "<option value='BIOCHEM'>Biochemistry & Molecular Bio.</option>"
      + "<option value='BIOLOGY'>Biology</option>"
      + "<option value='BCT'>Building & Construction Tech</option>"
      + "<option value='CHEM-ENG'>Chemical Engineering</option>"
      + "<option value='CHEM'>Chemistry</option>"
      + "<option value='CHINESE'>Chinese</option>"
      + "<option value='CE-ENGIN'>Civil & Environmental Engrg</option>"
      + "<option value='CLASSICS'>Classics</option>"
      + "<option value='COMM'>Communication</option>"
      + "<option value='COMM-DIS'>Communication Disorders</option>"
      + "<option value='COMP-LIT'>Comparative Literature</option>"
      + "<option value='CMPSCI'>Computer Science</option>"
      + "<option value='DANCE'>Dance</option>"
      + "<option value='ECON'>Economics</option>"
      + "<option value='EDUC'>Education</option>"
      + "<option value='E&C-ENG'>Electrical & Computer Engin</option>"
      + "<option value='ENGIN'>Engineering</option>"
      + "<option value='ENGLISH'>English</option>"
      + "<option value='ENGLWRIT'>English Writing Program</option>"
      + "<option value='ENVIRDES'>Environmental Design</option>"
      + "<option value='ECO'>Environmental Conservation</option>"
      + "<option value='ENVIRSCI'>environmental Science</option>"
      + "<option value='FINANCE'>Finance</option>"
      + "<option value='FOOD-SCI'>Food Science</option>"
      + "<option value='FRENCHST'>French Studies</option>"
      + "<option value='GEO-SCI'>Geosciences</option>"
      + "<option value='GERMAN'>German</option>"
      + "<option value='GREEK'>Greek</option>"
      + "<option value='HEBREW'>Hebrew</option>"
      + "<option value='HISTORY'>History</option>"
      + "<option value='HONORS'>Honors College</option>"
      + "<option value='HT-MGT'>Hospitality & Tourism Management</option>"
      + "<option value='HUMANDEV'>Human Development</option>"
      + "<option value='HM&FNART'>Humanity & Fine Arts</option>"
      + "<option value='ITALIAN'>Italian Studies</option>"
      + "<option value='JAPANESE'>Japanese</option>"
      + "<option value='JOURNAL'>Journalism</option>"
      + "<option value='JUDAIC'>Judaic Studies</option>"
      + "<option value='KIN'>Kinesiology</option>"
      + "<option value='LANDARCH'>Landscape Architecture</option>"
      + "<option value='LANDCONT'>Landscape Contracting</option>"
      + "<option value='LATIN'>Latin</option>"
      + "<option value='LATIN-AM'>Latin American Studies</option>"
      + "<option value='LATIN-ED'>Latin-student Teaching</option>"
      + "<option value='LEGAL'>Legal Studies</option>"
      + "<option value='LINGUIST'>Linguistics</option>"
      + "<option value='MANAGMNT'>Management</option>"
      + "<option value='MARKETNG'>Marketing</option>"
      + "<option value='MATH'>Mathematics</option>"
      + "<option value='M&I-ENG'>Mechnical & Industrial Engin</option>"
      + "<option value='MICROBIO'>Microbiology</option>"
      + "<option value='MIDEAST'>Middle Eastern Studies</option>"
      + "<option value='MILITARY'>Military Leadership</option>"
      + "<option value='EURO'>Modern Europe Studies</option>"
      + "<option value='MOLCLBIO'>Molecular & Cellular Biology</option>"
      + "<option value='MUSIC'>Music</option>"
      + "<option value='MUSIC-ED'>Music Education</option>"
      + "<option value='MUSICAPP'>Music, Applied</option>"
      + "<option value='NRC'>National Resource Conservation</option>"
      + "<option value='NEUROS&B'>Neuroscience & Behavior</option>"
      + "<option value='NURSING'>Nursing</option>"
      + "<option value='NUTRITN'>Nutrition</option>"
      + "<option value='OIM'>Operation & Info Management</option>"
      + "<option value='ORG&EVBI'>Organismic & Evolutionary Bio</option>"
      + "<option value='PHIL'>Philosophy</option>"
      + "<option value='PHYSICS'>Physics</option>"
      + "<option value='PLSOILIN'>Plant & Soil Sciences</option>"
      + "<option value='POLISH'>Polish</option>"
      + "<option value='POLISCI'>Political Science</option>"
      + "<option value='POLYMER'>Polymer Science & Engineering</option>"
      + "<option value='PORTUG'>Portuguese</option>"
      + "<option value='PORTUGED'>Pourtuguese-Student Teaching</option>"
      + "<option value='PSYCH'>Psychology</option>"
      + "<option value='PUBHLTH'>Public Health</option>"
      + "<option value='PUBP&ADM'>Public Policy & administration</option>"
      + "<option value='REGIONPL'>Regional Planning</option>"
      + "<option value='RES-ECON'>Resource Economics</option>"
      + "<option value='RUSSIAN'>Russian</option>"
      + "<option value='SCANDIN'>Scandinavian</option>"
      + "<option value='SRVCLRNG'>Service Learning</option>"
      + "<option value='STPEC'>Social Thought & Polic. Econ</option>"
      + "<option value='SOCIOL'>Sociology</option>"
      + "<option value='SPANISH'>Spanish</option>"
      + "<option value='SPANISHED'>Spanish-Student Teaching</option>"
      + "<option value='SPORTMGT'>Sport management</option>"
      + "<option value='STATISTIC'>Statistics</option>"
      + "<option value='STOCKSCH'>Stockbridge School</option>"
      + "<option value='SWEDISH'>Swedish</option>"
      + "<option value='THEATER'>Theater</option>"
      + "<option value='WOMENSST'>Women, Gender, Sexuality</option>"
      + "<option value='YIDDISH'>Yiddish</option></select>"
    },

    'c_time': {
      "relation" : "<select>"
                 + "<option value='less than'>Less Than Or Equal To</option>"
                 + "<option value='greater than'>Greater Than Or Equal To</option></select><br><input id='time' class='input-medium' name='time' type='time' value='10:00:00'>",
      "input" : "On<br /><div id='timeday'>"
              + "<div class='btn-group' data-toggle='buttons-checkbox'>"
              + "<button type='button' class='btn' value='Su'>Su</button>"
              + "<button type='button' class='btn active' value='Mo'>Mo</button>"
              + "<button type='button' class='btn active' value='Tu'>Tu</button>"
              + "<button type='button' class='btn active' value='We'>We</button>"
              + "<button type='button' class='btn active' value='Th'>Th</button>"
              + "<button type='button' class='btn active' value='Fr'>Fr</button>"
              + "<button type='button' class='btn' value='Sa'>Sa</button>"
              + "</div></div>"
    },

    "credit": {
      "relation" : "<select><option value='equal'>Equal To</option>"
                 + "<option value='less than'>Less Than Or Equal To</option>"
                 + "<option value='greater than'>Greater Than Or Equal To</option></select>",
      "input" : "<input id='credit' class='input-medium' name='credit' type='number' min=1 step=1 value='12'>"
    },

    "num_course": {
      "relation" : "<select><option value='equal'>Equal To</option>"
               + "<option value='less than'>Less Than Or Equal To</option>"
               + "<option value='greater than'>Greater Than Or Equal To</option></select>",
       "input" : "<input id='num_course' class='input-medium' name='num_course' type='number' min=1 step=1 value='3'>"
    }, 

    "spe_course": {
      "relation" : "<select><option value='equal'>Equal To</option></select>",
      "input" : "<input id='spe_course' type='text' name='spc_course'>"
    },

    "dayoff": {
      "relation" : "<select><option value='equal'>Equal To</option></select>",
      "input" : "<div id='dayoff'>"
              + "<div class='btn-group' data-toggle='buttons-checkbox'>"
              + "<button type='button' class='btn' value='Mo'>Mo</button>"
              + "<button type='button' class='btn' value='Tu'>Tu</button>"
              + "<button type='button' class='btn' value='We'>We</button>"
              + "<button type='button' class='btn' value='Th'>Th</button>"
              + "<button type='button' class='btn' value='Fr'>Fr</button>"
              + "</div></div>"
    },

    "course_range": {
      "relation" : "<select><option value='equal'>Equal To</option>"
               + "<option value='less than'>Less Than Or Equal To</option>"
               + "<option value='greater than'>Greater Than Or Equal To</option></select>",
      "input" : "<input id='course_range' class='input-medium' name='course_range' type='number' min=1 max=600 step=1 value='000'>"
    },

    "dis": {
      "relation" : " <select><option value='equal'>Equal To</option></select>",
      "input" : "<input type='checkbox' id='dis' value='dis'> Discussion"        
    },

    "lab": {
      "relation" : " <select><option value='equal'>Equal To</option></select>",
      "input" : "<input type='checkbox' id='lab' value='lab'> Laboratory"        
    },

    "gen": {
      "relation" : "<select><option value='equal'>Equal To</option></select>",
      "input" : "<input type='checkbox' id='gen' value='gen'> GenEd"
    },

    "num_major_course": {
      "relation" : " <select><option value='equal'>Equal To</option>"
                 + "<option value='less than'>Less Than Or Equal To</option>"
                 + "<option value='greater than'>Greater Than Or Equal To</option></select>",
      "input" : "<input id='num_of_major_course"
              + "' class='input-medium' name='num_major_course' type='number' min=1 max=5 step=1 value='3'>"
    }


  }
  var r = $(row_element).parent().parent();
  var type = r.find('.constraint').first().val();
  var relation = rels[type]["relation"];
  var input = rels[type]["input"];
  r.find('.relation').first().html(relation);
  r.find('.input').first().html(input);
}

$('#additem').bind('click', function () {
  var c = Object.create(constraint(num_constraint));
  constraints.push(c);
  var id = num_constraint;
  $('div#msg').html('clicked');
  var html = '<tr class="constraint_row"';
     html += '><th>';
     html += id+1;
     html += '.</th>';
     html += '<td><select name="constraint" onChange="relation(this)" class="constraint"><option value="major">Major</option>';
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
     html += '<td><div class="relation"';
     html += '"><select><option></option></select></div></td>';
     html += '<td><div class="input';
     html += '"><select><option></option></select></div></td>';
     html += '<td><a class="btn btn-danger" id="remove_constraint">Delete</a>';
     html += '</td>'
     html += '</tr>';
     
  var row = $(html);
  $('table#constraints').append(row);
  relation(row.get());
  $('#constraint_' + id).prop('selectedIndex', -1);

  $('#remove_constraint_' + id).bind('click', function() {
    constraints[id].active = undefined;
    $('#constraint_row_' + id).hide();
  })
  num_constraint++;
});

function getRelation(relation) {
  var string = "";
  if (relation === 'equal') {
    string += "\=";
  }
  else if (relation === 'less than') {
    string += "\<\=";
  }
  else if (relation === 'greater than') {
    string += "\>\=";
  }
  return string;
}

function getDays(type, i) {
  string = '';
  $('#' + type + '_' + i + ' .btn.active').each(function () {
    string += this.value;
  })
  return string;
}

function firstThing() {
  var i = 0;
  for (i; i < constraints.length; i++) {
    if (constraints[i].active != undefined)
      return i;
  }
}

function get_constraint(row) {
  var r = $(row);
  var c_type = r.find(".constraint").first().val();
  var hash = {"type": c_type};
  var rel = r.find(".relation").first().children().first().val();
  var val = r.find(".input").children().first().val();
  if (c_type == "major") {
    hash['major'] = r.find(".major").first().val();
  } else if (c_type == "c_time") {

  } else if (c_type == "credit" || c_type == "num_courses" || c_type == "course_range") {
    hash['operation'] = getRelation(rel);
    hash['input'] = val;
  } else if (c_type == "spe_course") {
    hash['spe_course'] = val;
  } else if (c_type == "dayoff") {
    hash['daysoff'] = getDays(val);
  } else if (c_type == "dis") {
    hash['discussion'] = val;
  } else if (c_type == "lab") {
    hash['laboratory'] = val;
  } else if (c_type == "gen") {
    hash['gen'] = val;
  }

  else if (c_type == "num_major_course") {
    hash['operation'] = getRelation(rel);
    hash['num_major_course'] = val;
  }
  return hash;
}

function get_constraints_array() {
  var constraints = $("#constraints .constraint_row").map(function(index, row) {
    return get_constraint(row);
  }).get();
  return constraints;
}

function getRecommendation() {
  $('#msg').html('Recommendation Clicked');

  var constraints = get_constraints_array();

  $('#string').html(JSON.stringify(constraints));

  $.ajax({
    type: "POST",
    contentType: "application/json",
    url: "/schedule/generate.json", data: JSON.stringify(constraints),
    success: function(data, text_status, jqXHR) {
      print_recommendation(data);

     },
    beforeSend: function() {
      $('#recommendations').html("Please wait... I am looking for schedules which are suitable for you :)");
    },
    fail: function(jqXHR, textStatus, errorThrown) {
      alert("panic");
    }
  });
}

$('#getrecommend').bind('click', getRecommendation);



$('#constraint').prop('selectedIndex', -1)