# indeed: tutor matching platform

Full-stack mobile application project for 2024 FSSP.

## 1. Technology Stack

**Frontend**<br>
<img src="https://img.shields.io/badge/dart-0175C2?style=for-the-badge&logo=dart&logoColor=white"><img src="https://img.shields.io/badge/1.21.3-515151?style=for-the-badge">&nbsp;&nbsp;
<img src="https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white"><img src="https://img.shields.io/badge/15.1.7-515151?style=for-the-badge">

**Backend**<br>
<img src="https://img.shields.io/badge/go-00ADD8?style=for-the-badge&logo=go&logoColor=white"><img src="https://img.shields.io/badge/1.21.3-515151?style=for-the-badge">&nbsp;&nbsp;
<img src="https://img.shields.io/badge/grpc-2da6b0?style=for-the-badge&logo=grpc&logoColor=white"><img src="https://img.shields.io/badge/1.21.3-515151?style=for-the-badge">

**Database**<br>
<img src="https://img.shields.io/badge/mongodb-47A248?style=for-the-badge&logo=mongodb&logoColor=white"><img src="https://img.shields.io/badge/8.0.31-515151?style=for-the-badge">


## 2. Getting Started

### Prerequisites

**Frontend**
- Flutter SDK (v15.1.7 or later)
- Dart SDK (v1.21.3 or later)

**Backend**
- Go (v1.19 or later)
- Protocol Buffers compiler
- MongoDB (v8.0.31 or later)
- Evans (optional, for gRPC testing)

### How to Start

1. **Backend Setup**
   ```bash
   # Start MongoDB
   mongod --dbpath <your-db-path>

   # Install dependencies
   cd backend
   go mod download
   go mod tidy

   # Run the backend server
   go run main.go
   ```
   The server will start on port 9090.

2. **Frontend Setup**
   ```bash
   cd frontend
   
   # Install dependencies
   flutter pub get

   # Run the app
   flutter run
   ```
   Select your target device when prompted.

## 3. System Architecture

![Image](https://github.com/user-attachments/assets/0d261c56-cdbc-401d-b766-d3ebb398f57b)

## 3. Demo

You can watch video demo of all the available features here:</br>
[https://www.youtube.com/watch?v=vGuIFKCO9vs](https://youtu.be/vGuIFKCO9vs?si=VZl5tT8zyKzqoOuL&t=533) (Korean), 08:54~12:20

<br>

_This project partially referenced following repository: https://github.com/Djsmk123/Wtf-is-grpc, MIT license._
