<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient List</title>
    <style>
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
        }
    </style>
    
</head>
<body>
    <h2>Patient List</h2>
    <table>
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Medication</th>
            <th>contact</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmtPatient = null;
            PreparedStatement stmtFile = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/healthcare", "root", "nikkii");
                stmtPatient = conn.createStatement();

                String query = "SELECT * FROM patient";
                ResultSet rs = stmtPatient.executeQuery(query);

                while (rs.next()) {
                    int patientId = rs.getInt("id");
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    String email = rs.getString("email");
                    String medication = rs.getString("medications");
                    String contact = rs.getString("contact");
        %>
        <tr>
            <td><%= firstName %></td>
            <td><%= lastName %></td>
            <td><%= email %></td>
            <td><%= medication %></td>
            <td><%=contact%></td>
        </tr>
        <%
                }
                rs.close();
                stmtPatient.close();
                
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
