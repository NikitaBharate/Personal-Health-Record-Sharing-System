import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SuperintendentLoginServlet")
public class SuperintendentLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String privateKey = request.getParameter("privateKey");

        String jdbcURL = "jdbc:mysql://localhost:3306/healthcare";
        String jdbcUsername = "root";
        String jdbcPassword = "nikkii";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String query = "SELECT * FROM superintendent WHERE email = ? AND password = ? AND private_key = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, privateKey);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");
                if ("active".equalsIgnoreCase(status)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("superintendentId", rs.getInt("id"));
                    session.setAttribute("superintendentName", rs.getString("first_name"));

                    response.sendRedirect("SuperintendentDashboard.jsp");
                } else {
                    request.setAttribute("loginStatus", "inactive");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("SuperintendentLogin.jsp");
                    dispatcher.forward(request, response);
                }
            } else {
                request.setAttribute("loginStatus", "invalid");
                RequestDispatcher dispatcher = request.getRequestDispatcher("SuperintendentLogin.jsp");
                dispatcher.forward(request, response);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
