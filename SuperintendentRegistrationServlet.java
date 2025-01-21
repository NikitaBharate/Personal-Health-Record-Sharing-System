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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SuperintendentRegistrationServlet")
public class SuperintendentRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SuperintendentRegistrationServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstname = request.getParameter("firstName");
        String lastname = request.getParameter("lastName");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String contact = request.getParameter("contact");
        String department = request.getParameter("department");
        String password = request.getParameter("password");

        String jdbcURL = "jdbc:mysql://localhost:3306/healthcare";
        String jdbcUsername = "root";
        String jdbcPassword = "nikkii";

        String privateKey = generatePrivateKey(); 
        String status = "inactive"; 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "INSERT INTO superintendent (first_name, last_name, email, gender, contact, department, password, private_key, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, firstname);
            ps.setString(2, lastname);
            ps.setString(3, email);
            ps.setString(4, gender);
            ps.setString(5, contact);
            ps.setString(6, department);
            ps.setString(7, password);
            ps.setString(8, privateKey);
            ps.setString(9, status);

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                sendConfirmationEmail(email, privateKey); 
                response.getWriter().println("<script>alert('Registration Successful! You can Login now ...'); window.location.href='SuperintendentLogin.jsp';</script>");
            } else {
                response.getWriter().println("<script>alert('Failed to register. Please try again.'); window.history.back();</script>");
            }

            ps.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage());
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
            message.setSubject("Superintendent Registration Confirmation");

            String emailContent = "Dear Superintendent,\n\n" +
                    "Thank you for registering with our healthcare platform.\n\n" +
                    "Your private key is: " + privateKey + "\n\n" +
                    "Please keep this key secure as it will be used for accessing confidential areas.\n\n" +
                    "Your account status is currently set to 'inactive'.\n\n" +
                    "Login here: [Login Page](http://localhost:8080/healthcare/LoginPage.jsp)\n\n" +
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
