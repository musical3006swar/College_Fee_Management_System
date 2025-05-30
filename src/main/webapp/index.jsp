<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>College Fee Management System</title>
    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            width: 500px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #6e8efb, #a777e3);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .header h1 {
            margin: 0;
            font-size: 1.8em;
            font-weight: 600;
        }
        .header p {
            margin: 10px 0 0;
            font-size: 1em;
            opacity: 0.9;
        }
        .payment-box {
            padding: 40px;
            text-align: center;
        }
        .add-payment {
            display: inline-block;
            background: linear-gradient(135deg, #6e8efb, #a777e3);
            color: white;
            padding: 15px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            font-size: 1.1em;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(110, 142, 251, 0.3);
        }
        .add-payment:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(110, 142, 251, 0.4);
        }
        .add-payment i {
            margin-right: 10px;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>College Fee Management System</h1>
            <p>Streamline your institution's financial operations with ease</p>
        </div>
        
        <div class="payment-box">
            <a href="AddFeePaymentServlet" class="add-payment">
                <i class="fas fa-plus-circle"></i>Add Fee Payment
            </a>
        </div>
    </div>
</body>
</html>