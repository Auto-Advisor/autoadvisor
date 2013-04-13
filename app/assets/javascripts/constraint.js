var num_constraint = 0;
var constraints = [];

function constraint(count) {
  var id = count;
  var obj = {};
  var active = undefined;

  obj.major = {
    "relation" : "<select id='relation_" + id + "'><option value='equal'>Equal To</option></select>",
    "input" : "<select id='major_" + id + "'><option value='ACCOUNTG'>Accounting</option>"
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
  };

  obj.c_time = {
  	"relation" : "<select id='relation_" + id + "'><option value='equal'>Equal To</option>"
  	           + "<option value='less than'>Less Than Or Equal To</option>"
  	           + "<option value='greater than'>Greater Than Or Equal To</option></select><br><input id='time_"
  	           + id
               + "' class='input-medium' name='time' type='time' value='10:00:00'>",
       "input" : "<input type='checkbox' id='time_day_1' value='Mo' checked='true'> Mo"
                + "<input type='checkbox' id='time_day_2' value='Tu' checked='true'> Tu"
                + "<input type='checkbox' id='time_day_3' value='We' checked='true'> We"
                + "<input type='checkbox' id='time_day_4' value='Th' checked='true'> Th"
                + "<br>"
                + "<input type='checkbox' id='time_day_5' value='Fr' checked='true'> Fr"
                + "<input type='checkbox' id='time_day_6' value='Sa'> Sa"
                + "<input type='checkbox' id='time_day_7' value='Su'> Su"
  };

  obj.credit = {
  	"relation" : "<select id='relation_" + id + "'><option value='equal'>Equal To</option>"
               + "<option value='less than'>Less Than Or Equal To</option>"
               + "<option value='greater than'>Greater Than Or Equal To</option></select>",
  	"input" : "<input id='credit_"
            + id
            + "' class='input-medium' name='credit' type='number' min=1 step=1 value='12'>"
  };

  obj.num_course = {
  	"relation" : "<select id='relation_" + id + "'><option value='equal'>Equal To</option>"
               + "<option value='less than'>Less Than Or Equal To</option>"
               + "<option value='greater than'>Greater Than Or Equal To</option></select>",
  	   "input" : "<input id='num_course_"
               + id
               + "' class='input-medium' name='num_course' type='number' min=1 step=1 value='3'>"
  };

  obj.spe_course = {
  	"relation" : "<select id='relation_" + id + "'><option value='equal'>Equal To</option></select>",
    "input" : "<input id='spe_course_" + id + "' type='text' name='spc_course'>"
  };

  obj.day_off = {
    "relation" : "<select id='relation_" + id + "'><option value='equal'>Equal To</option></select>",
    "input" : "<input type='checkbox' id='dayoff_1' value='Mo'> Mo"
            + "<input type='checkbox' id='dayoff_2' value='Tu'> Tu"
            + "<input type='checkbox' id='dayoff_3' value='We'> We"
            + "<input type='checkbox' id='dayoff_4' value='Th'> Th"
            + "<br>"
            + "<input type='checkbox' id='dayoff_5' value='Fr'> Fr"
            + "<input type='checkbox' id='dayoff_6' value='Sa'> Sa"
            + "<input type='checkbox' id='dayoff_7' value='Su'> Su"
  };

  obj.course_range = {
    "relation" : "<select id='relation_" + id + "'><option value='equal'>Equal To</option>"
               + "<option value='less than'>Less Than Or Equal To</option>"
               + "<option value='greater than'>Greater Than Or Equal To</option></select>",
    "input" : "<input id='course_range_"
            + id
            + "' class='input-medium' name='course_range' type='number' min=1 max=600 step=1 value='000'>"
  }

  obj.dis_lab = {
    "relation" : "<input type='checkbox' id='dis' value='dis'> Have Discussion",
    "input" : "<input type='checkbox' id='lab' value='lab'> Have Laboratory"
  }

  obj.gen = {
    "relation" : "<select id='relation_" + id + "'><option value='equal'>Equal To</option></select>",
       "input" : "<input type='checkbox' id='gen' value='gen'> GenEd"
  }

  return obj;
}

function relation(val, c) {
  var relation = '';
  var input = '';
  if (val === 'major'){
    relation += constraints[c].major.relation;
    input += constraints[c].major.input;
    constraints[c].active = 'major';
  }
  else if (val === 'c_time') {
    relation += constraints[c].c_time.relation;
    input += constraints[c].c_time.input;
    constraints[c].active = 'c_time';
  }
  else if (val === 'credit') {
    relation += constraints[c].credit.relation;
    input += constraints[c].credit.input;
    constraints[c].active = 'credit';
  }
  else if (val === 'num-course') {
    relation += constraints[c].num_course.relation;
    input += constraints[c].num_course.input;
    constraints[c].active = 'num-course';
  }
  else if (val === 'spe-course') {
    relation += constraints[c].spe_course.relation;
    input += constraints[c].spe_course.input;
    constraints[c].active = 'spe-course';
  }
  else if (val === 'dayoff') {
    relation += constraints[c].day_off.relation;
    input += constraints[c].day_off.input;
    constraints[c].active = 'dayoff';
  }
  else if (val === 'course_range') {
    relation += constraints[c].course_range.relation;
    input += constraints[c].course_range.input;
    constraints[c].active = 'course_range';
  }
  else if (val === 'dis_lab') {
    relation += constraints[c].dis_lab.relation;
    input += constraints[c].dis_lab.input;
    constraints[c].active = 'dis_lab';
  }
  else if (val === 'gen') {
    relation += constraints[c].gen.relation;
    input += constraints[c].gen.input;
    constraints[c].active = 'gen';
  }

  $('#r_' + c).html(relation);
  $('#i_' + c).html(input);
}

