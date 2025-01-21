<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/healthcare";
    String jdbcUsername = "root";
    String jdbcPassword = "nikkii"; 
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

       
        String doctorQuery = "SELECT id, first_name, last_name, status FROM doctor";
        ps = con.prepareStatement(doctorQuery);
        ResultSet doctorResult = ps.executeQuery();

        String superintendentQuery = "SELECT id, first_name, last_name, status FROM superintendent";
        PreparedStatement ps2 = con.prepareStatement(superintendentQuery);
        ResultSet superintendentResult = ps2.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>KGC Dashboard</title>
    <style>
        @charset "UTF-8";
        body {
            background-image: url('https://www.hahchospital.com/wp-content/themes/hahc/images/mob-internal-banner.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .dashboard-container {
            display: flex;
            justify-content: space-around;
            padding: 20px;
            
            
        }
        .table-container {
           background-color:  rgb(150,195,236);
            border-radius: 10px;
            padding: 20px;
            width: 45%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        table {
        
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            text-align: left;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #2C4B7E;
            color:white;
        }
        button {
            padding: 5px 10px;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: green;
        }
        
        
    </style>
</head>
<body>
    <div class="form-container">
        <h2>KGC Dashboard</h2>
        <p>Welcome, KGC</p>
        
        
        <div class="dashboard-container">
    <!-- Doctors Table -->
    <div class="table-container">
        <h3>Doctors</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <% while (doctorResult.next()) { %>
            <tr>
                <td><%= doctorResult.getInt("id") %></td>
                <td><%= doctorResult.getString("first_name") + " " + doctorResult.getString("last_name") %></td>
                <td><%= doctorResult.getString("status") %></td>
                <td>
                    <form action="UpdateStatusServlet" method="post">
                        <input type="hidden" name="role" value="doctor">
                        <input type="hidden" name="id" value="<%= doctorResult.getInt("id") %>">
                        <input type="hidden" name="currentStatus" value="<%= doctorResult.getString("status") %>">
                        <button type="submit"  style="background-color: <%= doctorResult.getString("status").equals("Active") ? "red" : "green" %>;">
                            <%= doctorResult.getString("status").equals("Active") ? "Deactivate" : "Activate" %>
                        </button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    
    <div class="table-container">
        <h3>Superintendents</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <% while (superintendentResult.next()) { %>
            <tr>
                <td><%= superintendentResult.getInt("id") %></td>
                <td><%= superintendentResult.getString("first_name") + " " + superintendentResult.getString("last_name") %></td>
                <td><%= superintendentResult.getString("status") %></td>
                <td>
                    <form action="UpdateStatusServlet" method="post">
                        <input type="hidden" name="role" value="superintendent">
                        <input type="hidden" name="id" value="<%= superintendentResult.getInt("id") %>">
                        <input type="hidden" name="currentStatus" value="<%= superintendentResult.getString("status") %>">
                        <button type="submit"  style="background-color: <%= superintendentResult.getString("status").equals("Active") ? "red" : "green" %>;">
                            <%= superintendentResult.getString("status").equals("Active") ? "Deactivate" : "Activate" %>
                        </button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</div>

    </div>
</body>
</html>
<%
    } catch (Exception e) {
        out.println("<p>Error retrieving data: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
