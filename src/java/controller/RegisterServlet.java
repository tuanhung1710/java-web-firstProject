package controller;

import dao.AccountDAO;
import model.Account;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // 1. Kiểm tra đầu vào cơ bản
        if (fullName == null || email == null || password == null || confirmPassword == null ||
            fullName.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ các thông tin bắt buộc.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // 2. Kiểm tra mật khẩu xác nhận
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        AccountDAO accountDAO = new AccountDAO();
        
        // 3. Kiểm tra Email đã tồn tại chưa
        if (accountDAO.checkEmailExist(email)) {
            request.setAttribute("error", "Email này đã được sử dụng. Vui lòng chọn Email khác.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // 4. Thực hiện đăng ký
        Account newAccount = new Account();
        newAccount.setFullName(fullName);
        newAccount.setEmail(email);
        newAccount.setPhone(phone);
        newAccount.setRole("resident"); // Mặc định là cư dân
        
        boolean isSuccess = accountDAO.register(newAccount, password);
        
        if (isSuccess) {
            // Chuyển hướng sang trang đăng nhập cùng với thông báo thành công
            request.getSession().setAttribute("successMsg", "Bạn đã đăng ký thành công!");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình đăng ký. Vui lòng thử lại sau.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
