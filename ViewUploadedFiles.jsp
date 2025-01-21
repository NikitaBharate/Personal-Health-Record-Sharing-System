<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Uploaded Files</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f9f9f9;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #3c729e;
            color: white;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .back-btn {
            display: inline-block;
            margin: 20px auto;
            text-align: center;
            text-decoration: none;
            color: white;
            background-color: #3c729e;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
        }

        .back-btn:hover {
            background-color: #28527a;
        }
    </style>
</head>
<body>
    <h2>Your Uploaded Files</h2>

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

            String query = "SELECT * FROM files WHERE patient_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, patientId);
            rs = ps.executeQuery();

            if (rs.isBeforeFirst()) { 
    %>
                <table border="1">
                    <tr>
                        <th>File Name</th>
                        <th>Description</th>
                        <th>Upload Date</th>
                        <th>View File</th>
                        <th>Download File</th>
                    </tr>
                <% while (rs.next()) { %>
                    <tr>
                        <td><%= rs.getString("file_name") %></td>
                        <td><%= rs.getString("file_description") %></td>
                        <td><%= rs.getTimestamp("upload_date") %></td>
                        <td><a href="<%= rs.getString("file_path") %>" target="_blank">View</a></td>
                        <td><a href="<%= rs.getString("file_path") %>" download>Download</a></td>
                    </tr>
                <% } %>
                </table>
    <%
            } else {
                out.println("<p style='text-align: center;'>No files uploaded yet.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='text-align: center; color: red;'>An error occurred while fetching the files.</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        response.sendRedirect("PatientLogin.jsp");
    }
    %>

    <div style="text-align: center;">
        <a href="PatientDashboard.jsp" class="back-btn">Back to Dashboard</a>
    </div>
</body>
</html>
