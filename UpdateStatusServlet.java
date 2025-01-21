import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/healthcare";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "nikkii";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = request.getParameter("role");
        String id = request.getParameter("id");
        String currentStatus = request.getParameter("currentStatus");

        if (role == null || id == null || currentStatus == null) {
            response.getWriter().write("Invalid input parameters.");
            return;
        }

        String newStatus = currentStatus.equals("Active") ? "Inactive" : "Active";
        String updateQuery;

        if (role.equals("doctor")) {
            updateQuery = "UPDATE doctor SET status = ? WHERE id = ?";
        } else if (role.equals("superintendent")) {
            updateQuery = "UPDATE superintendent SET status = ? WHERE id = ?";
        } else {
            response.getWriter().write("Invalid role.");
            return;
        }

        try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement ps = con.prepareStatement(updateQuery)) {

            ps.setString(1, newStatus);
            ps.setInt(2, Integer.parseInt(id));
            int updatedRows = ps.executeUpdate();

            if (updatedRows > 0) {
                response.sendRedirect("KGCDashboard.jsp");
            } else {
                response.getWriter().write("Failed to update status.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
