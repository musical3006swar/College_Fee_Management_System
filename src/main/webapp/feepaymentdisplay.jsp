<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.FeePayment" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Fee Payments</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background: #f4f4f4; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; margin: -30px -30px 30px -30px; border-radius: 10px 10px 0 0; }
        .back-btn { background: #6c757d; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; font-weight: bold; color: #333; }
        tr:hover { background: #f5f5f5; }
        .status-paid { background: #d4edda; color: #155724; padding: 4px 8px; border-radius: 4px; font-size: 12px; }
        .status-overdue { background: #f8d7da; color: #721c24; padding: 4px 8px; border-radius: 4px; font-size: 12px; }
        .no-data { text-align: center; padding: 40px; color: #666; }
        .actions { text-align: center; }
        .edit-btn { background: #28a745; color: white; padding: 5px 10px; text-decoration: none; border-radius: 3px; font-size: 12px; margin-right: 5px; }
        .delete-btn { background: #dc3545; color: white; padding: 5px 10px; text-decoration: none; border-radius: 3px; font-size: 12px; }
        .total-amount { background: #e9ecef; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>All Fee Payments</h1>
        </div>
        
        <a href="index.jsp" class="back-btn">← Back to Dashboard</a>
        
        <% 
        List<FeePayment> payments = (List<FeePayment>) request.getAttribute("payments");
        double totalAmount = 0;
        if (payments != null) {
            for (FeePayment payment : payments) {
                if ("Paid".equals(payment.getStatus())) {
                    totalAmount += payment.getAmount();
                }
            }
        }
        %>
        
        <% if (payments != null && !payments.isEmpty()) { %>
            <p><strong>Total Records:</strong> <%= payments.size() %> | <strong>Total Collection:</strong> ₹<%= String.format("%.2f", totalAmount) %></p>
            
            <table>
                <thead>
                    <tr>
                        <th>Payment ID</th>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Payment Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (FeePayment payment : payments) { %>
                        <tr>
                            <td><%= payment.getPaymentID() %></td>
                            <td><%= payment.getStudentID() %></td>
                            <td><%= payment.getStudentName() %></td>
                            <td><%= payment.getPaymentDate() %></td>
                            <td>₹<%= String.format("%.2f", payment.getAmount()) %></td>
                            <td>
                                <span class="status-<%= payment.getStatus().toLowerCase() %>">
                                    <%= payment.getStatus() %>
                                </span>
                            </td>
                            <td class="actions">
                                <a href="UpdateFeePaymentServlet?paymentID=<%= payment.getPaymentID() %>" class="edit-btn">Edit</a>
                                <a href="#" onclick="deletePayment(<%= payment.getPaymentID() %>)" class="delete-btn">Delete</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="no-data">
                <h3>No fee payment records found</h3>
                <p>Start by adding some fee payments.</p>
                <a href="AddFeePaymentServlet" class="back-btn">Add Fee Payment</a>
            </div>
        <% } %>
    </div>
    
    <script>
        function deletePayment(paymentID) {
            if (confirm('Are you sure you want to delete this payment record?')) {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = 'DeleteFeePaymentServlet';
                
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'paymentID';
                input.value = paymentID;
                
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>