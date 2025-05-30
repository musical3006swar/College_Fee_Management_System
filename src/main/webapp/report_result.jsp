<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.FeePayment" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Results</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background: #f4f4f4; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
        .header { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 20px; margin: -30px -30px 30px -30px; border-radius: 10px 10px 0 0; }
        .back-btn { background: #6c757d; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-bottom: 20px; margin-right: 10px; }
        .print-btn { background: #17a2b8; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; font-weight: bold; color: #333; }
        tr:hover { background: #f5f5f5; }
        .status-paid { background: #d4edda; color: #155724; padding: 4px 8px; border-radius: 4px; font-size: 12px; }
        .status-overdue { background: #f8d7da; color: #721c24; padding: 4px 8px; border-radius: 4px; font-size: 12px; }
        .no-data { text-align: center; padding: 40px; color: #666; }
        .summary-box { background: #e7f3ff; border: 1px solid #bee5eb; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .summary-item { display: inline-block; margin-right: 30px; }
        .summary-value { font-size: 1.5em; font-weight: bold; color: #28a745; }
        @media print {
            .no-print { display: none; }
            .container { box-shadow: none; }
            .header { background: #28a745 !important; -webkit-print-color-adjust: exact; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><%= request.getAttribute("reportTitle") %></h1>
        </div>
        
        <div class="no-print">
            <a href="ReportServlet" class="back-btn">← Back to Reports</a>
            <a href="javascript:window.print()" class="print-btn">Print Report</a>
        </div>
        
        <%
            String reportTitle = (String) request.getAttribute("reportTitle");
            List<FeePayment> payments = (List<FeePayment>) request.getAttribute("payments");
            Double totalCollection = (Double) request.getAttribute("totalCollection");
            String startDate = (String) request.getAttribute("startDate");
            String endDate = (String) request.getAttribute("endDate");
        %>
        
        <% if ("Total Collection Report".equals(reportTitle)) { %>
            <div class="summary-box">
                <div class="summary-item">
                    <div>Report Period:</div>
                    <div class="summary-value"><%= startDate %> to <%= endDate %></div>
                </div>
                <div class="summary-item">
                    <div>Total Collection:</div>
                    <div class="summary-value">₹<%= String.format("%.2f", totalCollection != null ? totalCollection : 0.0) %></div>
                </div>
                <div style="clear: both; margin-top: 10px; color: #666; font-size: 14px;">
                    Generated on: <%= new java.util.Date() %>
                </div>
            </div>
        <% } %>
        
        <% if (payments != null && !payments.isEmpty()) { %>
            <% if ("Students with Overdue Payments".equals(reportTitle)) { %>
                <div class="summary-box">
                    <div class="summary-item">
                        <div>Total Overdue Records:</div>
                        <div class="summary-value"><%= payments.size() %></div>
                    </div>
                    <div class="summary-item">
                        <div>Total Overdue Amount:</div>
                        <div class="summary-value">
                            ₹<%= String.format("%.2f", payments.stream().mapToDouble(FeePayment::getAmount).sum()) %>
                        </div>
                    </div>
                    <div style="clear: both; margin-top: 10px; color: #666; font-size: 14px;">
                        Generated on: <%= new java.util.Date() %>
                    </div>
                </div>
            <% } %>

            <table>
                <thead>
                    <tr>
                        <th>Payment ID</th>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Payment Date</th>
                        <th>Amount</th>
                        <th>Status</th>
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
                                <span class="<%= "Paid".equalsIgnoreCase(payment.getStatus()) ? "status-paid" : "status-overdue" %>">
                                    <%= payment.getStatus() %>
                                </span>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="no-data">No records found for this report.</div>
        <% } %>
    </div>
</body>
</html>
