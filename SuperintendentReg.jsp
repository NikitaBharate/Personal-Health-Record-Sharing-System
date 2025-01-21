<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Superintendent Registration</title>
        <link rel="stylesheet" href="DoctorReg.css">
      <style>
        body {
            background-image: url('https://www.hahchospital.com/wp-content/themes/hahc/images/mob-internal-banner.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-color: rgba(255, 255, 255, 0.8);
            
             
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2>Superintendent Registration</h2>
            <form action="SuperintendentRegistrationServlet" method="POST">
                <label for="firstName">First Name</label>
                <input type="text" id="firstName" name="firstName" required>

                <label for="lastName">Last Name</label>
                <input type="text" id="lastName" name="lastName" required>

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

                <label for="department">Department</label>
                <input type="text" id="department" name="department" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>

                <input type="submit" value="Register">
            </form>
        </div>
    </div>
</body>
</html>
