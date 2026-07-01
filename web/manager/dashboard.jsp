<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard - Smart Building</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; overflow-x: hidden; }
        .wrapper { display: flex; width: 100%; align-items: stretch; min-height: 100vh; }
        
        /* Sidebar Styling */
        #sidebar { min-width: 260px; max-width: 260px; background: #343a40; color: #fff; transition: all 0.3s; }
        #sidebar .sidebar-header { padding: 20px; background: #212529; border-bottom: 1px solid #4b545c; }
        #sidebar ul.components { padding: 20px 0; }
        #sidebar ul li a { padding: 15px 25px; font-size: 1.05em; display: block; color: #c2c7d0; text-decoration: none; transition: 0.3s; }
        #sidebar ul li a:hover, #sidebar ul li.active > a { color: #fff; background: #495057; border-left: 4px solid #0d6efd; }
        #sidebar ul li a i { width: 30px; text-align: center; margin-right: 10px; font-size: 1.1em; }
        
        /* Content Styling */
        #content { width: 100%; padding: 0; }
        
        /* Top Navbar */
        .top-navbar { background: #fff; padding: 15px 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); display: flex; justify-content: space-between; align-items: center; }
        .user-profile { display: flex; align-items: center; gap: 15px; }
        .avatar { width: 40px; height: 40px; border-radius: 50%; background: #0d6efd; color: white; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1.2rem; }
        
        /* Cards */
        .main-container { padding: 30px; }
        .stat-card { border-radius: 10px; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: transform 0.3s; border-left: 5px solid; }
        .stat-card:hover { transform: translateY(-5px); }
        .card-primary { border-left-color: #0d6efd; }
        .card-danger { border-left-color: #dc3545; }
        .card-warning { border-left-color: #ffc107; }
        .card-success { border-left-color: #198754; }
        .stat-icon { font-size: 2.5rem; opacity: 0.2; position: absolute; right: 20px; top: 25px; }
        
        .table-card { border-radius: 10px; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; }
        .table-card .card-header { background: #fff; border-bottom: 1px solid #eee; padding: 20px; font-weight: 600; color: #212529; }
    </style>
</head>
<body>
    <div class="wrapper">
        <!-- Sidebar -->
        <nav id="sidebar">
            <div class="sidebar-header d-flex align-items-center">
                <i class="fa-solid fa-building-shield fa-2x me-3 text-primary"></i>
                <h4 class="mb-0 fw-bold">Manager Panel</h4>
            </div>
            <ul class="list-unstyled components">
                <li class="active">
                    <a href="#"><i class="fa-solid fa-chart-pie"></i> Thống kê chung</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-clipboard-list"></i> Duyệt yêu cầu cư dân</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-users-gear"></i> Phân công công việc</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-door-open"></i> Quản lý căn hộ</a>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-file-invoice"></i> Quản lý hóa đơn</a>
                </li>
            </ul>
        </nav>

        <!-- Page Content -->
        <div id="content">
            <!-- Topbar -->
            <div class="top-navbar">
                <div class="d-flex align-items-center">
                    <h5 class="mb-0 text-secondary fw-semibold">Dashboard Ban Quản Lý</h5>
                </div>
                <div class="user-profile">
                    <div class="d-flex flex-column text-end">
                        <span class="fw-bold text-dark"><c:out value="${sessionScope.account.fullName}"/></span>
                        <span class="text-muted small"><c:out value="${sessionScope.account.role}"/></span>
                    </div>
                    <div class="avatar shadow-sm"><i class="fa-solid fa-user-tie"></i></div>
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
                
                <h4 class="fw-bold text-dark mb-4">Tổng quan hoạt động</h4>

                <!-- Stat Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-md-3">
                        <div class="card stat-card card-primary p-4 position-relative">
                            <h6 class="text-muted text-uppercase fw-bold mb-2">Tổng số căn hộ</h6>
                            <h3 class="fw-bold text-dark mb-0">450</h3>
                            <span class="text-success small mt-2 d-block"><i class="fa-solid fa-arrow-up"></i> 98% Đã ở</span>
                            <i class="fa-solid fa-city stat-icon text-primary"></i>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card card-warning p-4 position-relative">
                            <h6 class="text-muted text-uppercase fw-bold mb-2">Yêu cầu chờ duyệt</h6>
                            <h3 class="fw-bold text-dark mb-0">15</h3>
                            <span class="text-danger small mt-2 d-block">Cần xử lý gấp</span>
                            <i class="fa-solid fa-envelope-open-text stat-icon text-warning"></i>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card card-danger p-4 position-relative">
                            <h6 class="text-muted text-uppercase fw-bold mb-2">Yêu cầu đang sửa chữa</h6>
                            <h3 class="fw-bold text-dark mb-0">8</h3>
                            <span class="text-muted small mt-2 d-block">Staff đang thực hiện</span>
                            <i class="fa-solid fa-toolbox stat-icon text-danger"></i>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card card-success p-4 position-relative">
                            <h6 class="text-muted text-uppercase fw-bold mb-2">Doanh thu tháng</h6>
                            <h3 class="fw-bold text-dark mb-0">85%</h3>
                            <span class="text-success small mt-2 d-block">Tỷ lệ thu phí</span>
                            <i class="fa-solid fa-sack-dollar stat-icon text-success"></i>
                        </div>
                    </div>
                </div>

                <!-- Action Table -->
                <div class="card table-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span class="fs-5"><i class="fa-solid fa-list-check me-2 text-primary"></i> Yêu cầu sửa chữa mới nhất</span>
                        <button class="btn btn-sm btn-primary">Xem tất cả yêu cầu</button>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4">Mã YC</th>
                                        <th>Căn hộ</th>
                                        <th>Nội dung</th>
                                        <th>Người gửi</th>
                                        <th>Trạng thái</th>
                                        <th class="text-center pe-4">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="ps-4 fw-bold text-primary">#REQ-8021</td>
                                        <td>A-1204</td>
                                        <td>Rò rỉ ống nước nhà vệ sinh</td>
                                        <td>Nguyễn Văn A</td>
                                        <td><span class="badge bg-warning text-dark">Chờ duyệt</span></td>
                                        <td class="text-center pe-4">
                                            <button class="btn btn-sm btn-success me-1" title="Phê duyệt"><i class="fa-solid fa-check"></i></button>
                                            <button class="btn btn-sm btn-danger" title="Từ chối"><i class="fa-solid fa-xmark"></i></button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ps-4 fw-bold text-primary">#REQ-8020</td>
                                        <td>B-0511</td>
                                        <td>Hỏng điều hòa phòng khách</td>
                                        <td>Trần Thị B</td>
                                        <td><span class="badge bg-warning text-dark">Chờ duyệt</span></td>
                                        <td class="text-center pe-4">
                                            <button class="btn btn-sm btn-success me-1" title="Phê duyệt"><i class="fa-solid fa-check"></i></button>
                                            <button class="btn btn-sm btn-danger" title="Từ chối"><i class="fa-solid fa-xmark"></i></button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ps-4 fw-bold text-primary">#REQ-8015</td>
                                        <td>C-2201</td>
                                        <td>Đèn hành lang bị cháy</td>
                                        <td>Lê Văn C</td>
                                        <td><span class="badge bg-info">Đã duyệt - Chờ gán</span></td>
                                        <td class="text-center pe-4">
                                            <button class="btn btn-sm btn-primary"><i class="fa-solid fa-user-plus me-1"></i> Gán việc</button>
                                        </td>
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
