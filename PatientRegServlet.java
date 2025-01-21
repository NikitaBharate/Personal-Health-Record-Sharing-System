import java.io.IOException;
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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PatientRegServlet")
public class PatientRegServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public PatientRegServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstname = request.getParameter("firstName");
        String lastname = request.getParameter("lastName");
        String dob = request.getParameter("dob");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword").trim();  // Trim to remove any extra spaces
        String gender = request.getParameter("gender");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String medications = request.getParameter("medications");  // New field

        if (!password.equals(confirmPassword)) {
            response.getWriter().println("Passwords do not match. Please try again.");
            return;
        }

        String jdbcURL = "jdbc:mysql://localhost:3306/healthcare";
        String jdbcUsername = "root";
        String jdbcPassword = "nikkii";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "INSERT INTO patient (first_name, last_name, dob, email, password, gender, contact, address, medications) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, firstname);
            ps.setString(2, lastname);
            ps.setString(3, dob);
            ps.setString(4, email);
            ps.setString(5, password);
            ps.setString(6, gender);
            ps.setString(7, contact);
            ps.setString(8, address);
            ps.setString(9, medications);

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                sendConfirmationEmail(email);
                response.sendRedirect("PatientDashboard.jsp");
            } else {
                response.getWriter().println("Failed to register. Please try again.");
            }

            ps.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred. Please try again.");
        }
    }

    private void sendConfirmationEmail(String recipientEmail) {
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
            message.setSubject("Patient Registration Confirmation");

            String emailContent = "Dear Patient,\n\n" +
                    "Thank you for registering with our healthcare platform.\n\n" +
                    "Your registration is successful! You can now access the platform using your credentials.\n\n" +
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
