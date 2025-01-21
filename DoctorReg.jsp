<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctors Registration</title>
    <link rel="stylesheet" href="DoctorReg.css">
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

        function showSuccessPopup() {
            alert("Registration is successful. An email has been sent.");
            setTimeout(function() {
                window.location.href = "DoctorLogin.jsp";
            }, 1000); 
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="form-container" id="registrationForm">
            <h2>Doctor Registration</h2>
            <form action="DoctorRegistrationServlet" method="POST" enctype="multipart/form-data" onsubmit="return validatePasswords();">
                <h3>Personal Information</h3>
                <label for="firstName">First Name</label>
                <input type="text" id="firstName" name="firstName" required>

                <label for="lastName">Last Name</label>
                <input type="text" id="lastName" name="lastName" required>

                <label for="dob">Date of Birth</label>
                <input type="date" id="dob" name="dob" required>

                <label for="gender">Gender</label>
                <select id="gender" name="gender" required>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                </select>

                <label for="contact">Contact Number</label>
                <input type="text" id="contact" name="contact" required pattern="[0-9]{10}" title="Please enter a valid 10-digit contact number.">

                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required>

                <label for="address">Residential Address</label>
                <input type="text" id="address" name="address" required>

                <h3>Professional Information</h3>
                <label for="Medicallicense">Medical License Number</label>
                <input type="text" id="Medicallicense" name="Medicallicense" required>

                <label for="Specialization">Specialization</label>
                <select id="Specialization" name="Specialization" required>
                    <option value="">Select Specialization</option>
                    <option value="Cardiology">Cardiology</option>
                    <option value="Dermatology">Dermatology</option>
                    <option value="Endocrinology">Endocrinology</option>
                    <option value="Gastroenterology">Gastroenterology</option>
                    <option value="Neurology">Neurology</option>
                    <option value="Oncology">Oncology</option>
                    <option value="Orthopedics">Orthopedics</option>
                    <option value="Pediatrics">Pediatrics</option>
                    <option value="Psychiatry">Psychiatry</option>
                    <option value="Pulmonology">Pulmonology</option>
                    <option value="Rheumatology">Rheumatology</option>
                    <option value="Surgery">Surgery</option>
                    <option value="Urology">Urology</option>
                </select>

                <label for="Experience">Years of Experience</label>
                <input type="number" id="Experience" name="Experience" required>

                <label for="fees">Consultation Fees</label>
                <input type="number" step="0.01" id="fees" name="fees" required>

                <h3>Login Credentials</h3>
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>

                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>

                <h3>Verification Documents</h3>
                <label for="licenseUpload">Medical License Upload</label>
                <input type="file" id="licenseUpload" name="licenseUpload" >

                <div class="checkbox-group">
                    <input type="checkbox" id="terms" name="terms" required>
                    <label for="terms">I agree to the <a href="#">Terms and Conditions</a></label>
                </div>

                <input type="submit" value="Register">
            </form>
        </div>
    </div>

    <% 
        String registrationStatus = (String) request.getAttribute("registrationStatus");
        if ("success".equals(registrationStatus)) { 
    %>
        <script>showSuccessPopup();</script>
    <% } %>
</body>
</html>
