
function searchSlotMon(t){
	var classes_json = {"classes":[{"name":"CMPSCI 240","time":"9:05AM-9:55AM" },{"name":"CMPSCI 383","time":"1:25-2:15PM" },{"name":"CMPSCI 320","time":"2:30PM-3:20PM"}]};
	
	for(var i = 0; i < classes_json.classes.length; i++){
	console.log(classes_json.classes[i].time.charAt(0) + ' ' + t.charAt(0));
		if(classes_json.classes[i].time.charAt(0)  === t.charAt(0) && 
		classes_json.classes[i].time.charAt(1)  === t.charAt(1))
			return classes_json.classes[i].name + '<br />' + classes_json.classes[i].time;		
	}
	return;
			
}



function searchSlotTues(t){
	var classes_json = {"classes":[{"name":"CMPSCI 326","time":"4:00PM-5:15PM" },{"name":"CMPSCI 513","time":"1:00PM-2:15PM" }]};
	
	for(var i = 0; i < classes_json.classes.length; i++){
	console.log(classes_json.classes[i].time.charAt(0) + ' ' + t.charAt(0));
		if(classes_json.classes[i].time.charAt(0)  === t.charAt(0) && 
		classes_json.classes[i].time.charAt(1)  === t.charAt(1))
			return classes_json.classes[i].name + '<br />' + classes_json.classes[i].time;		
	}
	return;
			
}

function searchSlotWed(t){
	var classes_json = {"classes":[{"name":"CMPSCI 240","time":"9:05AM-9:55AM" },{"name":"CMPSCI 383","time":"1:25-2:15PM" },{"name":"CMPSCI 320","time":"2:30PM-3:20PM"}]};
	
	for(var i = 0; i < classes_json.classes.length; i++){
	console.log(classes_json.classes[i].time.charAt(0) + ' ' + t.charAt(0));
		if(classes_json.classes[i].time.charAt(0)  === t.charAt(0) && 
		classes_json.classes[i].time.charAt(1)  === t.charAt(1))
			return classes_json.classes[i].name + '<br />' + classes_json.classes[i].time;	
	}
	return;
			
}


function searchSlotThur(t){
	var classes_json = {"classes":[{"name":"CMPSCI 326","time":"4:00PM-5:15PM" },{"name":"CMPSCI 513","time":"1:00PM-2:15PM" }]};
	
	for(var i = 0; i < classes_json.classes.length; i++){
	console.log(classes_json.classes[i].time.charAt(0) + ' ' + t.charAt(0));
		if(classes_json.classes[i].time.charAt(0)  === t.charAt(0) && 
		classes_json.classes[i].time.charAt(1)  === t.charAt(1))
			return classes_json.classes[i].name + '<br />' + classes_json.classes[i].time;		
	}
	return;
			
}			
			
function searchSlotFri(t){
	var classes_json = {"classes":[{"name":"CMPSCI 240","time":"9:05AM-9:55AM" },{"name":"CMPSCI 383","time":"1:25-2:15PM" },{"name":"CMPSCI 320","time":"2:30PM-3:20PM"}]};
	
	for(var i = 0; i < classes_json.classes.length; i++){
	console.log(classes_json.classes[i].time.charAt(0) + ' ' + t.charAt(0));
		if(classes_json.classes[i].time.charAt(0)  === t.charAt(0) && 
		classes_json.classes[i].time.charAt(1)  === t.charAt(1))
			return classes_json.classes[i].name + '<br />' + classes_json.classes[i].time;		
	}
	return;
			
}
      

    
