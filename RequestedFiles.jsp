<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Requested Files</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            margin-top: 20px;
            color: #333;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
            text-align: left;
        }

        th, td {
            padding: 10px;
        }

        th {
            background-color: #4682B4;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        a {
            color: #4CAF50;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Requested Files</h2>
    <table>
        <tr>
            <th>Patient Name</th>
            <th>Patient Email</th>
            <th>File Name</th>
            <th>Status</th>
            <th>Action</th>
            <th>View File</th>
        </tr>
        <%
            String jdbcURL = "jdbc:mysql://localhost:3306/healthcare";
            String jdbcUsername = "root";
            String jdbcPassword = "nikkii";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                HttpSession httpSession = request.getSession();  
                String doctorEmail = (String) httpSession.getAttribute("doctorEmail");

                if (doctorEmail == null) {
                    response.sendRedirect("DoctorLogin.jsp");
                    return;
                }

                String query = "SELECT p.first_name, p.email,r.doctor_email,  r.file_name, r.status, f.file_path " +
                        "FROM requested_files r " +
                        "JOIN patient p ON r.patient_id = p.id " +
                        "JOIN files f ON  r.file_name = f.file_name " +
                        "WHERE r.doctor_email = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, doctorEmail);
                ResultSet rs = ps.executeQuery();
                
                if (!rs.isBeforeFirst()) { 
                    %>
                    <tr>
                        <td colspan="5" style="text-align:center;">No requested files found.</td>
                    </tr>
                    <%
                            }

                while (rs.next()) {
                    String patientName = rs.getString("first_name");
                    String patientEmail = rs.getString("email");
                    String fileName = rs.getString("file_name");
                    String status = rs.getString("status");
                    String filePath = rs.getString("file_path"); 
        %>
        <tr>
            <td><%= patientName %></td>
            <td><%= patientEmail %></td>
            <td><%= fileName %></td>
            <td><%= status %></td>
            <td>
                <% if ("Approved".equals(status)) { %>
                        <a href="<%= rs.getString("file_path") %>" download>Download</a>
                <% } else { %>
                    <span>Pending Approval</span>
                <% } %>
            </td>
            <td>
                <% if ("Approved".equals(status)) { %>
                        <a href="<%= rs.getString("file_path") %>" view>View</a>
                <% } else { %>
                    <span>Pending Approval</span>
                <% } %>
            </td>
        </tr>
        <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
        %>
        <tr>
            <td colspan="5" class="error-message">Error loading requested files.</td>
        </tr>
        <%
            }
        %>
    </table>
    <div class="back-link">
        <a href="DoctorDashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html> 