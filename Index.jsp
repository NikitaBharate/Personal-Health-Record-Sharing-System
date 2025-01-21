<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
  
    <style>
        
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-image: url('https://media.licdn.com/dms/image/D5612AQH2heo6D80YCg/article-cover_image-shrink_600_2000/0/1706788460035?e=2147483647&v=beta&t=sCqZsJRngWEah74etlROl91TQ6Uq7zXh-5Im3kNmKMk');
            
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: #333;
        }
        
        
        .admin-container {
            text-align: center;
            background-color: rgba(255, 255, 255, 0.8); /* Add semi-transparent white background */
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* Softer shadow */
            width: 90%;
            max-width: 450px;
        }

      
        .admin-container h2 {
            margin-bottom: 20px;
            color: #007bff;
            font-size: 2rem;
            font-weight: bold;
        }

       
        .login-links {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        
        .login-links a {
            text-decoration: none;
            color: #fff;
            background-color: #007bff;
            padding: 12px;
            border-radius: 8px;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        
        .login-links a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <h2>Admin Dashboard</h2>
        <div class="login-links">
            <a href="DoctorLogin.jsp">Doctor Login</a>
            <a href="PatientLogin.jsp">Patient Login</a>
            <a href="AdminLogin.jsp">Admin Login</a>
            <a href="SuperintendentLogin.jsp">Superintendent Login</a>
            <a href="KGCLogin.jsp">KGC Login</a>
        </div>
    </div>
</body>
</html>
