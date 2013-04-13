var num_constraint = 0;
var constraints = [];

function constraint(count) {
  var id = count;
  var obj = {};

  obj.major = {
    "relation" : "<select><option value='equal'>Equal To</option></select>",
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
  	"relation" : "<select><option value='equal'>Equal To</option>"
  	           + "<option value='less_than'>Less Than Or Equal To</option>"
  	           + "<option value='greater_than'>Greater Than Or Equal To</option></select>",
  	   "input" : "<input id='time_"
            + id
            + "' class='input-medium' name='time' type='time' value='10:00:00'>"
  };

  obj.credit = {
  	"relation" : "<select><option value='equal'>Equal To</option>"
               + "<option value='less than'>Less Than Or Equal To</option>"
               + "<option value='greater than'>Greater Than Or Equal To</option></select>",
  	"input" : "<input id='credit_"
            + id
            + "' class='input-medium' name='time' type='time' value='10:00:00'>"
  };

  obj.num_course = {
  	"relation" : "<select><option value='equal'>Equal To</option>"
  	           + "<option value='less than'>Less Than Or Equal To</option>"
  	           + "<option value='greater than'>Greater Than Or Equal To</option></select>",
  	   "input" : "<input id='num_course_"
               + id
               + "' class='input-medium' name='time' type='time' value='10:00:00'>"
  };

  obj.spe_course = {
  	"relation" : "<select><option value='equal'>Equal To</option></select>",
    "input" : "<input id='spe_course_" + id + "' type='text' name='spc_course'>"
  };

  obj.day_off = {
    "relation" : "<select><option value='equal'>Equal To</option></select>",
    "input" : "<input type='checkbox' name='dayoff' value='Mo'> Mo"
            + "<input type='checkbox' name='dayoff' value='Tu'> Tu"
            + "<input type='checkbox' name='dayoff' value='We'> We"
            + "<input type='checkbox' name='dayoff' value='Th'> Th"
            + "<br>"
            + "<input type='checkbox' name='dayoff' value='Fr'> Fr"
            + "<input type='checkbox' name='dayoff' value='Sa'> Sa"
            + "<input type='checkbox' name='dayoff' value='Su'> Su"
  };

  return obj;
}

function relation(val, c) {
  var relation = '';
  var input = '';
  if (val === 'major'){
    relation += constraints[c].major.relation;
    input += constraints[c].major.input;
  }
  else if (val === 'c_time') {
    relation += constraints[c].c_time.relation;
    input += constraints[c].c_time.input;
  }
  else if (val === 'credit') {
    relation += constraints[c].credit.relation;
    input += constraints[c].credit.input;
  }
  else if (val === 'num-course') {
    relation += constraints[c].num_course.relation;
    input += constraints[c].num_course.input;
  }
  else if (val === 'spe-course') {
    relation += constraints[c].spe_course.relation;
    input += constraints[c].spe_course.input;
  }
  else if (val === 'dayoff') {
    relation += constraints[c].day_off.relation;
    input += constraints[c].day_off.input;
  }

  $('#r_' + c).html(relation);
  $('#i_' + c).html(input);
}

$('#additem').bind('click', function () {
  var c = Object.create(constraint(num_constraint));
  constraints.push(c);
  var id = num_constraint;
  $('div#msg').html('clicked');
  var html = '<tr><th>' 
     html += id;
     html += '.</th>';
     html += '<td><select name="constraint" onChange="relation(this.value, ';
     html += id;
     html += ')" id="constraint_';
     html += id;
     html += '"><option value="major">Major</option>';
     html += '<option value="c_time">Time</option>';
	   html += '<option value="credit">Credit</option>';
	   html += '<option value="num-course">Number of Courses</option>';
	   html += '<option value="spe-course">Specific Courses</option>';
	   html += '<option value="dayoff">Day-off</option></select></td>';
     html += '<td><div id="r_';
     html += id;
     html += '"><select><option></option></select></div></td>';
     html += '<td><div id="i_';
     html += id;
     html += '"><select><option></option></select></div></td></tr>';
     
  $('table#constraints').append(html);
  $('#constraint_' + id).prop('selectedIndex', -1);
  num_constraint++;
});