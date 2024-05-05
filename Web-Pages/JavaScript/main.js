// Function to populate the state dropdown
async function populateStateDropdown() {
    const stateDropdown = document.getElementById('stateDropdown');
    stateDropdown.innerHTML = '';

    // Add the default "Select" option
    const defaultOption = document.createElement('option');
    defaultOption.value = ''; // Empty value
    defaultOption.textContent = 'Select State';
    stateDropdown.appendChild(defaultOption);

    // Fetch states from an API or a database endpoint
    const response = await fetch(apiUrl+'getstatedetails'); // Replace with actual endpoint
    const states = await response.json();

    states.forEach(state => {
        const option = document.createElement('option');
        option.value = state.stateId;
        option.textContent = state.stateName;
        stateDropdown.appendChild(option);
    });

    // Add event listener to the state dropdown
    stateDropdown.addEventListener('change', onStateChange);
}

// Function to populate the city dropdown based on selected state
async function populateCityDropdown(stateId) {
    const cityDropdown = document.getElementById('cityDropdown');
    cityDropdown.innerHTML = '';

      // Add the default "Select" option
      const defaultOption = document.createElement('option');
      defaultOption.value = ''; // Empty value
      defaultOption.textContent = 'Select City';
      cityDropdown.appendChild(defaultOption);
    
    if (stateId > 0)
    {
        // Fetch cities based on stateId from an API or a database endpoint
        const response = await fetch(apiUrl+`getcitiesbystateid/${stateId}`); 
        const cities = await response.json();

        cities.forEach(city => {
            const option = document.createElement('option');
            option.value = city.CityId;
            option.textContent = city.CityName;
            cityDropdown.appendChild(option);
        });
    }  

}

// Event handler for state change
function onStateChange() {
    const selectedStateId = document.getElementById('stateDropdown').value;
    populateCityDropdown(selectedStateId);
}

async function populatePropertyTypeDropdown() {
    const propertyType = document.getElementById('propertyTypeId');
    propertyType.innerHTML = '';

    const defaultOption = document.createElement('option');
    defaultOption.value = ''; 
    defaultOption.textContent = 'Select Property Type';
    propertyType.appendChild(defaultOption);


    const response = await fetch(apiUrl+'getpropertytype'); 
    const propertyTypeData = await response.json();

    propertyTypeData.forEach(state => {
        const option = document.createElement('option');
        option.value = state.PropertyTypeId;
        option.textContent = state.PropertyTypeName;
        propertyType.appendChild(option);
    });
}

async function handleSearch() {
    const stateValue = document.getElementById('stateDropdown').value;
    const cityValue = document.getElementById('cityDropdown').value;
    const priceValue = document.getElementById('price').value !== '' ? parseFloat(document.getElementById('price').value) : null;
    const propertyTypeIdValue = document.getElementById('propertyTypeId').value !== '' ? document.getElementById('propertyTypeId').value : null;

    if (stateValue === "" || cityValue === "") {
        const noDataModal = new bootstrap.Modal(document.getElementById('pleaseFillAllDetails'));
        noDataModal.show();
        // alert('Please fill all the required fields(*)');
        return;
    }
    console.log('State:', stateValue);
    console.log('City:', cityValue);
    console.log('Price:', priceValue);
    console.log('Property Type:', propertyTypeIdValue);

    const response = await fetch(apiUrl+'getfilteredproperties', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            stateId: stateValue,
            cityId: cityValue,
            price: priceValue,
            propertyTypeId: propertyTypeIdValue,
            propertyId: null,
            ownerId : null            
        })
    });
    const properties = await response.json();
    if (properties.length === 0) {
        // Display a popup message if no data is available
        const noDataModal = new bootstrap.Modal(document.getElementById('noDataModal'));
        noDataModal.show();
    } else {
        // Do something with the retrieved properties
        console.log('Filtered Properties:', properties);
        displayProperties(properties);
    }
}


function displayProperties(properties) {
    const propertyDetailsContainer = document.getElementById('propertyDetailsContainer');
    propertyDetailsContainer.innerHTML = ''; // Clear previous results

    // Loop through the properties and create cards for each property
    for (let i = 0; i < properties.length; i += 2) {
        const cardRow = document.createElement('div');
        cardRow.classList.add('row');

        for (let j = i; j < i + 2 && j < properties.length; j++) {
            const property = properties[j];

            const cardCol = document.createElement('div');
            cardCol.classList.add('col-md-6', 'mb-3');

            const card = document.createElement('div');
            card.classList.add('card');

            // Property image
            const propertyImage = document.createElement('img');
            propertyImage.src = `JavaScript/uploads/${property.ImagePaths?.split(';')[0]}`;
            propertyImage.classList.add('card-img-top');
            propertyImage.alt = property.PropertyName;

            const cardBody = document.createElement('div');
            cardBody.classList.add('card-body');

            const propertyName = document.createElement('h5');
            propertyName.classList.add('card-title');
            propertyName.textContent = property.PropertyName;

            const propertyPrice = document.createElement('p');
            propertyPrice.classList.add('card-text');
            propertyPrice.innerHTML = `<strong>Price($):</strong> ${property.Price}`;

            const propertyAmenities = document.createElement('p');
            propertyAmenities.classList.add('card-text');
            propertyAmenities.innerHTML = `<strong>Amenities:</strong> ${property.Amenities}`;

            const propertyAvailability = document.createElement('p');
            propertyAvailability.classList.add('card-text');
            propertyAvailability.innerHTML = `<strong>Availability Date:</strong> ${new Date(property.AvailabilityDate).toLocaleDateString('en-US')}`;

            // Create the "Book Appointment" button
            const bookAppointmentButton = document.createElement('button');
            bookAppointmentButton.textContent = 'Book Appointment';
            bookAppointmentButton.classList.add('btn', 'btn-custom-pink', 'mt-2');
            bookAppointmentButton.addEventListener('click', () => {
                // Call the bookAppointment function and pass the property ID
                bookAppointment(property.PropertyId);
            });

            cardBody.appendChild(propertyName);
            cardBody.appendChild(propertyPrice);
            cardBody.appendChild(propertyAmenities);
            cardBody.appendChild(propertyAvailability);
            cardBody.appendChild(bookAppointmentButton);

            card.appendChild(propertyImage);
            card.appendChild(cardBody);
            cardCol.appendChild(card);
            cardRow.appendChild(cardCol);
        }

        propertyDetailsContainer.appendChild(cardRow);
    }
}





function bookAppointment(propertyId) {
    console.log('yes property id' + propertyId);
    window.location.href = `View-Property-Details.html?propertyId=${propertyId}`;

}

async function handleSavedProperty() {
    const customerId = localStorage.getItem('userId');
    
    if (!customerId) {
        alert('Please login to view saved property.');
        window.location.href = 'Login.html';
        return;
    }
    else {
        const response = await fetch(apiUrl+'getSavedProperties', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({               
                customerId : customerId            
            })
        });
        const properties = await response.json();
        console.log('saved Properties:', properties);

        displayProperties(properties);
    }
}
// Initialize the page
populateStateDropdown();
populatePropertyTypeDropdown();
populateCityDropdown(0);