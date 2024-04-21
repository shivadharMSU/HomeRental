function getPropertyIdFromQueryString() {
  const urlParams = new URLSearchParams(window.location.search);
  return urlParams.get('propertyId');
}


// Function to populate the state dropdown
async function populateStateDropdown() {
  const stateDropdown = document.getElementById('stateId');
  stateDropdown.innerHTML = '';

 
  const defaultOption = document.createElement('option');
  defaultOption.value = ''; // Empty value
  defaultOption.textContent = 'Select State';
  stateDropdown.appendChild(defaultOption);

  // Fetch states from an API or a database endpoint
  const response = await fetch(apiUrl+'getstatedetails'); 
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
async function populateCityDropdown(stateId,cityId) {
  const cityDropdown = document.getElementById('cityId');
  cityDropdown.innerHTML = '';

    // Add the default "Select" option
    const defaultOption = document.createElement('option');
    defaultOption.value = ''; 
    defaultOption.textContent = 'Select City';
    cityDropdown.appendChild(defaultOption);
  
  if (stateId > 0)
  {
      const response = await fetch(apiUrl+`getcitiesbystateid/${stateId}`); 
      const cities = await response.json();

      cities.forEach(city => {
          const option = document.createElement('option');
          option.value = city.CityId;
          option.textContent = city.CityName;
          cityDropdown.appendChild(option);
      });
    if (cityId > 0) {
      document.getElementById('cityId').value = cityId;
    }
  }  

}
function onStateChange() {
  const selectedStateId = document.getElementById('stateId').value;
  populateCityDropdown(selectedStateId,0);
}

async function getPropertiesByCustomer(propertyId,ownerId) {
  try {
      const response = await fetch(apiUrl+'getfilteredproperties', {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json'
          },
          body: JSON.stringify({
              stateId: null,
              cityId: null,
              price: null,
              propertyTypeId: null,
              propertyId: propertyId,
              ownerId : ownerId            
          })
      });
      const properties = await response.json();
      return properties;
  } catch (error) {
      console.error('Error fetching properties:', error);
      return [];
  }   
}

async function displayProperties() {
  const propertyId = getPropertyIdFromQueryString();
    if (propertyId) {
        const userId = localStorage.getItem('userId');
      if (!userId) {
        window.location.href = 'Login.html';
        return;
      }    
      const ownerId = userId;
  const appointments = await getPropertiesByCustomer(propertyId, ownerId);


  appointments?.forEach(appointment => {
    document.getElementById('propertyName').value = appointment.PropertyName;
    document.getElementById('description').value = appointment.Description;
    document.getElementById('stateId').value = appointment.StateId;
    populateCityDropdown(appointment.StateId,appointment.CityId);
    document.getElementById('cityId').value = appointment.CityId;
    document.getElementById('price').value = appointment.Price;
    document.getElementById('propertyTypeId').value = appointment.PropertyTypeId;
    document.getElementById('amenities').value = appointment.Amenities;
    const availabilityDate = new Date(appointment.AvailabilityDate).toISOString().split('T')[0];
    document.getElementById('availabilityDate').value = availabilityDate;

    document.getElementById('fullAddress').value = appointment.FullAddress;
    document.getElementById('latitude').value = appointment.Latitude;
    document.getElementById('longitude').value = appointment.Longitude;

  });
    }
}


