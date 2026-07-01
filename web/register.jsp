<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .register-card {
            width: 100%;
            max-width: 500px;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            background-color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="register-card">
        <div class="text-center mb-4">
            <h3 class="text-primary fw-bold">ĐĂNG KÝ TÀI KHOẢN</h3>
            <p class="text-muted">Dành cho Cư dân / Chủ hộ / Người thuê</p>
        </div>
        
        <% 
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) { 
        %>
            <div class="alert alert-danger" role="alert">
                <%= error %>
            </div>
        <% } %>

        <form action="register" method="POST">
            <div class="mb-3">
                <label for="fullName" class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Nhập họ và tên đầy đủ" 
                       value="${requestScope.fullName}" required autofocus>
            </div>
            
            <div class="mb-3">
                <label for="email" class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Nhập địa chỉ email" 
                       value="${requestScope.email}" required>
            </div>
            
            <div class="mb-3">
                <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                <input type="tel" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại" 
                       value="${requestScope.phone}">
            </div>
            
            <div class="mb-3">
                <label for="password" class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Tạo mật khẩu" required>
            </div>
            
            <div class="mb-4">
                <label for="confirmPassword" class="form-label fw-semibold">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
            </div>
            
            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary btn-lg fw-bold">Đăng Ký</button>
            </div>
            
            <div class="text-center">
                <span class="text-muted">Đã có tài khoản?</span> <a href="login" class="text-decoration-none fw-bold">Đăng nhập ngay</a>
            </div>
        </form>
    </div>
    
    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
