var classes;

function getClasses(c){
 classes=c;
}

function searchSlotMon(t){
	var classes_json = {"classes":[{"name":"CMPSCI 311","time":"8:00AM-9:15AM" },{"name":"CMPSCI 383","time":"11:15AM-12:30PM" },{"name":"CMPSCI 320","time":"4:00PM-5:15PM"},{"name":"CMPSCI 377","time":"2:30PM-3:45PM" }]};
	
	for(var i = 0; i < classes_json.classes.length; i++){
	console.log(classes_json.classes[i].time.charAt(0) + ' ' + t.charAt(0));
		if(classes_json.classes[i].time.charAt(0)  === t.charAt(0) && 
		classes_json.classes[i].time.charAt(1)  === t.charAt(1))
			return classes_json.classes[i].name;
			
	}
	return;
			
}



function searchSlotTues(t){
	var classes_json = {"classes":[{"name":"CMPSCI 311","time":"8:00AM-9:15AM" },{"name":"CMPSCI 383","time":"11:15AM-12:30PM" },{"name":"CMPSCI 320","time":"4:00PM-5:15PM"},{"name":"CMPSCI 377","time":"2:30PM-3:45PM" }]};
	
	for(var i = 0; i < classes_json.classes.length; i++){
	console.log(classes_json.classes[i].time.charAt(0) + ' ' + t.charAt(0));
		if(classes_json.classes[i].time.charAt(0)  === t.charAt(0) && 
		classes_json.classes[i].time.charAt(1)  === t.charAt(1))
			return classes_json.classes[i].name;
			
	}
	return;
			
}

function searchSlotWed(t){
	var classes_json = {"classes":[{"name":"CMPSCI 311","time":"8:00AM-9:15AM" },{"name":"CMPSCI 383","time":"11:15AM-12:30PM" },{"name":"CMPSCI 320","time":"4:00PM-5:15PM"},{"name":"CMPSCI 377","time":"2:30PM-3:45PM" }]};
	
	for(var i = 0; i < classes_json.classes.length; i++){
	console.log(classes_json.classes[i].time.charAt(0) + ' ' + t.charAt(0));
		if(classes_json.classes[i].time.charAt(0)  === t.charAt(0) && 
		classes_json.classes[i].time.charAt(1)  === t.charAt(1))
			return classes_json.classes[i].name;
			
	}
	return;
			
}


function searchSlotThur(t){
	var classes_json = {"classes":[{"name":"CMPSCI 311","time":"8:00AM-9:15AM" },{"name":"CMPSCI 383","time":"11:15AM-12:30PM" },{"name":"CMPSCI 320","time":"4:00PM-5:15PM"},{"name":"CMPSCI 377","time":"2:30PM-3:45PM" }]};
	
	for(var i = 0; i < classes_json.classes.length; i++){
	console.log(classes_json.classes[i].time.charAt(0) + ' ' + t.charAt(0));
		if(classes_json.classes[i].time.charAt(0)  === t.charAt(0) && 
		classes_json.classes[i].time.charAt(1)  === t.charAt(1))
			return classes_json.classes[i].name;
			
	}
	return;
			
}			
			
function searchSlotFri(t){
	var classes_json = {"classes":[{"name":"CMPSCI 311","time":"8:00AM-9:15AM" },{"name":"CMPSCI 383","time":"11:15AM-12:30PM" },{"name":"CMPSCI 320","time":"4:00PM-5:15PM"},{"name":"CMPSCI 377","time":"2:30PM-3:45PM" }]};
	
	for(var i = 0; i < classes_json.classes.length; i++){
	console.log(classes_json.classes[i].time.charAt(0) + ' ' + t.charAt(0));
		if(classes_json.classes[i].time.charAt(0)  === t.charAt(0) && 
		classes_json.classes[i].time.charAt(1)  === t.charAt(1))
			return classes_json.classes[i].name;
			
	}
	return;
			
}
      

    
