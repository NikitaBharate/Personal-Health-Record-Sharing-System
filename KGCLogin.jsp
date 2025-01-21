<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>KGC Login</title>
    <link rel="stylesheet" href="style.css"> 
 <script>
        function showAlert(message) {
            alert(message); 
        }
    </script>
    
</head>
<body>
<div class="container">
        <div class="form-container">
            <h2>KGC Login</h2>
            <form action="KGCLoginServlet" method="POST">
                <label for="username">username</label>
                <input type="username" id="username" name="username" required><br><br>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" required><br><br>

                <input type="submit" value="Login">
                
                
                    
            </form>
        </div>
    </div>

    
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
        <p style="color: red;"><%= errorMessage %></p>
    <%
        }
    %>
</body>
</html>
