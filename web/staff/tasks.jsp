<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Tasks - Smart Building</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; overflow-x: hidden; }
        .wrapper { display: flex; width: 100%; align-items: stretch; min-height: 100vh; }
        
        /* Sidebar Styling */
        #sidebar { min-width: 260px; max-width: 260px; background: #2e4053; color: #fff; transition: all 0.3s; }
        #sidebar .sidebar-header { padding: 20px; background: #212f3d; border-bottom: 1px solid #1c2833; }
        #sidebar ul.components { padding: 20px 0; }
        #sidebar ul li a { padding: 15px 25px; font-size: 1.05em; display: block; color: #d5dbdb; text-decoration: none; transition: 0.3s; }
        #sidebar ul li a:hover, #sidebar ul li.active > a { color: #fff; background: #34495e; border-left: 4px solid #2ecc71; }
        #sidebar ul li a i { width: 30px; text-align: center; margin-right: 10px; font-size: 1.1em; }
        
        /* Content Styling */
        #content { width: 100%; padding: 0; }
        
        /* Top Navbar */
        .top-navbar { background: #fff; padding: 15px 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #2ecc71; }
        .user-profile { display: flex; align-items: center; gap: 15px; }
        .avatar { width: 40px; height: 40px; border-radius: 50%; background: #2ecc71; color: white; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1.2rem; }
        
        /* Main Container */
        .main-container { padding: 30px; }
        .card { border-radius: 10px; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .task-list { list-style: none; padding: 0; margin: 0; }
        .task-list li { padding: 15px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; transition: background 0.3s; }
        .task-list li:hover { background: #fdfefe; }
        .task-list li:last-child { border-bottom: none; }
    </style>
</head>
<body>
    <div class="wrapper">
        <!-- Sidebar -->
        <nav id="sidebar">
            <div class="sidebar-header d-flex align-items-center">
                <i class="fa-solid fa-helmet-safety fa-2x me-3 text-success"></i>
                <h4 class="mb-0 fw-bold">Staff Portal</h4>
            </div>
            <ul class="list-unstyled components">
                <li class="active">
                    <a href="#"><i class="fa-solid fa-list-check"></i> Việc của tôi</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-clock-rotate-left"></i> Lịch sử công việc</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-calendar-days"></i> Lịch trực</a>
                </li>
            </ul>
        </nav>

        <!-- Page Content -->
        <div id="content">
            <!-- Topbar -->
            <div class="top-navbar">
                <div class="d-flex align-items-center">
                    <h5 class="mb-0 text-secondary fw-semibold">Nhiệm Vụ Kỹ Thuật / Vệ Sinh</h5>
                </div>
                <div class="user-profile">
                    <div class="d-flex flex-column text-end">
                        <span class="fw-bold text-dark"><c:out value="${sessionScope.account.fullName}"/></span>
                        <span class="badge bg-success mt-1">Staff</span>
                    </div>
                    <div class="avatar shadow-sm"><i class="fa-solid fa-user-gear"></i></div>
                    <div class="dropdown">
                        <button class="btn btn-link text-dark text-decoration-none dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"></button>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                            <li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Main Container -->
            <div class="main-container">
                <h4 class="mb-4 fw-bold">Danh sách công việc đang chờ xử lý</h4>
                <div class="card">
                    <ul class="task-list">
                        <li>
                            <div>
                                <h6 class="fw-bold mb-1"><i class="fa-solid fa-droplet text-primary me-2"></i>Sửa đường ống nước rò rỉ</h6>
                                <span class="text-muted small"><i class="fa-solid fa-location-dot me-1"></i> Phòng A-1204</span>
                                <span class="badge bg-danger ms-2">Gấp</span>
                            </div>
                            <button class="btn btn-sm btn-outline-success fw-bold"><i class="fa-solid fa-play me-1"></i> Bắt đầu làm</button>
                        </li>
                        <li>
                            <div>
                                <h6 class="fw-bold mb-1"><i class="fa-solid fa-lightbulb text-warning me-2"></i>Thay bóng đèn hành lang tầng 5</h6>
                                <span class="text-muted small"><i class="fa-solid fa-location-dot me-1"></i> Khu C, Tầng 5</span>
                            </div>
                            <button class="btn btn-sm btn-outline-success fw-bold"><i class="fa-solid fa-play me-1"></i> Bắt đầu làm</button>
                        </li>
                        <li>
                            <div>
                                <h6 class="fw-bold mb-1"><i class="fa-solid fa-snowflake text-info me-2"></i>Bảo trì điều hòa định kỳ</h6>
                                <span class="text-muted small"><i class="fa-solid fa-location-dot me-1"></i> Phòng B-0511</span>
                            </div>
                            <button class="btn btn-sm btn-outline-success fw-bold"><i class="fa-solid fa-play me-1"></i> Bắt đầu làm</button>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
