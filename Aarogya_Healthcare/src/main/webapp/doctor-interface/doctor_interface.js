//Sets the main tag margin-top offset 
let main = document.getElementById("main");
let header = document.getElementById("header");
window.addEventListener("load", function() {
	let header_height = header.offsetHeight;
	main.style.marginTop = header_height + "px";
});

window.addEventListener("resize", function() {
	let header_height = header.offsetHeight;
	main.style.marginTop = header_height + "px";
});


document.getElementById('ViewAppointments').addEventListener('click', function(event) {
	event.preventDefault();

	fetch('ViewAppointments.jsp')
		.then(response => {
			if (!response.ok) {
				throw new Error('Network response was not ok');
			}
			return response.text();
		})
		.then(data => {
			document.getElementById('right-body').innerHTML = data; // Update the container with the fetched content
		})
		.catch(error => {
			console.error('There was a problem with the fetch operation:', error);
		});
});


document.getElementById('PatientLists').addEventListener('click', function(event) {
	event.preventDefault();

	fetch('PatientsLists.jsp')
		.then(response => {
			if (!response.ok) {
				throw new Error('Network response was not ok');
			}
			return response.text();
		})
		.then(data => {
			document.getElementById('right-body').innerHTML = data; // Update the container with the fetched content
		})
		.catch(error => {
			console.error('There was a problem with the fetch operation:', error);
		});
});

//Accept Appointment
let Accept_btn = document.getElementById('Accept-btn');
if (Accept_btn) {
	
	Accept_btn.addEventListener('click', function(event) {
		event.preventDefault();
	
		fetch('AcceptAppointments.jsp')
			.then(response => {
				if (!response.ok) {
					throw new Error('Network response was not ok');
				}
				return response.text();
			})
			.then(data => {
				document.getElementById('right-body').innerHTML = data; // Update the container with the fetched content
			})
			.catch(error => {
				console.error('There was a problem with the fetch operation:', error);
			});
	});
}

//Decline Appointment
let Decline_btn = document.getElementById('Decline-btn');
if (Decline_btn) {
	
	Decline_btn.addEventListener('click', function(event) {
		event.preventDefault();
	
		fetch('DeclineAppointments.jsp')
			.then(response => {
				if (!response.ok) {
					throw new Error('Network response was not ok');
				}
				return response.text();
			})
			.then(data => {
				document.getElementById('right-body').innerHTML = data; // Update the container with the fetched content
			})
			.catch(error => {
				console.error('There was a problem with the fetch operation:', error);
			});
	});
}

document.getElementById('Prescribe').addEventListener('click', function() {	

	fetch('Prescribe.jsp')
		.then(response => response.text())
		.then(data => {
			document.getElementById('right-body').innerHTML = data; // Update the container with the fetched content
		})
		.catch(error => {
			console.error('There was a problem with the fetch operation:', error);
		});
});

