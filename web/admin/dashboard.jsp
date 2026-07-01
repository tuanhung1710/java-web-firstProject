<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Smart Building</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; overflow-x: hidden; }
        .wrapper { display: flex; width: 100%; align-items: stretch; min-height: 100vh; }
        
        /* Sidebar Styling */
        #sidebar { min-width: 260px; max-width: 260px; background: #1a1a2e; color: #fff; transition: all 0.3s; }
        #sidebar .sidebar-header { padding: 20px; background: #16213e; border-bottom: 1px solid #0f3460; }
        #sidebar ul.components { padding: 20px 0; }
        #sidebar ul li a { padding: 15px 25px; font-size: 1.05em; display: block; color: #a9a9a9; text-decoration: none; transition: 0.3s; }
        #sidebar ul li a:hover, #sidebar ul li.active > a { color: #fff; background: #0f3460; border-left: 4px solid #e94560; }
        #sidebar ul li a i { width: 30px; text-align: center; margin-right: 10px; font-size: 1.1em; }
        
        /* Content Styling */
        #content { width: 100%; padding: 0; }
        
        /* Top Navbar */
        .top-navbar { background: #fff; padding: 15px 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e94560; }
        .user-profile { display: flex; align-items: center; gap: 15px; }
        .avatar { width: 40px; height: 40px; border-radius: 50%; background: #e94560; color: white; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1.2rem; }
        
        /* Main Container */
        .main-container { padding: 30px; }
        .card { border-radius: 10px; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .card-header { background: #fff; border-bottom: 1px solid #eee; padding: 20px; font-weight: bold; color: #1a1a2e; }
    </style>
</head>
<body>
    <div class="wrapper">
        <!-- Sidebar -->
        <nav id="sidebar">
            <div class="sidebar-header d-flex align-items-center">
                <i class="fa-solid fa-server fa-2x me-3 text-danger"></i>
                <h4 class="mb-0 fw-bold">System Admin</h4>
            </div>
            <ul class="list-unstyled components">
                <li class="active">
                    <a href="#"><i class="fa-solid fa-gauge-high"></i> Dashboard Hệ Thống</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-users"></i> Quản lý Tài khoản</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-shield-halved"></i> Phân quyền (Roles)</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-database"></i> Sao lưu Dữ liệu</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-gear"></i> Cài đặt Hệ thống</a>
                </li>
            </ul>
        </nav>

        <!-- Page Content -->
        <div id="content">
            <!-- Topbar -->
            <div class="top-navbar">
                <div class="d-flex align-items-center">
                    <h5 class="mb-0 text-secondary fw-semibold">Bảng Điều Khiển Quản Trị Tối Cao</h5>
                </div>
                <div class="user-profile">
                    <div class="d-flex flex-column text-end">
                        <span class="fw-bold text-dark"><c:out value="${sessionScope.account.fullName}"/></span>
                        <span class="badge bg-danger mt-1">Administrator</span>
                    </div>
                    <div class="avatar shadow-sm"><i class="fa-solid fa-user-shield"></i></div>
                    <div class="dropdown">
                        <button class="btn btn-link text-dark text-decoration-none dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"></button>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                            <li><a class="dropdown-item" href="#"><i class="fa-solid fa-user-gear me-2"></i> Thông tin cá nhân</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-power-off me-2"></i> Thoát hệ thống</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Main Container -->
            <div class="main-container">
                <div class="row">
                    <div class="col-12">
                        <div class="card p-5 text-center">
                            <i class="fa-solid fa-hammer fa-4x text-muted mb-3"></i>
                            <h3 class="fw-bold">Khu vực cấu hình quản trị hệ thống</h3>
                            <p class="text-muted">Tính năng đang trong quá trình phát triển (Under Construction).</p>
                            <div class="mt-4">
                                <button class="btn btn-primary me-2"><i class="fa-solid fa-users"></i> Xem danh sách User</button>
                                <button class="btn btn-outline-danger"><i class="fa-solid fa-triangle-exclamation"></i> Xem log lỗi</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
