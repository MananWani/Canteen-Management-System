	function validateRegistration() {
		var name = document.getElementById('name').value.trim();
		var email = document.getElementById('email').value.trim();
		var password = document.getElementById('password').value;
		var confirmPassword = document.getElementById('confirmPassword').value;

		var nameError = document.getElementById('nameError');
		var emailError = document.getElementById('emailError');
		var passwordError = document.getElementById('passwordError');
		var confirmPasswordError = document
				.getElementById('confirmPasswordError');

		var valid = true;

		nameError.textContent = '';
		emailError.textContent = '';
		passwordError.textContent = '';
		confirmPasswordError.textContent = '';

		var nameRegex = /^[a-zA-Z]+$/;
		var emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
		var passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%?&])[A-Za-z\d@$!%*?&]{8,}$/;

		// Validate name
		if (name === '') {
			nameError.textContent = 'Name cannot be empty.';
			valid = false;
		} else if (!nameRegex.test(name)) {
			nameError.textContent = 'Name can only contain letters.';
			valid = false;
		}

		// Validate email
		if (email === '') {
			emailError.textContent = 'Email cannot be empty.';
			valid = false;
		} else if (!emailRegex.test(email)) {
			emailError.textContent = 'Email must be a valid Gmail address.';
			valid = false;
		}

		// Validate password
		if (password === '') {
			passwordError.textContent = 'Password cannot be empty.';
			valid = false;
		} else if (!passwordRegex.test(password)) {
			passwordError.textContent = 'Password must be at least 8 characters long and contain at least one uppercase letter, one digit, and one special character.';
			valid = false;
		}

		// Validate confirm password
		if (confirmPassword === '') {
			confirmPasswordError.textContent = 'Confirm Password cannot be empty.';
			valid = false;
		} else if (password !== confirmPassword) {
			confirmPasswordError.textContent = 'Passwords do not match.';
			valid = false;
		}

		return valid;
	}
