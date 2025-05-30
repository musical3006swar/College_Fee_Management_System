package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.model.FeePayment;

public class FeePaymentDAO {
    // IMPORTANT: Adjust these credentials if your MySQL setup is different
    private static final String URL = "jdbc:mysql://localhost:3306/college_fees?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = ""; // <-- SET YOUR MYSQL ROOT PASSWORD HERE IF YOU HAVE ONE!

    // Static block to load the JDBC driver
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
            throw new RuntimeException("Failed to load MySQL JDBC driver.", e);
        }
    }

    // Get database connection
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    // Add new fee payment
    public boolean addFeePayment(FeePayment payment) {
        String sql = "INSERT INTO FeePayments (StudentID, StudentName, PaymentDate, Amount, Status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) { // No need for ResultSet.TYPE_SCROLL_SENSITIVE, etc. for INSERT
            stmt.setInt(1, payment.getStudentID());
            stmt.setString(2, payment.getStudentName());
            stmt.setDate(3, payment.getPaymentDate());
            stmt.setDouble(4, payment.getAmount());
            stmt.setString(5, payment.getStatus());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("DEBUG: Rows affected by addFeePayment: " + rowsAffected); // Debug print
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error adding fee payment: " + e.getMessage()); // Print error for debugging
            e.printStackTrace();
            return false;
        }
    }

    // Update fee payment
    public boolean updateFeePayment(FeePayment payment) {
        String sql = "UPDATE FeePayments SET StudentID=?, StudentName=?, PaymentDate=?, Amount=?, Status=? WHERE PaymentID=?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, payment.getStudentID());
            stmt.setString(2, payment.getStudentName());
            stmt.setDate(3, payment.getPaymentDate());
            stmt.setDouble(4, payment.getAmount());
            stmt.setString(5, payment.getStatus());
            stmt.setInt(6, payment.getPaymentID());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("DEBUG: Rows affected by updateFeePayment: " + rowsAffected); // Debug print
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating fee payment: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Delete fee payment
    public boolean deleteFeePayment(int paymentID) {
        String sql = "DELETE FROM FeePayments WHERE PaymentID=?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, paymentID);

            int rowsAffected = stmt.executeUpdate();
            System.out.println("DEBUG: Rows affected by deleteFeePayment: " + rowsAffected); // Debug print
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting fee payment: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get all fee payments
    public List<FeePayment> getAllFeePayments() {
        List<FeePayment> payments = new ArrayList<>();
        String sql = "SELECT * FROM FeePayments ORDER BY PaymentDate DESC";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                FeePayment payment = new FeePayment();
                payment.setPaymentID(rs.getInt("PaymentID"));
                payment.setStudentID(rs.getInt("StudentID"));
                payment.setStudentName(rs.getString("StudentName"));
                payment.setPaymentDate(rs.getDate("PaymentDate"));
                payment.setAmount(rs.getDouble("Amount"));
                payment.setStatus(rs.getString("Status"));
                payments.add(payment);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all fee payments: " + e.getMessage());
            e.printStackTrace();
        }
        return payments;
    }

    // Get fee payment by ID
    public FeePayment getFeePaymentById(int paymentID) {
        String sql = "SELECT * FROM FeePayments WHERE PaymentID=?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, paymentID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    FeePayment payment = new FeePayment();
                    payment.setPaymentID(rs.getInt("PaymentID"));
                    payment.setStudentID(rs.getInt("StudentID"));
                    payment.setStudentName(rs.getString("StudentName"));
                    payment.setPaymentDate(rs.getDate("PaymentDate"));
                    payment.setAmount(rs.getDouble("Amount"));
                    payment.setStatus(rs.getString("Status"));
                    return payment;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting fee payment by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Get overdue payments
    public List<FeePayment> getOverduePayments() {
        List<FeePayment> payments = new ArrayList<>();
        // Assuming 'Overdue' is a status you set manually or via another process
        String sql = "SELECT * FROM FeePayments WHERE Status='Overdue' ORDER BY PaymentDate ASC";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                FeePayment payment = new FeePayment();
                payment.setPaymentID(rs.getInt("PaymentID"));
                payment.setStudentID(rs.getInt("StudentID"));
                payment.setStudentName(rs.getString("StudentName"));
                payment.setPaymentDate(rs.getDate("PaymentDate"));
                payment.setAmount(rs.getDouble("Amount"));
                payment.setStatus(rs.getString("Status"));
                payments.add(payment);
            }
        } catch (SQLException e) {
            System.err.println("Error getting overdue payments: " + e.getMessage());
            e.printStackTrace();
        }
        return payments;
    }

    // Get total collection in date range
    public double getTotalCollection(String startDate, String endDate) {
        String sql = "SELECT SUM(Amount) as total FROM FeePayments WHERE PaymentDate BETWEEN ? AND ? AND Status='Paid'";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, startDate);
            stmt.setString(2, endDate);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting total collection: " + e.getMessage());
            e.printStackTrace();
        }
        return 0.0;
    }
}