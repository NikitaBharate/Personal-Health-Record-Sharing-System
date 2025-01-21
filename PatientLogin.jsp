<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Login</title>
    <link rel="stylesheet" href="DoctorReg.css">
    <style>
        body {
            background-image: url('https://www.shutterstock.com/shutterstock/videos/1064816821/thumb/10.jpg?ip=x480');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center; 
            align-items: center;
         
            .form-container {
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px; 
            
            .options {
            text-align: center;
            margin-top: 15px;
        }

        .options a {
            color: #007bff;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .options a:hover {
            text-decoration: underline;
        }

        .signup-option {
            margin-top: 10px;
            font-size: 0.9rem;
        }
        }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2>Patient Login</h2>
            <form action="PatientLoginServlet" method="POST">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>

                <input type="submit" value="Login">
                <div class="options">
            <a href="forgotPassword.jsp">Forgot Password?</a>
            <div class="signup-option">
                Don't have an account? <a href="PatientReg.jsp">Sign Up</a>
            </div>
            </form>
        </div>
    </div>
</body>
</html>
