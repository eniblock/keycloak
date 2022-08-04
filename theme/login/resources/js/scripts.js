// Change the type of input to password or text
function show(pwd_id) {
    const password = document.getElementById(pwd_id);
    if (password.type === "password") {
        password.type = "text";
    } else {
        password.type = "password";
    }
}

function goToRegistration() {
    window.location.replace('/register');
}
