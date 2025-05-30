<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Collection Report - Date Range</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background: #f4f4f4; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
        .header { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 20px; margin: -30px -30px 30px -30px; border-radius: 10px 10px 0 0; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; box-sizing: border-box; }
        .btn { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        .btn:hover { opacity: 0.9; }
        .back-btn { background: #6c757d; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-bottom: 20px; }
        .info-box { background: #e7f3ff; border: 1px solid #bee5eb; color: #0c5460; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Collection Report</h1>
            <p style="margin: 10px 0 0 0; opacity: 0.9;">Generate fee collection report for a specific date range</p>
        </div>
        
        <a href="ReportServlet" class="back-btn">← Back to Reports</a>
        
        <div class="info-box">
            <strong>Info:</strong> This report will calculate the total fee collection for all "Paid" payments within the selected date range.
        </div>
        
        <form action="ReportServlet" method="get">
            <input type="hidden" name="reportType" value="collection">
            
            <div class="form-group">
                <label for="startDate">Start Date:</label>
                <input type="date" id="startDate" name="startDate" required>
            </div>
            
            <div class="form-group">
                <label for="endDate">End Date:</label>
                <input type="date" id="endDate" name="endDate" required>
            </div>
            
            <button type="submit" class="btn">Generate Report</button>
        </form>
        
        <script>
            // Set default dates
            document.addEventListener('DOMContentLoaded', function() {
                var today = new Date();
                var firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
                var lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);
                
                document.getElementById('startDate').value = firstDay.toISOString().split('T')[0];
                document.getElementById('endDate').value = lastDay.toISOString().split('T')[0];
            });
        </script>
    </div>
</body>
</html>