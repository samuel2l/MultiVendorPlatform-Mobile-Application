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
- **Complete UI for pop ups**
---

## 🛠 Tech Stack  
- **Frontend:** Flutter  
- **Backend:** Node.js (Microservices)  
- **Database:** MongoDB  
- **Payments:** Stripe  
- **Notifications:** Email & Push  

## 🛠 Running project  
- To be able to run project you need to replace the <your ip address > holder with your ip address inside the constats.dart file
- in the seller/services/seller_service.dart replace the cloudinary keys with yours ie.       final cloudinary = CloudinaryPublic('dvsd4zjxf', 'ztkl4b1w');
- the keys used in this project have been destroyed so you may get some cloudinary error if you do not have your own keys
- the 'dvsd4zjxf' and 'ztkl4b1w' should be from your cloudinary.Get your keys from [cloudinary's website](https://console.cloudinary.com/)
- replace the cloudinary keys in the profile/services/profile_service.dart as well

- follow [Flutter Stripe package docs](https://pub.dev/packages/flutter_stripe) to integrate stripe for android and ios

- in the payments/screen/payments.dart file replace the publishableKey with your stripe publishablae key from the stripe website

- the other services need to be up and running. The steps to run each service are in their readme's

- **Shopping Microservice:**  
  [MultiVendorApp-Products-Microservice](https://github.com/samuel2l/MultivendorPlatform-Shopping-Service)

- **Notification Microservice:**  
  [MultiVendorPlatform-Notification-Microservice](https://github.com/samuel2l/MultiVendorPlatform-Notification-Microservice)

- **Products Microservice:**  
  [MultiVendorApp-Products-Microservice](https://github.com/samuel2l/MultiVendorApp-Products-Microservice)

- **User Microservice:**  
  [MultiVendorApp-User-Service](https://github.com/samuel2l/MultiVendorApp-User-Service)

- **Other related repository**: The web version of this app, designed by [haariswaqas](https://github.com/haariswaqas//MultivendorPlatform-Shopping-Frontend)
---

