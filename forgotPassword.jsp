<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <style type="text/css" href="DoctorReg.css"></style>
        
</head>
<body>
    <h2>Forgot Password</h2>
    <form action="SendOtpServlet" method="POST">
        <label for="email">Enter your registered email:</label><br>
        <input type="email" id="email" name="email" required><br><br>
        <input type="submit" value="Send OTP">
    </form>
</body>
</html>
