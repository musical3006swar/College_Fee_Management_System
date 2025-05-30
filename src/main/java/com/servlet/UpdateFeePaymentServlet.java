package com.servlet;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.FeePaymentDAO;
import com.model.FeePayment;

@WebServlet("/UpdateFeePaymentServlet")
public class UpdateFeePaymentServlet extends HttpServlet {
    private FeePaymentDAO dao = new FeePaymentDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String paymentIDParam = request.getParameter("paymentID");
        
        if (paymentIDParam != null) {
            int paymentID = Integer.parseInt(paymentIDParam);
            FeePayment payment = dao.getFeePaymentById(paymentID);
            request.setAttribute("payment", payment);
        }
        
        request.getRequestDispatcher("feepaymentupdate.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int paymentID = Integer.parseInt(request.getParameter("paymentID"));
            int studentID = Integer.parseInt(request.getParameter("studentID"));
            String studentName = request.getParameter("studentName");
            Date paymentDate = Date.valueOf(request.getParameter("paymentDate"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String status = request.getParameter("status");
            
            FeePayment payment = new FeePayment(studentID, studentName, paymentDate, amount, status);
            payment.setPaymentID(paymentID);
            
            if (dao.updateFeePayment(payment)) {
                request.setAttribute("message", "Fee payment updated successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Failed to update fee payment!");
                request.setAttribute("messageType", "error");
            }
            request.setAttribute("payment", payment);
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }
        
        request.getRequestDispatcher("feepaymentupdate.jsp").forward(request, response);
    }
}