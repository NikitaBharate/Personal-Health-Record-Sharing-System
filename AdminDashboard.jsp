<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.util.*" %>
<%@ page session="true" %>

<%
    String jdbcURL = "jdbc:mysql://localhost:3306/healthcare";
    String jdbcUsername = "root";
    String jdbcPassword = "nikkii";
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    boolean dataFound = false; 

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        stmt = con.createStatement();
        String query = "SELECT rf.id, p.first_name, p.last_name, p.email, rf.file_name, rf.status, rf.doctor_email " +
                       "FROM requested_files rf " +
                       "JOIN patient p ON rf.patient_id = p.id";
        rs = stmt.executeQuery(query);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Requested Files</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #2c3e50;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #4682B4;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        button {
            padding: 8px 12px;
            border: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #2980b9;
        }

        .no-data {
            text-align: center;
            font-style: italic;
            color: #888;
        }

    </style>
</head>
<body>
    <h2>Requested Files</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Patient Name</th>
            <th>File Name</th>
            <th>Status</th>
            <th>Doctor Name</th>
            <th>Action</th>
        </tr>

<%
        while (rs.next()) {
            dataFound = true; 
            int id = rs.getInt("id");
            String patientName = rs.getString("first_name") + " " + rs.getString("last_name");
            String fileName = rs.getString("file_name");
            String status = rs.getString("status");
            String doctorEmail = rs.getString("doctor_email");

            Statement stmtDoctor = con.createStatement();
            String doctorQuery = "SELECT first_name, last_name FROM doctor WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(doctorQuery);
            ps.setString(1, doctorEmail);
            ResultSet doctorRs = ps.executeQuery();

            String doctorName = "Unknown";
            if (doctorRs.next()) {
                doctorName = doctorRs.getString("first_name") + " " + doctorRs.getString("last_name");
            }
            doctorRs.close();
%>
    <tr>
        <td><%= id %></td>
        <td><%= patientName %></td>
        <td><%= fileName %></td>
        <td><%= status %></td>
        <td><%= doctorName %></td>
        <td>
            <%
                if ("Pending".equals(status)) {
            %>
                <form action="ApproveFileServlet" method="post">
                    <input type="hidden" name="fileId" value="<%= id %>">
                    <button type="submit">Approve</button>
                </form>
            <%
                } else {
            %>
                Approved
            <%
                }
            %>
        </td>
    </tr>
<%
        }
        
        if (!dataFound) {
%>
    <tr class="no-data">
        <td colspan="6">No requested files found.</td>
    </tr>
<%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage()); 
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</table>
</body>
</html>
