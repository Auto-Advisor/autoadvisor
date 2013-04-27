 var constraint = function (count) {
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
  	"relation" : "<select id='relation_" + id + "'>"
  	           + "<option value='less than'>Less Than Or Equal To</option>"
  	           + "<option value='greater than'>Greater Than Or Equal To</option></select><br><input id='time_"
  	           + id
               + "' class='input-medium' name='time' type='time' value='10:00:00'>",
    "input" : "On<br /><div id='timeday_" + id + "'>"
            + "<div class='btn-group' data-toggle='buttons-checkbox'>"
            + "<button type='button' class='btn' value='Su'>Su</button>"
            + "<button type='button' class='btn active' value='Mo'>Mo</button>"
            + "<button type='button' class='btn active' value='Tu'>Tu</button>"
            + "<button type='button' class='btn active' value='We'>We</button>"
            + "<button type='button' class='btn active' value='Th'>Th</button>"
            + "<button type='button' class='btn active' value='Fr'>Fr</button>"
            + "<button type='button' class='btn' value='Sa'>Sa</button>"
            + "</div></div>"
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
    "input" : "<div id='dayoff_" + id + "'>"
            + "<div class='btn-group' data-toggle='buttons-checkbox'>"
            + "<button type='button' class='btn' value='Su'>Su</button>"
            + "<button type='button' class='btn' value='Mo'>Mo</button>"
            + "<button type='button' class='btn' value='Tu'>Tu</button>"
            + "<button type='button' class='btn' value='We'>We</button>"
            + "<button type='button' class='btn' value='Th'>Th</button>"
            + "<button type='button' class='btn' value='Fr'>Fr</button>"
            + "<button type='button' class='btn' value='Sa'>Sa</button>"
            + "</div></div>"
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
};