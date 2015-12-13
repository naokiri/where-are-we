EPS = 0.025; // Seems too wide, but felt good to me.
hotel_lat = 0.00;
hotel_lng = 0.00;
work_lat = 0.00;
work_lng = 0.00;

function near(a,b) {
	if (Math.abs(a - b) < EPS) {
		return true;
	}
	return false;
}


function setInitialChoice(lat, lng) {
	var date = new Date();
	document.querySelector("input[value='0']").checked = true;
	
	// check if close to office first
	if(near(lat, work_lat) && near(lng, work_lng)) {
		// Likely just came to office
		document.querySelector("input[value='10']").checked = true;

	}
	if(near(lat, hotel_lat) && near(lng, otel_lng)) {
		document.querySelector("input[value='11']").checked = true;

	}
}

function showForm() {
	var form = document.getElementById("form");
	form.style.display = "block";
	var spinner = document.getElementById("spinner");
	spinner.style.display = "none";
}
	

function initialize(){
    if (typeof(navigator.geolocation) != 'undefined') {
		navigator.geolocation.watchPosition(success, error);
    } else {
		var msg = document.getElementById("msg");
		msg.innerHTML = "No geolocation found";
		
		showForm();
	}
}

function success(position){
    var lat = position.coords.latitude;
    var lng = position.coords.longitude;
    
    var msg = document.getElementById("msg");
    msg.innerHTML = "<div>lat:" + lat + " lng:" + lng + "</div>" + "<div>" + (new Date()).toString() + "</div>";
	setInitialChoice(lat, lng);
	showForm();
}

function error(e){
    alert("Geolocation error: " + e.message);
	showForm();
}

window.onload = initialize;

