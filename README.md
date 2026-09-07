# HCMUTE Shop — Servlet/JSP/JPA

HCMUTE Shop là project bài tập Jakarta Servlet chạy trên Tomcat 10.1, sử dụng JSP/JSTL, JPA (Hibernate), SQL Server và SiteMesh 3.

## Chức năng đã có

- Cấu hình và CRUD Category bằng JPA.
- Đăng ký tài khoản, gửi và xác nhận OTP qua email.
- Đăng nhập bằng `HttpSession`, tùy chọn ghi nhớ tên đăng nhập bằng `Cookie`.
- Quên mật khẩu, xác nhận OTP và đặt mật khẩu mới.
- Mật khẩu lưu bằng PBKDF2, không lưu mật khẩu mới dưới dạng văn bản thuần.
- Profile cập nhật fullname, phone và ảnh bằng Multipart/JPA.
- Quan hệ `Category 1 - n Product`.
- CRUD Product có validation và upload ảnh Multipart.
- Trang chủ hiển thị tối đa 10 sản phẩm mới nhất.
- `/product` hiển thị toàn bộ sản phẩm, phân trang đúng 6 sản phẩm/trang.
- `/product/detail?id=...` hiển thị chi tiết sản phẩm.
- SiteMesh 3 với giao diện cửa hàng và giao diện quản trị responsive.
- Hai chế độ sáng/tối, tự nhận theme hệ thống và ghi nhớ lựa chọn trên trình duyệt.

## Chạy project

1. Tạo database SQL Server tên `jakartaJPA` hoặc chỉnh kết nối trong `src/main/resources/META-INF/persistence.xml`.
2. Có thể chạy `database/schema.sql`; nếu không, Hibernate `hbm2ddl.auto=update` sẽ tự tạo/cập nhật bảng.
3. Import project Maven vào Eclipse/STS, chọn JDK 17 và Apache Tomcat 10.1.
4. Maven Update Project để tải dependencies, sau đó Run on Server.
5. Mở `http://localhost:8080/btvnshopping/`.

Cấu hình kết nối SQL Server bằng biến môi trường trước khi chạy:

```powershell
$env:DB_URL="jdbc:sqlserver://localhost:1433;databaseName=jakartaJPA;encrypt=true;trustServerCertificate=true"
$env:DB_USERNAME="sa"
$env:DB_PASSWORD="your-local-sqlserver-password"
$env:ADMIN_DEFAULT_PASSWORD="choose-a-local-admin-password"
```

Tài khoản quản trị mặc định được tạo khi mở trang đăng nhập lần đầu nếu đã cấu hình `ADMIN_DEFAULT_PASSWORD`:

```text
username: admin
password: giá trị của ADMIN_DEFAULT_PASSWORD
```

## Cấu hình gửi OTP email

Ứng dụng đọc cấu hình SMTP từ biến môi trường, không lưu mật khẩu email trong Git:

```powershell
$env:SMTP_HOST="smtp.gmail.com"
$env:SMTP_PORT="587"
$env:SMTP_USERNAME="your-email@gmail.com"
$env:SMTP_PASSWORD="your-google-app-password"
$env:SMTP_FROM="your-email@gmail.com"
```

Nếu chạy bằng Eclipse/STS, hãy cấu hình các biến này trong Run Configuration của Tomcat hoặc thiết lập biến môi trường hệ thống rồi khởi động lại IDE. Với Gmail, `SMTP_PASSWORD` phải là App Password, không phải mật khẩu Gmail thông thường.

Khi SMTP chưa cấu hình hoặc gửi mail lỗi, trang OTP hiển thị mã demo để vẫn kiểm thử được toàn bộ luồng tại lớp học. Khi SMTP hoạt động, mã demo tự động bị ẩn.

## Upload ảnh

Mặc định ảnh được lưu ở `${user.home}/btvnshopping-uploads`. Có thể đổi thư mục bằng biến môi trường:

```powershell
$env:SHOPPING_UPLOAD_DIR="D:\uploads"
```

Các định dạng hỗ trợ: JPG, JPEG, PNG, GIF, WEBP; giới hạn 10MB.

## URL chính

- `/home`: trang chủ, 10 sản phẩm mới nhất.
- `/product`: tất cả sản phẩm, 6 sản phẩm/trang.
- `/login`, `/register`, `/forgot-password`: xác thực tài khoản.
- `/profile`: cập nhật hồ sơ người dùng.
- `/admin/dashboard`: bảng điều khiển quản trị.
- `/admin/products`: CRUD sản phẩm.
- `/admin/categories`: CRUD danh mục.

## Trước khi nộp

Không commit mật khẩu SQL Server, SMTP App Password hoặc thư mục upload. Kiểm tra lại thông tin database, chạy đủ các luồng trên Tomcat, sau đó commit và push lên repository GitHub của bạn.
