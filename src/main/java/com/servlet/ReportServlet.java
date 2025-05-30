package com.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.FeePaymentDAO;
import com.model.FeePayment;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private FeePaymentDAO dao = new FeePaymentDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String reportType = request.getParameter("reportType");
        
        if ("overdue".equals(reportType)) {
            List<FeePayment> overduePayments = dao.getOverduePayments();
            request.setAttribute("reportTitle", "Students with Overdue Payments");
            request.setAttribute("payments", overduePayments);
            request.getRequestDispatcher("report_result.jsp").forward(request, response);
        } else if ("collection".equals(reportType)) {
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            
            if (startDate != null && endDate != null) {
                double totalCollection = dao.getTotalCollection(startDate, endDate);
                request.setAttribute("reportTitle", "Total Collection Report");
                request.setAttribute("startDate", startDate);
                request.setAttribute("endDate", endDate);
                request.setAttribute("totalCollection", totalCollection);
                request.getRequestDispatcher("report_result.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("report_form.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}