# 📱 Online POS Mobile Application

A mobile **Point of Sale (POS) application** developed using **Flutter** and connected to a **Laravel REST API** backend.

This project was created as a practical project to improve my skills in mobile application development, API integration, database management, and building real-world business applications.

---

## 📌 Project Overview

The Online POS App is designed to help users manage products, create sales orders, manage cart items, and communicate with a backend system through REST APIs.

### 🏗️ Architecture

```text
Flutter Mobile Application
          │
          │ REST API
          ▼
    Laravel Backend
          │
          ▼
      MySQL Database
```

---

## ✨ Features

* 🔐 User Login
* 🏠 Home Dashboard
* 📦 Product Listing
* 🗂️ Product Categories
* 🛒 Shopping Cart
* ➕ Add Products to Cart
* ➖ Update Product Quantity
* ❌ Remove Products from Cart
* 🧾 Order / Sale Management
* 🔗 REST API Integration
* 💾 Local Storage
* 🌐 Multi-language Support
* 📱 Responsive Mobile UI

---

## 🛠️ Technologies Used

### Mobile Application

* Flutter
* Dart
* GetX

### Backend

* Laravel
* REST API
* PHP

### Database

* MySQL

### Tools

* Git
* GitHub
* Android Studio / VS Code
* Postman

---

## 📸 Screenshots

### 🔐 Login

<img width="389" height="865" alt="image" src="https://github.com/user-attachments/assets/4640f8a4-1d95-4669-a75e-eded4f653f75" />



### 🏠 Home

<img width="388" height="866" alt="image" src="https://github.com/user-attachments/assets/363fb352-3de8-4c6e-a7fa-2b7d674102f5" />


### 📦 Products

<img width="388" height="864" alt="image" src="https://github.com/user-attachments/assets/014dcad2-dde4-4cb1-8c3a-0b461c9083c6" />



### 🛒 Shopping Cart

![Cart Screen](screenshots/cart.png)

### 🧾 Sale / Order

<img width="393" height="865" alt="image" src="https://github.com/user-attachments/assets/50a6b79e-8102-4a9d-b15c-0b65b1c0ce16" />


---

## 🔗 API Integration

The Flutter application communicates with the Laravel backend through REST APIs.

Example:

```text
Flutter
   ↓
HTTP Request
   ↓
Laravel REST API
   ↓
MySQL
   ↓
JSON Response
   ↓
Flutter UI
```

---

## 📂 Project Structure

```text
online_pos/
│
├── android/
├── ios/
├── lib/
│   ├── pages/
│   ├── widgets/
│   ├── models/
│   ├── services/
│   ├── repositories/
│   └── main.dart
│
├── assets/
├── screenshots/
│   ├── login.png
│   ├── home.png
│   ├── products.png
│   ├── cart.png
│   └── sale.png
│
├── pubspec.yaml
└── README.md
```

---

## 🚀 How to Run

### 1. Clone the repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

### 2. Open the project

```bash
cd online_pos
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Configure the API

Update the API base URL in the project configuration.

```text
API_BASE_URL = YOUR_API_URL
```

### 5. Run the application

```bash
flutter run
```

---

## 🎯 What I Learned

Through this project, I practiced:

* Building mobile applications with Flutter
* Managing application state with GetX
* Connecting Flutter with REST APIs
* Working with Laravel backend services
* Working with MySQL databases
* Managing cart and order data
* Using local storage
* Building reusable Flutter widgets
* Handling API responses
* Using Git and GitHub for version control

---

## 👨‍💻 Developer

**Bun Sothearak**

Software Development Student
Norton University

Interested in **Software Development, Flutter, Full-Stack Development, and Backend API Development**.

---

## 📌 Project Status

🚧 **Currently improving and adding new features.**
