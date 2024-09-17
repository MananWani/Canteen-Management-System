function validateLogin() {
        var username = document.getElementById('username').value.trim();
        var password = document.getElementById('password').value.trim();
        var usernameError = document.getElementById('usernameError');
        var passwordError = document.getElementById('passwordError');
        var valid = true;

        usernameError.textContent = '';
        passwordError.textContent = '';

        if (username === '') {
        	usernameError.textContent = 'Email cannot be empty.';
            valid = false;
        }

        if (password === '') {
            passwordError.textContent = 'Password cannot be empty.';
            valid = false;
        }

        return valid;
    }