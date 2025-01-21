<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Active Doctors</title>
    <style type="text/css">
    body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
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
            background-color: #64B5F6;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #E3F2FD;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        button {
            padding: 8px 12px;
            border: none;
            background-color: #3498db;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #2980b9;
        }</style>
</head>
<body>
    <h1>List of Active Doctors</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>FirstName</th>
            <th>LastName</th>
            <th>Specialization</th>
            <th>Contact</th>
            <th>Email</th>
            <th>Medical License</th>
            <th>Address</th>
        </tr>
        <%
            ResultSet doctorList = (ResultSet) request.getAttribute("doctorList");
            while (doctorList.next()) {
        %>
            <tr>
                <td><%= doctorList.getInt("id") %></td>
                <td><%= doctorList.getString("first_name") %></td>
                <td><%= doctorList.getString("last_name") %></td>
                <td><%= doctorList.getString("specialization") %></td>
                <td><%= doctorList.getString("contact") %></td>
                <td><%= doctorList.getString("email") %></td>
                <td><%= doctorList.getString("medical_license") %></td>
                <td><%= doctorList.getString("address") %></td>
            </tr>
        <% } %>
    </table>
</body>
</html>
