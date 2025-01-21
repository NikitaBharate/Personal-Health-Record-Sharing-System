<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            width: 100%;
            background: #3c729e;
            color: white;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar h1 {
            font-size: 2em;
            margin: 0;
            font-weight: 700;
            letter-spacing: 1px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
        }

        .navbar-icon {
            margin-right: 10px;
            font-size: 1.5em;
        }

        .dashboard-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            background-image: url('https://images.pexels.com/photos/40568/medical-appointment-doctor-healthcare-40568.jpeg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .card-wrapper {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            background-color: rgb(173,216,230);
            padding: 20px;
            border-radius: 15px;
        }

        .dashboard-card {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 250px;
            padding: 20px;
            transition: transform 0.2s ease-in-out;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
        }

        .dashboard-card h2 {
            font-size: 1.4em;
            color: #333;
        }

        .dashboard-card a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
            display: inline-block;
            margin-top: 10px;
        }

        .dashboard-card a:hover {
            text-decoration: underline;
        }

        /* Footer Styling */
        .footer {
            text-align: center;
            color: white;
            font-size: 0.9em;
            padding: 15px 0;
            background-color: #3c729e;
            box-shadow: 0px -2px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="navbar">
        <span class="navbar-icon">‍</span> 
        <h1>
            <% 
                if (session != null && session.getAttribute("patient_id") != null) {
                    int patientId = (int) session.getAttribute("patient_id");
                    String jdbcURL = "jdbc:mysql://localhost:3306/healthcare";
                    String jdbcUsername = "root";
                    String jdbcPassword = "nikkii";
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                        String query = "SELECT first_name, last_name FROM patient WHERE id = ?";
                        ps = con.prepareStatement(query);
                        ps.setInt(1, patientId);
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            String firstName = rs.getString("first_name");
                            String lastName = rs.getString("last_name");
                            out.print("Hello, " + firstName + " " + lastName + "!");
                        } else {
                            out.print("Hello, Patient!");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.print("Hello, Patient!");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (ps != null) ps.close();
                            if (con != null) con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    response.sendRedirect("PatientLogin.jsp");
                }
            %>
        </h1>
    </div>
    
    <div class="dashboard-container">
        <div class="card-wrapper">
            <div class="dashboard-card">
                <h2>Upload File</h2>
                <a href="UploadFile.jsp">Upload New File</a>
            </div>

            <div class="dashboard-card">
                <h2>Uploaded Files</h2>
                <a href="ViewUploadedFiles.jsp">View Uploaded Files</a>
            </div>
        </div>
    </div>
    
    <div class="footer">
        <p>&copy; 2024 Health Record System. All rights reserved.</p>
    </div>
    
</body>
</html>
