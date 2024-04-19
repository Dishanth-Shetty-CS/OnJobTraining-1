//Sets the main tag margin-top offset 
let main = document.getElementById("main");
let header = document.getElementById("header");
window.addEventListener("load", function () {
  let header_height = header.offsetHeight;
  main.style.marginTop = header_height + "px";
});

window.addEventListener("resize", function () {
  let header_height = header.offsetHeight;
  main.style.marginTop = header_height + "px";
});


var sidebar_options = document.getElementsByClassName("sidebar-options");

function loadDashboard() {
	
	
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}	
	sidebar_options[0].classList.add("active-sidebar-options");
}


document.getElementById('BookAppointment').addEventListener('click', function(event) {
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}
		
	sidebar_options[1].classList.add("active-sidebar-options");
	
    event.preventDefault(); 

    fetch('BookMyAppointment.jsp') 
        .then(response => response.text())
        .then(data => {
            document.getElementById('right-body').innerHTML = data; // Update the container with the fetched content
        })
        .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
        });
});


function bookAppointments(event) {
		event.preventDefault();
		
		const formData = new FormData(event.target);
		formData.append('registered_users_email_address', sessionStorage.getItem('registered_users_email_address'));
		
		fetch('BookMyAppointment.jsp?' + new URLSearchParams(formData).toString())
		.then(response => response.text())
		.then(data => {
			window.alert("Appointment Booked Successfully");
			document.getElementById("right-body").innerHTML = data;
		});
		
		return false;
}


document.getElementById('AppointmentHistory').addEventListener('click', function(event) {
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}
		
	sidebar_options[2].classList.add("active-sidebar-options");
	
    event.preventDefault(); 

    fetch('ViewAllAppointments.jsp')
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


document.getElementById('MyAppointments').addEventListener('click', function(event) {
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}
		
	sidebar_options[3].classList.add("active-sidebar-options");
	
    event.preventDefault(); 

    fetch('MyAppointments.jsp')
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


document.getElementById('Prescriptions').addEventListener('click', function(event) {
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}
		
	sidebar_options[4].classList.add("active-sidebar-options");
	
    event.preventDefault(); 

    fetch('Prescriptions.jsp') 
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

// Trigger loadDashboard function on page load
window.addEventListener('load', function() {
    loadDashboard();
});