function submitPropertyDetailsForm(event) {
  event.preventDefault();
  
  const p_propertyName = document.getElementById('propertyName').value;
  const p_description = document.getElementById('description').value;
  const p_stateId = document.getElementById('stateId').value;
  const p_cityId = document.getElementById('cityId').value;
  const p_price = document.getElementById('price').value;
  const p_propertyTypeId = document.getElementById('propertyTypeId').value;
  const p_amenities = document.getElementById('amenities').value;
  const p_availabilityDate = document.getElementById('availabilityDate').value;
  const p_fullAddress = document.getElementById('fullAddress').value;
  // const p_latitude = document.getElementById('latitude').value;
  // const p_longitude = document.getElementById('longitude').value;
     const p_latitude = 0;
   const p_longitude =0;

  const userId = localStorage.getItem('userId');
  if (!userId) {
    window.location.href = 'Login.html';
    return;
  }
  
  if (p_propertyName === "" || p_stateId === "" || p_cityId === "" || p_price === "" || p_propertyTypeId === ""
    || p_availabilityDate === ""|| p_latitude === "" || p_longitude === "") {
    alert('Please fill all the required fields(*)');
    return;
   }

  const p_ownerId = userId;
  let p_propertyId = 0;
  const p_isApprovedByAdmin = 0;
  
  const formData = new FormData();
  const imageFiles = document.getElementById('imageFiles').files;

  for (let i = 0; i < imageFiles.length; i++) {
    formData.append('imageFiles', imageFiles[i]);
  }

  const propertyId = getPropertyIdFromQueryString();
  if (propertyId) {
    p_propertyId = propertyId;    
  }
  else if(imageFiles.length <= 0){
    alert('Please upload at least one image(*)');
    return;
  }

  if (imageFiles.length <= 0 && p_propertyId > 0)
    {
      saveProperty(p_propertyId,
        p_propertyName,
        p_description,
        p_stateId,
        p_cityId,
        p_price,
        p_propertyTypeId,
        p_amenities,
        p_availabilityDate,
        p_ownerId,
        p_fullAddress,
        p_latitude,
        p_longitude,
        p_isApprovedByAdmin,
        null
      );
    }
    else {
      imagesSave(formData).then(imageNames => {
        console.log('Images uploaded:', imageNames);
        saveProperty(p_propertyId,
          p_propertyName,
          p_description,
          p_stateId,
          p_cityId,
          p_price,
          p_propertyTypeId,
          p_amenities,
          p_availabilityDate,
          p_ownerId,
          p_fullAddress,
          p_latitude,
          p_longitude,
          p_isApprovedByAdmin,
          imageNames
        );
      })
      .catch(error => {
        console.error('Error uploading images:', error);
        alert('An error occurred while uploading the images.');
      });
    
    }
 
};
   
    function saveProperty(  p_propertyId,
      p_propertyName,
      p_description,
      p_stateId,
      p_cityId,
      p_price,
      p_propertyTypeId,
      p_amenities,
      p_availabilityDate,
      p_ownerId,
      p_fullAddress,
      p_latitude,
      p_longitude,
      p_isApprovedByAdmin,
      p_imageNames
    ) {
      fetch(apiUrl+'insertOrUpdateProperty', {
        method: 'POST',
        body: JSON.stringify({
          p_propertyId: p_propertyId,
          p_propertyName: p_propertyName,
          p_description: p_description,
          p_stateId: p_stateId,
          p_cityId: p_cityId,
          p_price: p_price,
          p_propertyTypeId: p_propertyTypeId,
          p_amenities: p_amenities,
          p_availabilityDate: p_availabilityDate,
          p_ownerId: p_ownerId,
          p_fullAddress: p_fullAddress,
          p_latitude: p_latitude,
          p_longitude: p_longitude,
          p_isApprovedByAdmin: p_isApprovedByAdmin,
          p_imageNames: p_imageNames
        }),
        headers: {
          'Content-Type': 'application/json'
        }
      })
      .then(response => response.json())
      .then(data => {
          console.log('Response from API:', data);
        alert('Property Added successful!');  
        
        window.location.href = 'PropertyList.html';
      })
      .catch(error => {
          console.log(error);
          alert('An error occurred. Please try again!');
      });
};
    

function imagesSave(formData) {
  return new Promise((resolve, reject) => {
    fetch(apiUrl + 'upload', {
      method: 'POST',
      body: formData
    })
      .then(response => response.json())
      .then(data => {
        console.log(data);
        if (data.success && data.uploadedFiles && data.uploadedFiles.length > 0) {
          const imageNames = data.uploadedFiles.join(';');
        
          resolve(imageNames);
        } else {
          reject(new Error('No images uploaded or an error occurred.'));
          console.log('No images uploaded or an error occurred.');
        }
      })
      .catch(error => {
        console.error(error);
        alert('An error occurred while uploading the images.');
        reject(error);
      });
  });
}


populateStateDropdown();
displayProperties();