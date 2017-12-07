<%@page import="javax.mail.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="javax.mail.BodyPart"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Multipart"%>
<%@page import="javax.mail.Session" %>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.AddressException"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeBodyPart"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.internet.MimeMultipart"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MESSAGING IN JSP</title>
</head>
<body>
 <%! String mailid;%>
 <%!String subject; %>
 <%String feedback; %>
 <%String froma;%>
 <%String password;%>
 <%String to; %>
 <%
   mailid=request.getParameter("mail");
   subject=request.getParameter("subj");
   feedback=request.getParameter("feed");
   froma="rslbalaji@gmail.com";
   password="balajivenkat1230";
   to="totreesalive@gmail.com";
  if(mailid==null || password==null || feedback==null) {
	  out.println("ENTER THE ALL FIELDS");
    }
    else {
    	Properties props = System.getProperties();
        props.put("mail.smtp.starttls.enable", true);
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.user", froma);
        props.put("mail.smtp.password", password);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", true);
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session sess = Session.getInstance(props,null);
        MimeMessage message = new MimeMessage(sess);

        System.out.println("Port: "+sess.getProperty("mail.smtp.port"));

        try {
            InternetAddress from = new InternetAddress(froma);
            message.setSubject(subject);
            message.setFrom(from);
            message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

            Multipart multipart = new MimeMultipart("alternative");

            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setText("some text to send");

            multipart.addBodyPart(messageBodyPart);

            messageBodyPart = new MimeBodyPart();
            String htmlMessage = feedback;
            messageBodyPart.setContent(htmlMessage, "text/html");
            System.out.println(messageBodyPart);
            multipart.addBodyPart(messageBodyPart);
            message.setContent(multipart);

            Transport transport = sess.getTransport("smtp");
            transport.connect("smtp.gmail.com", froma, password);
            System.out.println("Transport: "+transport.toString());
            transport.sendMessage(message, message.getAllRecipients());


        } 
        catch (AddressException e) {
            e.printStackTrace();
        } 
        catch (MessagingException e) {
            e.printStackTrace();
        }

    }
 %>
</body>
</html>