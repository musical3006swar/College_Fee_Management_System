package com.servlet;

import java.io.IOException;
import java.sql.Date; // Make sure this is java.sql.Date
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.FeePaymentDAO;
import com.model.FeePayment;

@WebServlet("/AddFeePaymentServlet")
public class AddFeePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L; // Recommended for Servlets
    private FeePaymentDAO dao = new FeePaymentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This is typically used to display the empty form for adding a new payment.
        request.getRequestDispatcher("feepaymentadd.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve parameters from the form
            String studentIDParam = request.getParameter("studentID");
            String studentName = request.getParameter("studentName");
            String paymentDateParam = request.getParameter("paymentDate");
            String amountParam = request.getParameter("amount");
            String status = request.getParameter("status");

            // --- Input Validation and Parsing ---
            int studentID;
            if (studentIDParam != null && !studentIDParam.trim().isEmpty()) {
                studentID = Integer.parseInt(studentIDParam);
            } else {
                throw new IllegalArgumentException("Student ID cannot be empty.");
            }

            // Payment Date: Ensure the format is 'yyyy-MM-dd' for java.sql.Date.valueOf()
            Date paymentDate;
            if (paymentDateParam != null && !paymentDateParam.trim().isEmpty()) {
                paymentDate = Date.valueOf(paymentDateParam); // Expects yyyy-MM-dd
            } else {
                throw new IllegalArgumentException("Payment Date cannot be empty and must be in yyyy-MM-dd format.");
            }

            double amount;
            if (amountParam != null && !amountParam.trim().isEmpty()) {
                amount = Double.parseDouble(amountParam);
            } else {
                throw new IllegalArgumentException("Amount cannot be empty.");
            }

            if (studentName == null || studentName.trim().isEmpty()) {
                throw new IllegalArgumentException("Student Name cannot be empty.");
            }

            if (status == null || status.trim().isEmpty()) {
                status = "Pending"; // Default status if not provided
            }

            // Create FeePayment object
            FeePayment payment = new FeePayment(studentID, studentName, paymentDate, amount, status);

            // Add fee payment to the database
            if (dao.addFeePayment(payment)) {
                request.setAttribute("message", "Fee payment added successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Failed to add fee payment. Check server logs for details.");
                request.setAttribute("messageType", "error");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Error: Invalid number format for Student ID or Amount. " + e.getMessage());
            request.setAttribute("messageType", "error");
            e.printStackTrace(); // Log the actual exception for debugging
        } catch (IllegalArgumentException e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
            e.printStackTrace(); // Log the actual exception for debugging
        } catch (Exception e) {
            request.setAttribute("message", "An unexpected error occurred: " + e.getMessage());
            request.setAttribute("messageType", "error");
            e.printStackTrace(); // Log the actual exception for debugging
        } finally {
            // Always forward to feepaymentadd.jsp to display the result message
            request.getRequestDispatcher("feepaymentadd.jsp").forward(request, response);
        }
    }
}