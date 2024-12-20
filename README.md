

---

# **ERP Frontend Application**

This document provides a detailed overview of the Flutter-based frontend for the ERP application. It outlines the features, implementation details, and navigation.

---

## **Overview**

The Flutter application serves as the frontend for an ERP system, providing distinct interfaces for **Users**, **Vendors**, and **Admins**. The app uses **Riverpod** for state management, **CachedNetworkImage** for efficient image loading, and is structured using the **MVVM architecture**.

---
## **FLows of all USER, ADMIN, VENDOR
https://github.com/user-attachments/assets/4964cd1a-a363-4cd9-b14b-2748d5432ebf

https://github.com/user-attachments/assets/2fef71d4-f7f3-471f-b647-c84f8d1ca2c8

https://github.com/user-attachments/assets/e511d91d-b4ea-42c5-be2a-9de28e596a48

---

## **Key Features**

### **User Interface**
- **Sign-In** and **Sign-Up** screens for Users, Vendors, and Admins.
- Role-specific dashboards:
  - User Home Page
  - Vendor Dashboard
  - Admin Dashboard

### **State Management**
- **Riverpod** for managing application state (e.g., cart, product lists).
- Dynamic UI updates without overloading the app.

### **User Flow**
- View products by category (Catering, Florist, Decoration, Lighting).
- Add products to a cart and manage the cart (increment, decrement, remove items).
- Place orders and view order status.
- Manage a guest list (add, update, delete).

### **Vendor Flow**
- Add, update, and delete products.
- View transactions for products.
- Manage a list of products with real-time image updates using **ImagePicker**.

### **Admin Flow**
- Manage users and vendors:
  - Add, update, and delete users and vendors.
  - Manage memberships for users and vendors.

### **Optimized Image Handling**
- Image uploading for vendors using **ImagePicker**.
- Cached image loading with **CachedNetworkImage**.

---

## **Architecture**

### **Directory Structure**
```plaintext
lib/
├── config/
├── data/
├── models/
├── repositories/
├── utils/
├── views/
│   ├── authentication/
│   │   ├── admin_signup_view.dart
│   │   ├── sign_in_view.dart
│   │   ├── user_signup_view.dart
│   │   ├── vendor_signup_view.dart
│   ├── admin/
│   │   ├── admin_home_page.dart
│   │   ├── maintain_user_page.dart
│   │   ├── maintain_vendor_page.dart
│   ├── user/
│   │   ├── user_home_screen.dart
│   │   ├── cart_screen.dart
│   │   ├── guest_list_screen.dart
│   │   ├── order_status_screen.dart
│   ├── vendor/
│   │   ├── vendor_home_page.dart
│   │   ├── add_new_item_page.dart
│   │   ├── your_item_page.dart
│   │   ├── transaction_page.dart
└── view_models/
```

### **State Management**
- **Providers**:
  - `selectedCategoryProvider`: Manages selected categories.
  - `cartProvider`: Manages cart items.
  - `productProvider`: Manages product data for vendors.

### **Navigation**
- **Bottom Navigation Bar**:
  - Implemented for User, Vendor, and Admin dashboards for intuitive navigation.
- **Role-Based Navigation**:
  - Dropdown on the Sign-In page to simulate role-based access.

---

## **Implemented Pages**

### **Authentication**
- **Sign-In Page**:
  - Allows users to select their role (User, Vendor, Admin) and navigate to the respective home page.
- **Sign-Up Pages**:
  - Separate sign-up screens for Users, Vendors, and Admins.

### **User Pages**
1. **Home Page**:
   - View vendors by category.
   - Navigate to Cart, Guest List, and Order Status pages.

2. **Cart Page**:
   - Add, update, and remove items dynamically.
   - View grand total and proceed to checkout.

3. **Guest List Page**:
   - Add, update, and delete guest entries.

4. **Order Status Page**:
   - View order history and statuses.

### **Vendor Pages**
1. **Dashboard**:
   - Bottom navigation with options for products, transactions, and logout.

2. **Your Items Page**:
   - List all products added by the vendor.
   - Edit or delete products.

3. **Add New Item Page**:
   - Add products with details (name, price, image).

4. **Transaction Page**:
   - View transaction history for sold products.

### **Admin Pages**
1. **Admin Dashboard**:
   - Options for user and vendor management.

2. **Maintain User Page**:
   - List all users.
   - Add, update, or delete user entries.
   - Manage memberships.

3. **Maintain Vendor Page**:
   - List all vendors.
   - Add, update, or delete vendor entries.
   - Manage memberships.

---

## **Navigation Flow**

1. **Authentication Flow**:
   - Sign-In -> Role Selection -> Navigate to Home Page.

2. **User Flow**:
   - Home Page -> View Products by Category -> Add to Cart -> Checkout -> Order Status.

3. **Vendor Flow**:
   - Vendor Dashboard -> Add Products -> View/Edit/Delete Products -> Transactions.

4. **Admin Flow**:
   - Admin Dashboard -> Maintain Users/Vendors -> Add/Update/Delete Entries.

---

## **Sample Data**

### **User Accounts**
- `john.doe@example.com`
- `jane.doe@example.com`

### **Vendor Accounts**
- Vendor 1 (Catering)
- Vendor 2 (Florist)

### **Admin Accounts**
- `admin@example.com`

### **Products**
- **Catering**:
  - Buffet Service: $199.99
  - Event Catering: $299.99
- **Florist**:
  - Rose Bouquet: $49.99
  - Wedding Flowers: $89.99

---

