package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.FeePaymentDAO;

@WebServlet("/DeleteFeePaymentServlet")
public class DeleteFeePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L; // Recommended for Servlets
    private FeePaymentDAO dao = new FeePaymentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Typically used to display the form for deleting a payment.
        request.getRequestDispatcher("feepaymentdelete.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String paymentIDParam = request.getParameter("paymentID");
            int paymentID;

            if (paymentIDParam != null && !paymentIDParam.trim().isEmpty()) {
                paymentID = Integer.parseInt(paymentIDParam);
            } else {
                throw new IllegalArgumentException("Payment ID cannot be empty.");
            }

            if (dao.deleteFeePayment(paymentID)) {
                request.setAttribute("message", "Fee payment deleted successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Failed to delete fee payment or payment not found. Check server logs.");
                request.setAttribute("messageType", "error");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Error: Invalid number format for Payment ID. " + e.getMessage());
            request.setAttribute("messageType", "error");
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
            e.printStackTrace();
        } catch (Exception e) {
            request.setAttribute("message", "An unexpected error occurred: " + e.getMessage());
            request.setAttribute("messageType", "error");
            e.printStackTrace();
        } finally {
            // Always forward to feepaymentdelete.jsp to display the result message
            request.getRequestDispatcher("feepaymentdelete.jsp").forward(request, response);
        }
    }
}