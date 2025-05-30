package com.model;

import java.sql.Date; // Make sure this is java.sql.Date

public class FeePayment {
    private int paymentID;
    private int studentID;
    private String studentName;
    private Date paymentDate;
    private double amount;
    private String status;

    // Default constructor
    public FeePayment() {}

    // Constructor for adding new payments (without PaymentID, as it's auto-increment)
    public FeePayment(int studentID, String studentName, Date paymentDate, double amount, String status) {
        this.studentID = studentID;
        this.studentName = studentName;
        this.paymentDate = paymentDate;
        this.amount = amount;
        this.status = status;
    }

    // Constructor for retrieving/updating (with PaymentID)
    public FeePayment(int paymentID, int studentID, String studentName, Date paymentDate, double amount, String status) {
        this.paymentID = paymentID;
        this.studentID = studentID;
        this.studentName = studentName;
        this.paymentDate = paymentDate;
        this.amount = amount;
        this.status = status;
    }

    // Getters and Setters
    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "FeePayment [paymentID=" + paymentID + ", studentID=" + studentID + ", studentName=" + studentName
                + ", paymentDate=" + paymentDate + ", amount=" + amount + ", status=" + status + "]";
    }
}