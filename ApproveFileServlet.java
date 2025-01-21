import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ApproveFileServlet")
public class ApproveFileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int fileId = Integer.parseInt(request.getParameter("fileId"));

        try {
            String jdbcURL = "jdbc:mysql://localhost:3306/healthcare";
            String jdbcUsername = "root";
            String jdbcPassword = "nikkii";
            Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

           
            String query = "UPDATE requested_files SET status = 'Approved' WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, fileId);
            ps.executeUpdate();
            ps.close();

            response.getWriter().write("File approved successfully.");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error approving file: " + e.getMessage());
        }
    }
}
