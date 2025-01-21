<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Medical File</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            background-image: url('https://www.shutterstock.com/shutterstock/videos/1064816821/thumb/10.jpg?ip=x480');
            
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        .form-container {
            background-color: #fff;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 400px;
            max-width: 100%;
        }

        h2 {
        
            text-align: center;
            margin-bottom: 20px;
            color: #4682B4;
            font-size: 24px;
        }

        label {
            font-size: 14px;
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        input[type="file"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            height: 100px;
        }

        input[type="submit"] {
            background-color: #4682B4;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color:#4682B4;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #4682B4;
            text-decoration: none;
            font-size: 14px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Upload Medical File</h2>
        <form action="UploadFileServlet" method="post" enctype="multipart/form-data">
            <label for="file">Select file to upload:</label>
            <input type="file" name="file" required>

            <label for="file_description">File Description:</label>
            <textarea name="file_description" required></textarea>

            <input type="submit" value="Upload">
        </form>
        <a href="PatientDashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
