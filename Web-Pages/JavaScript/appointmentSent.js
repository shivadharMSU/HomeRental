async function getAppointmentsByCustomer(customerId) {
    try {
        const response = await fetch(apiUrl+`appointmentsByCustomer/${customerId}`);
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error fetching appointments:', error);
        return [];
    }
}

async function displayAppointmentsSent() {
    const userId = localStorage.getItem('userId');
    if (!userId) {
        window.location.href = 'Login.html';
        return;
    }
    const customerId = userId; 
    const appointments = await getAppointmentsByCustomer(customerId);

    const tableBody = document.querySelector('#appointmentsTable tbody');
    tableBody.innerHTML = '';

    appointments?.forEach(appointment => {
        const row = tableBody.insertRow();
        const propertyNameCell = row.insertCell();
        propertyNameCell.textContent = appointment.PropertyName;
        propertyNameCell.style.color = 'black';
        
        const priceCell = row.insertCell();
        priceCell.textContent = appointment.price;
        priceCell.style.color = 'black';
        
        const amenitiesCell = row.insertCell();
        amenitiesCell.textContent = appointment.Amenities;
        amenitiesCell.style.color = 'black';
        
        const addressCell = row.insertCell();
        addressCell.textContent = appointment.FullAddress;
        addressCell.style.color = 'black';
    });
}

displayAppointmentsSent();