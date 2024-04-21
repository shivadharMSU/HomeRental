document.addEventListener('DOMContentLoaded', function () {
    
    const registrationForm = document.getElementById('registration-form');
  
    registrationForm.addEventListener('submit', function(event) {
      event.preventDefault();
  
      const username = registrationForm.username.value;
      const firstName = registrationForm.firstName.value;
      const lastName = registrationForm.lastName.value;
      const middleName = registrationForm.middleName.value;
      const password = registrationForm.password.value;
      const confirmPassword = registrationForm.confirmPassword.value;
      const userType = registrationForm.userType.value;
      const mobileNumber = registrationForm.mobileNumber.value;
     
      if (username === "" || firstName === "" || lastName === "" || password === ""
        || userType === "" || mobileNumber === "") {
        alert('Please fill all the required fields(*)');
        return;
      }
      if (password !== confirmPassword) {
        alert("Passwords do not match");
        return;
      } else {
     
        const isValid =saveUser(username, firstName, lastName, middleName, password, userType, mobileNumber);
        
      }
    });


    function saveUser(username, firstName, lastName, middleName, password, userType, mobileNumber) {
        fetch(apiUrl+'saveuser', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            UserName: username,
            FirstName: firstName,
            LastName: lastName,
            MiddleName: middleName,
            Password: password,
            UserTypeId: userType,
            MobileNumber: mobileNumber
          })
        })
        .then(response => response.json())
          .then(data => {
          if (data.error) {
            alert(data.error);
            return;
          } else{
            // alert('Registration successful!');
            const noDataModal = new bootstrap.Modal(document.getElementById('registrationSuccessfull'));
        noDataModal.show();
            //window.location.href = 'Login.html';
            return;
          }         
        })
        .catch(error => {
          alert('An error occurred. Please try again!');
            console.error(error);
            return false;
        });
      }     
  });
  