import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DoctorLoginServlet")
public class DoctorLoginServlet extends HttpServlet {
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

            String query = "SELECT * FROM doctor WHERE email = ? AND password = ? AND private_key = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, privateKey);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");

                if ("active".equalsIgnoreCase(status)) {

                	String doctorName = rs.getString("first_name");
                	int doctorId = rs.getInt("id"); 
                    HttpSession session = request.getSession();
                    session.setAttribute("doctorName", doctorName);
                    session.setAttribute("doctorId", doctorId); 
                    session.setAttribute("doctorEmail", email);

                    request.setAttribute("loginStatus", "success");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("DoctorDashboard.jsp");
                    dispatcher.forward(request, response);
                } else {
                    request.setAttribute("loginStatus", "inactive");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("DoctorLogin.jsp");
                    dispatcher.forward(request, response);
                }
            } else {
               
                request.setAttribute("loginStatus", "invalid");
                RequestDispatcher dispatcher = request.getRequestDispatcher("DoctorLogin.jsp");
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
