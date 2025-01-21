<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Registration</title>
    <link rel="stylesheet" href="DoctorReg.css">
    <style>
        body {
            background-image: url('https://www.shutterstock.com/shutterstock/videos/1064816821/thumb/10.jpg?ip=x480');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: rgba(255, 255, 255, 0.8);
        }
        .form-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            width: 300px;
            text-align: center;
        }
    </style>
    <script>
        function validatePasswords() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2>Patient Registration</h2>
            <form action="PatientRegServlet" method="POST" onsubmit="return validatePasswords();">
                <label for="firstName">First Name</label>
                <input type="text" id="firstName" name="firstName" required>

                <label for="lastName">Last Name</label>
                <input type="text" id="lastName" name="lastName" required>

                <label for="dob">Date of Birth</label>
                <input type="date" id="dob" name="dob" required>

                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required>

                <label for="gender">Gender</label>
                <select id="gender" name="gender" required>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                </select>

                <label for="contact">Contact Number</label>
                <input type="tel" id="contact" name="contact" required>

                <label for="address">Address</label>
                <input type="text" id="address" name="address" required>

                <label for="medications">Medications</label>
                <select id="medications" name="medications" required>
                    <option value="">-- Select Medication --</option>
                    <option value="Cardiology">Cardiology - Heart medications</option>
                    <option value="Dermatology">Dermatology - Skin treatments</option>
                    <option value="Orthopedics">Orthopedics - Bone treatments</option>
                    <option value="Pediatrics">Pediatrics - Children's medicines</option>
                    <!-- Add more options based on the specialization of doctors -->
                </select>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>

                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                

                <input type="submit" value="Register">
            </form>
        </div>
    </div>
</body>
</html>
