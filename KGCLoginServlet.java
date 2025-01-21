import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/KGCLoginServlet")
public class KGCLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
      

        String jdbcURL = "jdbc:mysql://localhost:3306/healthcare"; 
        String jdbcUsername = "root"; 
        String jdbcPassword = "nikkii";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

           
            String query = "SELECT * FROM kgc WHERE username = ? AND password = ? ";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                
                HttpSession session = request.getSession();
                session.setAttribute("kgcUser", username);
                response.sendRedirect("KGCDashboard.jsp");

                
            } else {
            	 request.setAttribute("errorMessage", "Invalid username or password!");
                 request.getRequestDispatcher("KGCLogin.jsp").forward(request, response);
            }
            
           
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
