import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UploadFileServlet")
@MultipartConfig
public class UploadFileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String SAVE_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileDescription = request.getParameter("file_description");

        if (fileDescription == null || fileDescription.trim().isEmpty()) {
            response.getWriter().write("File description cannot be empty.");
            return;
        }

        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();

        if (fileName == null || fileName.isEmpty()) {
            response.getWriter().write("No file selected.");
            return;
        }

        String filePath = "uploads/" + fileName;

        String uploadDirPath = getServletContext().getRealPath("/") + SAVE_DIR;
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        InputStream fileContent = filePart.getInputStream();
        FileOutputStream out = new FileOutputStream(new File(uploadDirPath + File.separator + fileName));
        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = fileContent.read(buffer)) != -1) {
            out.write(buffer, 0, bytesRead);
        }
        out.close();

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/healthcare", "root", "nikkii");

            String query = "INSERT INTO files (patient_id, file_name, file_description, file_path) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(query);

            Integer patientId = (Integer) request.getSession().getAttribute("patient_id");
            String patientEmail = (String) request.getSession().getAttribute("patient_email");
            if (patientId == null || patientEmail == null) {
                response.getWriter().write("No patient session found.");
                return;
            }

            stmt.setInt(1, patientId);
            stmt.setString(2, fileName);
            stmt.setString(3, fileDescription);
            stmt.setString(4, filePath);

            stmt.executeUpdate();
            stmt.close();

            response.getWriter().write("File uploaded successfully.");
            response.sendRedirect("PatientDashboard.jsp");  

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error uploading file: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
