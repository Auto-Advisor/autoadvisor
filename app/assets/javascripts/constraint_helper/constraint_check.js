function hasElement (array, type, value) {

	for (var i = 0; i < array.length; i++) {
		if (array[i][type] === value)
			return true;
	}
	
	return false;
}