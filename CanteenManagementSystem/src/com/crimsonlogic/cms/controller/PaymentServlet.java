package com.crimsonlogic.cms.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.cms.dao.PaymentDao;
import com.crimsonlogic.cms.dao.PaymentDaoImpl;
import com.crimsonlogic.cms.model.Payment;

/**
 * @author abdulmanan
 *
 */
@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		PaymentDao dao = new PaymentDaoImpl();
		List<Payment> paymentList = dao.fetchAllPayments();
		System.out.println(paymentList);
		session.setAttribute("paymentList", paymentList);
		BigDecimal totalSales = BigDecimal.ZERO;

		for (Payment payment : paymentList) {
			if ("Completed".equals(payment.getPaymentStatus())) {
				totalSales = totalSales.add(payment.getPaymentAmount());
			}
		}
		session.setAttribute("totalSales", totalSales);
		response.sendRedirect("adminpayment/adminpayment.jsp");
	}
}
