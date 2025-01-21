<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Superintendent Login</title>
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
            <h2>Superintendent Login</h2>
            <form action="SuperintendentLoginServlet" method="POST">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required><br><br>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" required><br><br>

                <label for="privateKey">Private Key</label>
                <input type="text" id="privateKey" name="privateKey" required><br><br>

                <input type="submit" value="Login">

                <div class="options">
                    <a href="forgotPassword.jsp">Forgot Password?</a>
                    <div class="signup-option">
                        Don't have an account? <a href="SuperintendentReg.jsp">Sign Up</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <% 
        String loginStatus = (String) request.getAttribute("loginStatus");
        if (loginStatus != null) {
    %>
       <%
    String alertMessage = null;
    if ("inactive".equals(loginStatus)) {
        alertMessage = "Your status is inactive. Contact admin.";
    } else if ("invalid".equals(loginStatus)) {
        alertMessage = "Invalid credentials. Try again.";
    }
%>
<script>
    <% if (alertMessage != null) { %>
        showAlert("<%= alertMessage %>");
    <% } %>
</script>


    <% } %>
</body>
</html>