$('#additem').bind('click', function () {
  var c = Object.create(constraint(num_constraint));
  constraints.push(c);
  var id = num_constraint;
  $('div#msg').html('clicked');
  var html = '<tr id="constraint_row_';
     html += id;
     html += '"><th>';
     html += id+1;
     html += '.</th>';
     html += '<td><select name="constraint" onChange="relation(this.value, ';
     html += id;
     html += ')" id="constraint_';
     html += id;
     html += '"><option value="major">Major</option>';
     html += '<option value="course_range">Course Number Range</option>';
     html += '<option value="c_time">Time</option>';
	   html += '<option value="num-course">Number of Courses</option>';
     html += '<option value="credit">Credit</option>';
	   html += '<option value="spe-course">Specific Courses</option>';
	   html += '<option value="dayoff">Day-off</option>';
     html += '<option value="dis_lab">Discussion Or Laboratory</option>';
     html += '<option value="gen">GenEd</option>'
     html += '</select></td>'
     html += '<td><div id="r_';
     html += id;
     html += '"><select><option></option></select></div></td>';
     html += '<td><div id="i_';
     html += id;
     html += '"><select><option></option></select></div></td>';
     html += '<td><a href="#" onclick="remove(';
     html += id;
     html += ')"><img class="remove" id="';
     html += id;
     html += '"src="http://www.clker.com/cliparts/1/1/9/2/12065738771352376078Arnoud999_Right_or_wrong_5.svg.hi.png" width="30px" height="30px"/></a></td>'
     html += '</tr>';
     
  $('table#constraints').append(html);
  $('#constraint_' + id).prop('selectedIndex', -1);
  num_constraint++;
});

function remove(i) {
  constraints[i].active = undefined;
  $('#constraint_row_' + i).hide();
}

function getRelation (ind) {
  var relation = $('#relation_' + ind).val();
  console.log(relation);
  var string = '';
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

function getDays(type) {
  string = '';
  for (var i = 1; i < 8; i++) {
    if ($('#' + type + '_' + i).prop('checked')) {
      string += $('#' + type + '_' + i).val();
    }
  }
  return string;
}

function getString(cons_ind) {
  var string = '';
  if (constraints[cons_ind].active === 'major') {
    string += '"major": "' + $('#major_' + cons_ind).val() + '"';
  }
  else if (constraints[cons_ind].active === 'c_time') {
    string += '"time": {{"operator": "';
    string += getRelation(cons_ind) + '", "value": "';
    string += $('#time_' + cons_ind).val() + '"}, "on": "'
    string += getDays('time_day') + '"';
  }
  else if (constraints[cons_ind].active === 'credit') {
    string += '"credit": {"operator": "';
    string += getRelation(cons_ind) + '", "value": "';
    string += $('#credit_' + cons_ind).val() + '"}';
  }
  else if (constraints[cons_ind].active === 'num-course') {
    string += '"num_course": {"operator": "';
    string += getRelation(cons_ind) + '", "value": "';
    string += $('#num_course_' + cons_ind).val() + '"}';
  }
  else if (constraints[cons_ind].active === 'spe-course') {
    string += '"spe_course": "';
    string += $('#spe_course_' + cons_ind).val() + '"';
  }
  else if (constraints[cons_ind].active === 'dayoff') {
    string += '"dayoff": "';
    string += getDays('dayoff') + '"';
  }
  else if (constraints[cons_ind].active === 'course_range') {
    string += '"course_range" : {"operator": "';
    string += getRelation(cons_ind) + '", "value": "';
    string += $('#course_range_' + cons_ind).val() + '"}';
  }
  else if (constraints[cons_ind].active === 'dis_lab') {
    string += '"dis": ';
    if ($('#dis').prop('checked')) {
      string += 'true';
    } else {
      string += 'false';
    }
    string += ', "lab": ';
    if ($('#lab').prop('checked')) {
      string += 'true';
    } else {
      string += 'false';
    }
  }
  else if (constraints[cons_ind].active === 'gen') {
    string += '"gen": ';
    if ($('#gen').prop('checked')) {
      string += 'true';
    } else {
      string += 'false';
    }
  }
  return string;
}

function firstThing() {
  var i = 0;
  for (i; i < constraints.length; i++) {
    if (constraints[i].active != undefined)
      return i;
  }
}

$('#getrecommend').bind('click', function () {
  $('#msg').html('Recommendation Clicked');

  var c_string = '{';
  var i = firstThing();
  c_string += getString(i);
  for (i = i+1; i < constraints.length; i++) {
    if (constraints[i].active != undefined)
      c_string += ', ' + getString(i);
  }
  c_string += '}';


  $('#string').html(c_string);
});

$('#constraint').prop('selectedIndex', -1)