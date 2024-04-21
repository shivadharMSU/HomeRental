// Function to get the property ID from the query string
function getPropertyIdFromQueryString() {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get('propertyId');
}

// Function to fetch property details by ID
async function fetchPropertyDetails(propertyId) {
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
            ownerId : null
        })
    });
    const properties = await response.json();
    properties?.forEach((property) => {
        document.getElementById('propertyName').textContent = property.PropertyName;
        document.getElementById('description').textContent = property.Description;
        document.getElementById('propertyTypeName').textContent = property.PropertyTypeName;
        document.getElementById('fullAddress').textContent = property.FullAddress;
        document.getElementById('price').textContent = property.Price;
        document.getElementById('amenities').textContent = property.Amenities;
        document.getElementById('date').textContent = new Date(property.AvailabilityDate).toLocaleDateString('en-US');
      
        const propertyHtml = `${property.ImagePaths.split(';').map((imagePath, index) => `
                             <div class="carousel-item ${index === 0 ? 'active' : ''}">
                                 <img src="JavaScript/uploads/${imagePath}" class="d-block w-100" style="max-height: 300px;" alt="Property Image">
                             </div>
                          `).join('')};` 

       const propertyDetailsContainer = document.getElementById('imageCorosole');
       propertyDetailsContainer.innerHTML = ''; // Clear previous content
       propertyDetailsContainer.innerHTML = propertyHtml;
       });


    
}

// Function to display property details on the page
async function displayPropertyDetails() {
    const propertyId = getPropertyIdFromQueryString();
    if (propertyId) {
        // Fetch property details
          await fetchPropertyDetails(propertyId);        
    }
}

async function bookAppointment() {
    const propertyId = getPropertyIdFromQueryString();
    if (propertyId) {
        const userId = localStorage.getItem('userId');
        if (!userId) {
            alert('Please login to book appointment');
            window.location.href = 'Login.html';
            return;
        }
        else {
            let customerId = userId;
            await SaveAppointment(propertyId,customerId);      
        }              
    }
}

async function SaveAppointment(propertyId,customerId) {
     
    try {
      const response = await fetch(apiUrl+'bookAppointment', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({            
            PropertyId: propertyId,
            CustomerId: customerId
        })
      });
  
      const result = await response.json();
        console.log(result);
        if (result.error) {
            alert(result.error);
        }
        else {
            const noDataModal = new bootstrap.Modal(document.getElementById('bookAppointmentSuccess'));
            noDataModal.show();
            // alert('Your appointment has been booked successfully!');
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Your appointment has not been booked. Please try again!')
    }
}
  
  var ratingModal = new bootstrap.Modal(document.getElementById('ratingModal'));

  function addRatings() {
    // Open the rating modal
    ratingModal.show();
  }
function submitRating() {
    var rating = document.getElementById('rating').value;
    var review = document.getElementById('review').value;
   
    const propertyId = getPropertyIdFromQueryString();
    const customerId = localStorage.getItem('userId');
   
    const data = {
        rating: rating,
        review: review,
        propertyId: propertyId,
        customerId: customerId
    };
    if (rating === '') {
        alert('Please fill in the required fields(*)');
        return;
    }
    else if(parseFloat(rating) > 5) {
        alert('Rating should not be greater then 5.');
        return;
    }
    if (!customerId) {
        alert('Please login to add rating');
        window.location.href = 'Login.html'; 
        return;
     }
      saveRatingReview(data);
  }


  async function saveRatingReview(data) {
     
    try {
      const response = await fetch(apiUrl+'addPropertyRating', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
      });
  
      const result = await response.json();
        console.log(result);
        if (result.error) {
            alert(result.error);
        }
        else {
            alert('Your rating has been saved successfully!');
            ratingModal.hide();
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Your rating has not been saved. Please try again!')
    }
}
async function getPropertyRatings() {
    const propertyId = getPropertyIdFromQueryString();
    try {
        const response = await fetch(apiUrl+`GetPropertyRatings/${propertyId}`);
        const data = await response.json();

        const ratingsContainer = document.getElementById('ratings');
        let totalRating = 0;
        if (data?.length > 0) {
            data?.forEach(rating => {
                const ratingDiv = document.createElement('div');
                ratingDiv.innerHTML = `
                    <p><strong>Rating:</strong> ${rating.Rating}</p>
                    <p><strong>Review:</strong> ${rating.Review}</p>
                    <hr>
                `;
                ratingsContainer.appendChild(ratingDiv);
                totalRating += parseFloat(rating.Rating);
            });
            const averageRating = totalRating / data.length;
            const averageValue = document.getElementById('averageValue');
            averageValue.textContent = averageRating.toFixed(1);
        } else {
            ratingsContainer.innerHTML = '<p>No ratings found for this property.</p>';
            const averageValue = document.getElementById('averageValue');
            averageValue.textContent = totalRating.toFixed(1);
        }
    } catch (error) {
        console.error('Error fetching ratings:', error);
        return [];
    }
}

function saveProperty() {   
    const propertyId = getPropertyIdFromQueryString();
    const customerId = localStorage.getItem('userId');
   
    const data = {       
        propertyId: propertyId,
        customerId: customerId
    };   
    
    if (!customerId) {
        alert('Please login to save property.');
        window.location.href = 'Login.html'; 
        return;
     }
      saveProperties(data);
  }

  async function saveProperties(data) {
     
    try {
      const response = await fetch(apiUrl+'savedProperties', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
      });
  
      const result = await response.json();
        console.log(result);
        if (result.error) {
            alert(result.error);
        }
        else {
            alert('Property has been saved successfully!');
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Property has not been saved. Please try again!')
    }
}
displayPropertyDetails();

getPropertyRatings();