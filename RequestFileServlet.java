import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RequestFileServlet")
public class RequestFileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String patientEmail = request.getParameter("email");
        String fileName = request.getParameter("file");

        HttpSession session = request.getSession();
        String doctorEmail = (String) session.getAttribute("doctorEmail");

        if (doctorEmail == null) {
            response.sendRedirect("DoctorLogin.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            String jdbcURL = "jdbc:mysql://localhost:3306/healthcare";
            String jdbcUsername = "root";
            String jdbcPassword = "nikkii";
            con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // Get patient ID
            String getPatientQuery = "SELECT id FROM patient WHERE email = ?";
            ps = con.prepareStatement(getPatientQuery);
            ps.setString(1, patientEmail);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int patientId = rs.getInt("id");

                // Save request to database
                String insertRequestQuery = "INSERT INTO requested_files (patient_id, doctor_email, file_name, file_path, status) VALUES (?, ?, ?, ?, 'Pending')";
                ps = con.prepareStatement(insertRequestQuery);
                ps.setInt(1, patientId);
                ps.setString(2, doctorEmail);
                ps.setString(3, fileName);
                ps.setString(4, "files/" + fileName); // Assuming files are stored in a "files" directory
                ps.executeUpdate();

                response.getWriter().write("Request sent successfully for file: " + fileName);
            } else {
                response.getWriter().write("No patient found with the specified email.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Failed to send request: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
