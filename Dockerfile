# Sử dụng Python base image
FROM python:3.12

# Đặt thư mục làm việc trong container
WORKDIR /app

# Sao chép file yêu cầu (requirements.txt) vào container
COPY requirements.txt /app/

# Cài đặt các dependencies từ requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Sao chép toàn bộ source code vào container
COPY . /app/

# Thiết lập biến môi trường để Django hoạt động đúng
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Chạy lệnh collectstatic của Django (nếu có sử dụng static files)
RUN python manage.py collectstatic --noinput

# Mở port 8000 để có thể truy cập vào ứng dụng Django
EXPOSE 8000

# Lệnh để khởi động server Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
