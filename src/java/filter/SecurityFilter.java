package filter;

import model.Account;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "SecurityFilter", urlPatterns = {"/*"})
public class SecurityFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo Filter (nếu cần)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
            
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        // Cho phép truy cập tự do vào các file tĩnh, trang đăng nhập và đăng ký
        if (path.startsWith("/login") || path.startsWith("/register") || path.startsWith("/assets/") || 
            path.startsWith("/css/") || path.startsWith("/js/") || path.startsWith("/images/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("account") : null;
        
        // Nếu người dùng chưa đăng nhập, đá về trang /login
        if (account == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        // Người dùng đã đăng nhập, kiểm tra nghiêm ngặt quyền truy cập theo URL
        String role = account.getRole().toLowerCase();
        
        if (path.startsWith("/admin") && !role.equals("admin")) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Từ chối truy cập: Yêu cầu quyền Admin.");
            return;
        }
        
        if (path.startsWith("/manager") && !role.equals("manager")) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Từ chối truy cập: Yêu cầu quyền Manager.");
            return;
        }

        if (path.startsWith("/staff") && !role.equals("staff")) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Từ chối truy cập: Yêu cầu quyền Staff.");
            return;
        }

        if (path.startsWith("/resident") && !(role.equals("resident") || role.equals("owner") || role.equals("tenant"))) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Từ chối truy cập: Yêu cầu quyền Resident (hoặc Owner/Tenant).");
            return;
        }

        // Cho phép request đi tiếp nếu qua được các vòng kiểm tra trên
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Hủy Filter (nếu cần)
    }
}
