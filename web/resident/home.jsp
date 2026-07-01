<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cổng Cư Dân - Smart Building</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f6; overflow-x: hidden; }
        .wrapper { display: flex; width: 100%; align-items: stretch; min-height: 100vh; }
        
        /* Sidebar Styling */
        #sidebar { min-width: 260px; max-width: 260px; background: #2b3a4a; color: #fff; transition: all 0.3s; }
        #sidebar .sidebar-header { padding: 20px; background: #1d2834; border-bottom: 1px solid #3c4f62; }
        #sidebar ul.components { padding: 20px 0; }
        #sidebar ul li a { padding: 15px 25px; font-size: 1.05em; display: block; color: #b8c7ce; text-decoration: none; transition: 0.3s; }
        #sidebar ul li a:hover, #sidebar ul li.active > a { color: #fff; background: #3c4f62; border-left: 4px solid #1abc9c; }
        #sidebar ul li a i { width: 30px; text-align: center; margin-right: 10px; font-size: 1.1em; }
        
        /* Content Styling */
        #content { width: 100%; padding: 0; }
        
        /* Top Navbar */
        .top-navbar { background: #fff; padding: 15px 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); display: flex; justify-content: space-between; align-items: center; }
        .user-profile { display: flex; align-items: center; gap: 15px; }
        .avatar { width: 40px; height: 40px; border-radius: 50%; background: #1abc9c; color: white; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1.2rem; }
        
        /* Cards */
        .main-container { padding: 30px; }
        .stat-card { border-radius: 10px; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: transform 0.3s; border-left: 5px solid; }
        .stat-card:hover { transform: translateY(-5px); }
        .card-orange { border-left-color: #f39c12; }
        .card-green { border-left-color: #1abc9c; }
        .card-blue { border-left-color: #3498db; }
        .stat-icon { font-size: 2.5rem; opacity: 0.2; position: absolute; right: 20px; top: 25px; }
        
        .table-card { border-radius: 10px; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; }
        .table-card .card-header { background: #fff; border-bottom: 1px solid #eee; padding: 20px; font-weight: 600; color: #2c3e50; }
    </style>
</head>
<body>
    <div class="wrapper">
        <!-- Sidebar -->
        <nav id="sidebar">
            <div class="sidebar-header d-flex align-items-center">
                <i class="fa-solid fa-building fa-2x me-3 text-info"></i>
                <h4 class="mb-0 fw-bold">Resident Portal</h4>
            </div>
            <ul class="list-unstyled components">
                <li class="active">
                    <a href="#"><i class="fa-solid fa-house"></i> Tổng quan</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-file-invoice-dollar"></i> Hóa đơn dịch vụ</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-wrench"></i> Đăng ký sửa chữa</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-truck-moving"></i> Đăng ký chuyển đồ</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-motorcycle"></i> Đăng ký gửi xe</a>
                </li>
            </ul>
        </nav>

        <!-- Page Content -->
        <div id="content">
            <!-- Topbar -->
            <div class="top-navbar">
                <div class="d-flex align-items-center">
                    <h5 class="mb-0 text-secondary fw-semibold">Dashboard Cư Dân</h5>
                </div>
                <div class="user-profile">
                    <div class="d-flex flex-column text-end">
                        <span class="fw-bold text-dark"><c:out value="${sessionScope.account.fullName}"/></span>
                        <span class="text-muted small"><c:out value="${sessionScope.account.role}"/></span>
                    </div>
                    <div class="avatar shadow-sm"><i class="fa-solid fa-user"></i></div>
                    <div class="dropdown">
                        <button class="btn btn-link text-dark text-decoration-none dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"></button>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                            <li><a class="dropdown-item" href="#"><i class="fa-solid fa-id-card me-2"></i> Hồ sơ</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Main Container -->
            <div class="main-container">
                <!-- Welcome Banner -->
                <div class="alert alert-info border-0 shadow-sm rounded-3 mb-4 d-flex align-items-center">
                    <i class="fa-solid fa-bullhorn fa-2x me-3 text-info"></i>
                    <div>
                        <h5 class="alert-heading fw-bold mb-1">Xin chào, <c:out value="${sessionScope.account.fullName}"/>!</h5>
                        <p class="mb-0">Chúc bạn một ngày tốt lành. Dưới đây là tóm tắt tình hình căn hộ của bạn.</p>
                    </div>
                </div>

                <!-- Stat Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-md-4">
                        <div class="card stat-card card-orange p-4 position-relative">
                            <h6 class="text-muted text-uppercase fw-bold mb-2">Phí Tháng Này</h6>
                            <h3 class="fw-bold text-dark mb-0">1,250,000 VNĐ</h3>
                            <span class="badge bg-warning text-dark mt-2" style="width:fit-content">Chưa thanh toán</span>
                            <i class="fa-solid fa-money-bill-wave stat-icon text-warning"></i>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card card-blue p-4 position-relative">
                            <h6 class="text-muted text-uppercase fw-bold mb-2">Yêu Cầu Sửa Chữa</h6>
                            <h3 class="fw-bold text-dark mb-0">2 Yêu cầu</h3>
                            <span class="badge bg-info mt-2" style="width:fit-content">Đang chờ xử lý</span>
                            <i class="fa-solid fa-screwdriver-wrench stat-icon text-info"></i>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card card-green p-4 position-relative">
                            <h6 class="text-muted text-uppercase fw-bold mb-2">Hóa Đơn Đã Đóng</h6>
                            <h3 class="fw-bold text-dark mb-0">12 Hóa đơn</h3>
                            <span class="badge bg-success mt-2" style="width:fit-content">Đúng hạn</span>
                            <i class="fa-solid fa-check-circle stat-icon text-success"></i>
                        </div>
                    </div>
                </div>

                <!-- Notifications Table -->
                <div class="card table-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span class="fs-5"><i class="fa-regular fa-bell me-2 text-warning"></i> Thông báo mới nhất từ Ban Quản Lý</span>
                        <button class="btn btn-sm btn-outline-secondary">Xem tất cả</button>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4">Ngày</th>
                                        <th>Tiêu đề</th>
                                        <th>Loại thông báo</th>
                                        <th class="text-end pe-4">Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="ps-4 text-muted">02/07/2026</td>
                                        <td class="fw-semibold">Thông báo bảo trì hệ thống thang máy khu A</td>
                                        <td><span class="badge bg-danger bg-opacity-10 text-danger border border-danger">Bảo trì</span></td>
                                        <td class="text-end pe-4"><span class="badge rounded-pill bg-danger">Mới</span></td>
                                    </tr>
                                    <tr>
                                        <td class="ps-4 text-muted">28/06/2026</td>
                                        <td class="fw-semibold">Lịch đóng phí quản lý tháng 7/2026</td>
                                        <td><span class="badge bg-primary bg-opacity-10 text-primary border border-primary">Tài chính</span></td>
                                        <td class="text-end pe-4"><span class="text-muted small">Đã đọc</span></td>
                                    </tr>
                                    <tr>
                                        <td class="ps-4 text-muted">15/06/2026</td>
                                        <td class="fw-semibold">Tổ chức lễ hội mùa hè cho trẻ em tại sảnh chính</td>
                                        <td><span class="badge bg-success bg-opacity-10 text-success border border-success">Sự kiện</span></td>
                                        <td class="text-end pe-4"><span class="text-muted small">Đã đọc</span></td>
                                    </tr>
                                </tbody>
                            </table>
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
