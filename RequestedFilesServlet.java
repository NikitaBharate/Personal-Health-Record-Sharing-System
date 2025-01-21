

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

class RequestedFile {
    private String patientName;
    private String patientEmail;
    private String fileName;
    private String status;
    private String filePath;

    public RequestedFile(String patientName, String patientEmail, String fileName, String status, String filePath) {
        this.patientName = patientName;
        this.patientEmail = patientEmail;
        this.fileName = fileName;
        this.status = status;
        this.filePath = filePath;
    }

    public String getPatientName() { return patientName; }
    public String getPatientEmail() { return patientEmail; }
    public String getFileName() { return fileName; }
    public String getStatus() { return status; }
    public String getFilePath() { return filePath; }
}

@WebServlet("/RequestedFilesServlet")
public class RequestedFilesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer doctorId = (Integer) session.getAttribute("doctorId");  // Get doctor ID from session

        if (doctorId == null) {
            response.sendRedirect("DoctorLogin.jsp");
            return;
        }

        String jdbcURL = "jdbc:mysql://localhost:3306/healthcare";
        String jdbcUsername = "root";
        String jdbcPassword = "nikkii";

        List<RequestedFile> requestedFiles = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String query = "SELECT p.first_name AS patientName, p.email AS patientEmail,r.doctor_email, r.file_name, r.status, f.file_path " +
                           "FROM requested_files r " +
                           "JOIN patient p ON r.patient_id = p.id " +
                           "LEFT JOIN files f ON r.file_name = f.file_name " +
                           "WHERE r.doctor_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, doctorId);  
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String patientName = rs.getString("patientName");
                String patientEmail = rs.getString("patientEmail");
                String fileName = rs.getString("file_name");
                String status = rs.getString("status");
                String filePath = rs.getString("file_path");

                requestedFiles.add(new RequestedFile(patientName, patientEmail, fileName, status, filePath));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading requested files: " + e.getMessage());
        }

        request.setAttribute("requestedFiles", requestedFiles);
        request.getRequestDispatcher("RequestedFiles.jsp").forward(request, response);
    }
}
