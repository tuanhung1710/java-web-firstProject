package controller;

import dao.AccountDAO;
import model.Account;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ Email và Mật khẩu.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.login(email, password);
        
        if (account != null) {
            // Ngăn chặn tấn công Session Fixation: Hủy session cũ nếu có
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            
            // Tạo một session hoàn toàn mới
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("account", account);
            
            // Điều hướng dựa theo Role
            String role = account.getRole().toLowerCase();
            switch (role) {
                case "admin":
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
                    break;
                case "manager":
                    response.sendRedirect(request.getContextPath() + "/manager/dashboard.jsp");
                    break;
                case "staff":
                    response.sendRedirect(request.getContextPath() + "/staff/tasks.jsp");
                    break;
                case "resident":
                case "owner":
                case "tenant":
                    response.sendRedirect(request.getContextPath() + "/resident/home.jsp");
                    break;
                default:
                    // Mặc định ném về trang chủ chung nếu có role không mong đợi
                    response.sendRedirect(request.getContextPath() + "/home");
                    break;
            }
        } else {
            // Sai thông tin đăng nhập hoặc tài khoản bị khóa
            request.setAttribute("error", "Email/Mật khẩu không hợp lệ hoặc tài khoản đang bị khóa.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
