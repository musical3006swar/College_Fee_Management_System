<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.FeePayment" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Fee Payment</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background: #f4f4f4; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; margin: -30px -30px 30px -30px; border-radius: 10px 10px 0 0; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; box-sizing: border-box; }
        .btn { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        .btn:hover { opacity: 0.9; }
        .back-btn { background: #6c757d; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-bottom: 20px; }
        .message { padding: 15px; margin-bottom: 20px; border-radius: 5px; }
        .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .search-form { background: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Update Fee Payment</h1>
        </div>
        
        <a href="index.jsp" class="back-btn">← Back to Dashboard</a>
        
        <% if (request.getAttribute("message") != null) { %>
            <div class="message <%= request.getAttribute("messageType") %>">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <% FeePayment payment = (FeePayment) request.getAttribute("payment"); %>
        <% if (payment == null) { %>
            <div class="search-form">
                <h3>Search Payment to Update</h3>
                <form action="UpdateFeePaymentServlet" method="get">
                    <div class="form-group">
                        <label for="paymentID">Payment ID:</label>
                        <input type="number" id="paymentID" name="paymentID" required>
                    </div>
                    <button type="submit" class="btn">Search</button>
                </form>
            </div>
        <% } else { %>
            <form action="UpdateFeePaymentServlet" method="post">
                <input type="hidden" name="paymentID" value="<%= payment.getPaymentID() %>">
                
                <div class="form-group">
                    <label for="studentID">Student ID:</label>
                    <input type="number" id="studentID" name="studentID" value="<%= payment.getStudentID() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="studentName">Student Name:</label>
                    <input type="text" id="studentName" name="studentName" value="<%= payment.getStudentName() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="paymentDate">Payment Date:</label>
                    <input type="date" id="paymentDate" name="paymentDate" value="<%= payment.getPaymentDate() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="amount">Amount:</label>
                    <input type="number" step="0.01" id="amount" name="amount" value="<%= payment.getAmount() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status" required>
                        <option value="Paid" <%= "Paid".equals(payment.getStatus()) ? "selected" : "" %>>Paid</option>
                        <option value="Overdue" <%= "Overdue".equals(payment.getStatus()) ? "selected" : "" %>>Overdue</option>
                    </select>
                </div>
                
                <button type="submit" class="btn">Update Payment</button>
            </form>
        <% } %>
    </div>
</body>
</html>