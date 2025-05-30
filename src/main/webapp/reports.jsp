<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports - College Fee Management</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background: #f4f4f4; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
        .header { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 20px; margin: -30px -30px 30px -30px; border-radius: 10px 10px 0 0; }
        .back-btn { background: #6c757d; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-bottom: 20px; }
        .report-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-top: 30px; }
        .report-item { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 30px; border-radius: 10px; text-decoration: none; text-align: center; transition: transform 0.3s; }
        .report-item:hover { transform: translateY(-5px); color: white; text-decoration: none; }
        .report-item h3 { margin: 0 0 10px 0; font-size: 1.3em; }
        .report-item p { margin: 0; opacity: 0.9; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Fee Payment Reports</h1>
            <p style="text-align: center; margin: 10px 0 0 0; opacity: 0.9;">Generate various payment reports and analytics</p>
        </div>
        
        <a href="index.jsp" class="back-btn">← Back to Dashboard</a>
        
        <div class="report-grid">
            <a href="ReportServlet?reportType=overdue" class="report-item">
                <h3>Overdue Payments</h3>
                <p>View all students with overdue fee payments</p>
            </a>
            
            <a href="ReportServlet?reportType=collection" class="report-item">
                <h3>Collection Report</h3>
                <p>Total fee collection over a specific date range</p>
            </a>
        </div>
        
        <div style="margin-top: 30px; padding: 20px; background: #f8f9fa; border-radius: 5px;">
            <h3>Report Features:</h3>
            <ul>
                <li><strong>Overdue Payments:</strong> Instantly view all students who have overdue fee payments</li>
                <li><strong>Collection Report:</strong> Calculate total collections between specific dates</li>
                <li><strong>Payment Status:</strong> Track payment status and history</li>
            </ul>
        </div>
    </div>
</body>
</html>