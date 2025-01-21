import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewPatientsServlet")
public class ViewPatientsServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/healthcare", "root", "nikkii");

            String query = "SELECT * FROM patient";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            request.setAttribute("patientList", rs);
            request.getRequestDispatcher("PatientList.jsp").forward(request, response);

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
