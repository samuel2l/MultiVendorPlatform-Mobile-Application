# 📦 MultiVendor Mobile App  

A **multi-vendor eCommerce mobile application** built using **microservices architecture**. The app provides seamless shopping, selling, and notification functionalities with a **scalable and modular backend**.  

---

## 🚀 Features  

### Flutter
- Light/Dark theme
- Provider for state management
- **UI Inspiration**: [DuickiMart Ecommerce App UI Kit](https://www.figma.com/design/0G4rVugudoCzz3qDVIJJbP/DuickiMart-Ecommerce-App-UI-Kit-(Modern-Online-Shopping-Experience---Next-Gen-eCommerce-UI)-(Community)?node-id=181-4668)


### 🔑 Authentication  
- User signup & login  
- Profile editing  

### 🛒 Shopping & Wishlist  
- Add & remove products from cart  
- Add & remove products from wishlist  
- Search products at:  
  - Seller level  
  - Category level  
  - Top level  
- View seller products and profile when viewing product details  

### 💳 Payments & Orders  
- Secure **Stripe** integration for payments  
- Place orders for products  
- View **order details**, including time and products in the order  

### 🔔 Email Notifications  
- Signup confirmation  
- Product updates for items in **cart** or **wishlist**  
- Order placement confirmation  
- Order status changes  

### 🛍️ Seller Features  
- Add new products  
- Edit products (Triggers email notification to users with the product in cart)  
- View sales & update order status:  
  - **On the way**  
  - **Delivered**  
  - **Received** (order received by the shop)  
- Products can have **colors and sizes** depending on the seller’s desires which will be displayed accordingly in the product's details  
- Sellers can also **buy products** like regular users  

---

## 🏗 Microservices Architecture  
The backend consists of the following independent services:  
1. **User Service** – Handles authentication and user profile management  
2. **Shopping Service** – Manages cart, orders, and payments  
3. **Product Service** – Manages product listings and search  
4. **Notification Service** – Handles email & push notifications  

Each service is independently scalable and optimized for performance.  

---

## 📌 Upcoming Features (To-Do)  
- **Live Order Tracking** – Track real-time delivery status  

---

## 🛠 Tech Stack  
- **Frontend:** Flutter  
- **Backend:** Node.js (Microservices)  
- **Database:** MongoDB  
- **Payments:** Stripe  
- **Notifications:** Email & Push  
 

---

