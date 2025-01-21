import java.io.File;
import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/DoctorRegistrationServlet")
@MultipartConfig 
public class DoctorRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR = "licenses";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String medicalLicense = request.getParameter("Medicallicense");
        String specialization = request.getParameter("Specialization");
        String experience = request.getParameter("Experience");
        String fees = request.getParameter("fees");
        String password = request.getParameter("password");
        String status = "inactive"; 

        Part licenseUpload = request.getPart("licenseUpload");

        String jdbcURL = "jdbc:mysql://localhost:3306/healthcare"; 
        String jdbcUsername = "root"; 
        String jdbcPassword = "nikkii";

        String applicationPath = getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) uploadDir.mkdir(); 

        String fileName = null;
        if (licenseUpload != null && licenseUpload.getSize() > 0) {
            fileName = new File(licenseUpload.getSubmittedFileName()).getName();
            licenseUpload.write(uploadFilePath + File.separator + fileName);
        }

        String privateKey = generatePrivateKey();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "INSERT INTO doctor (first_name, last_name, dob, gender, contact, email, address, medical_license, specialization, experience, fees, password, license_upload, private_key, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, firstName);
            statement.setString(2, lastName);
            statement.setString(3, dob);
            statement.setString(4, gender);
            statement.setString(5, contact);
            statement.setString(6, email);
            statement.setString(7, address);
            statement.setString(8, medicalLicense);
            statement.setString(9, specialization);
            statement.setString(10, experience);
            statement.setString(11, fees);
            statement.setString(12, password);

            if (fileName != null) {
                String filePath = UPLOAD_DIR + "/" + fileName; 
                statement.setString(13, filePath);
            } else {
                statement.setNull(13, java.sql.Types.VARCHAR);
            }

            statement.setString(14, privateKey); 
            statement.setString(15, status); 

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                sendConfirmationEmail(email, privateKey);
                request.setAttribute("registrationStatus", "success");
                RequestDispatcher dispatcher = request.getRequestDispatcher("DoctorReg.jsp");
                dispatcher.forward(request, response);
            } else {
                response.getWriter().println("Failed to register. Please try again.");
            }

            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred. Please try again.");
        }
    }

    private String generatePrivateKey() {
        SecureRandom random = new SecureRandom();
        String alphanumeric = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder sb = new StringBuilder(6);
        for (int i = 0; i < 6; i++) {
            sb.append(alphanumeric.charAt(random.nextInt(alphanumeric.length())));
        }
        return sb.toString();
    }

    private void sendConfirmationEmail(String recipientEmail, String privateKey) {
        final String senderEmail = "bharatenikita7@gmail.com";
        final String senderPassword = "zysgricmzkkgainj"; 

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Doctor Registration Confirmation");

            String emailContent = "Dear Doctor,\n\n" +
                    "Thank you for registering with our healthcare platform.\n\n" +
                    "Your registration is successful! Below is your private key:\n\n" +
                    "Private Key: " + privateKey + "\n\n" +
                    "Please keep this key secure as it will be required for future login and verification.\n\n" +
                    "Your account is currently set to 'inactive'. The admin will review your information and activate your account shortly.\n\n" +
                    "Please log in here: http://localhost:8080/HealthRecord/DoctorLogin.jsp\n\n" +
                    "Best Regards,\nHealthcare Team";

            message.setText(emailContent);

            Transport.send(message);
            System.out.println("Confirmation email sent successfully!");

        } catch (MessagingException e) {
            System.out.println("Error occurred while sending email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
