<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Hệ Thống</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            /* Nền gradient xanh công nghệ phối xám */
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            width: 100%;
            max-width: 420px;
            padding: 2.5rem;
            background: #ffffff;
            border-radius: 1rem;
        }
        .login-header {
            color: #1e3c72;
            font-weight: 800;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
        }
        /* Custom Input Group */
        .input-group-text {
            background-color: #f8f9fa;
            border-right: none;
            color: #6c757d;
        }
        .form-control {
            border-left: none;
            background-color: #f8f9fa;
        }
        .form-control:focus {
            box-shadow: none;
            background-color: #fff;
            border-color: #ced4da;
        }
        .input-group:focus-within .input-group-text,
        .input-group:focus-within .form-control {
            background-color: #fff;
            border-color: #1e3c72;
            box-shadow: 0 0 0 0.2rem rgba(30, 60, 114, 0.25);
        }
        /* Custom Button */
        .btn-login {
            background: linear-gradient(to right, #1e3c72, #2a5298);
            border: none;
            color: white;
            font-weight: 600;
            padding: 0.75rem;
            transition: all 0.3s ease;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(30, 60, 114, 0.4);
            color: white;
        }
    </style>
</head>
<body>
    <div class="login-card shadow-lg">
        <div class="text-center mb-4">
            <div class="mb-3">
                <i class="fa-solid fa-building-user fa-3x" style="color: #1e3c72;"></i>
            </div>
            <h3 class="login-header">SMART BUILDING</h3>
            <p class="text-muted">Đăng nhập hệ thống quản lý</p>
        </div>
        
        <c:if test="${not empty requestScope.error}">
            <div class="alert alert-danger d-flex align-items-center rounded-3 border-0 shadow-sm" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2 fs-5"></i>
                <div>
                    <c:out value="${requestScope.error}"/>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.successMsg}">
            <div class="alert alert-success d-flex align-items-center rounded-3 border-0 shadow-sm" role="alert">
                <i class="fa-solid fa-circle-check me-2 fs-5"></i>
                <div>
                    <c:out value="${sessionScope.successMsg}"/>
                </div>
            </div>
            <% session.removeAttribute("successMsg"); %>
        </c:if>

        <form action="login" method="POST">
            <div class="mb-4">
                <label for="email" class="form-label fw-semibold text-secondary">Email đăng nhập</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                    <input type="email" class="form-control form-control-lg" id="email" name="email" placeholder="example@email.com" required autofocus>
                </div>
            </div>
            
            <div class="mb-4">
                <div class="d-flex justify-content-between">
                    <label for="password" class="form-label fw-semibold text-secondary">Mật khẩu</label>
                    <a href="#" class="text-decoration-none small" style="color: #1e3c72;">Quên mật khẩu?</a>
                </div>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                    <input type="password" class="form-control form-control-lg" id="password" name="password" placeholder="••••••••" required>
                </div>
            </div>
            
            <div class="d-grid mb-4 mt-2">
                <button type="submit" class="btn btn-login btn-lg rounded-3">
                    <i class="fa-solid fa-right-to-bracket me-2"></i> Đăng Nhập
                </button>
            </div>
            
            <div class="text-center">
                <span class="text-muted small">Chưa có tài khoản?</span> 
                <a href="register" class="text-decoration-none fw-bold small" style="color: #2a5298;">Đăng ký ngay</a>
            </div>
        </form>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
