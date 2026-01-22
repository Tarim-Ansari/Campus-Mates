🎓 Campus Mates

Campus Mates is a modern, real-time campus social platform that helps students connect through posts, events, and direct messaging — all in one place.
Built with Flutter and Firebase, it provides a smooth, responsive experience on web and mobile.

🚀 Live MVP

🔗 MVP Link:
👉 https://campus-mates-7ee42.web.app

📽️ Demo Video

🎥 https://drive.google.com/drive/folders/1eQEHFWpFeyVWrI-DVZafiEv4EpFeOdxB

🧩 Problem Statement

Students in colleges often rely on fragmented platforms (WhatsApp groups, notice boards, emails) to:

Share updates

Discover campus events

Communicate with peers

This leads to missed information, poor engagement, and no centralized campus community.

💡 Solution

Campus Mates provides a single unified platform where students can:

Share posts by category (Academics, Sports, Campus Life, etc.)

Like & comment on posts in real time

Chat directly with other students

Discover upcoming campus events

Register for events via external links

✨ Key Features
📝 Posts & Categories

Create posts under specific campus categories

Real-time feed updates

Like ❤️ and comment 💬 on posts

💬 Direct Messaging

One-to-one chat between users

Click on a user’s email to instantly start a conversation

📅 Events

Post and view campus events

Live countdown timer (days, hours, minutes, seconds)

External registration links

🎨 Modern UI/UX

Gradient cards with hover animations

Responsive layout (web + mobile ready)

Clean sidebar navigation

🛠️ Tech Stack
Frontend

Flutter (Web & Android)

Material UI + Custom Gradients

Animations & hover effects

Backend (BaaS)

Firebase Authentication

Cloud Firestore

Firebase Hosting

🧱 Architecture Overview
Flutter UI
   ↓
Post / Event / Chat Services
   ↓
Cloud Firestore (Realtime DB)
   ↓
Firebase Hosting (Web MVP)

📂 Project Structure (Simplified)
lib/
 ├── screens/
 │    ├── home_page.dart
 │    ├── community_page.dart
 │    ├── category_page.dart
 │    ├── events_page.dart
 │    └── comments_page.dart
 │
 ├── widgets/
 │    ├── post_card.dart
 │    ├── event_card.dart
 │    ├── left_sidebar.dart
 │    ├── right_sidebar.dart
 │    └── top_bar.dart
 │
 ├── services/
 │    ├── post_service.dart
 │    ├── event_service.dart
 │    └── authentication.dart
 │
 └── main.dart

🧪 Sample Data

Posts across Academics, Sports, Campus Life, Community

Events with countdown timers

Dummy chats for UI preview

Local images used for offline demo safety

🏆 MVP Scope

This MVP focuses on:

Core campus interactions

Real-time engagement

Clean UX

Scalability via Firebase

Future enhancements:

Group chats

Admin moderation

Push notifications

Profile customization

⚙️ How to Run Locally
flutter pub get
flutter run


For web:

flutter build web
firebase deploy --only hosting

👥 Team

Developer: Tarim Ansari

Project: Campus Mates

Hackathon: HackFinity


⭐ Final Note

Campus Mates is designed to be simple, fast, and student-centric — a digital notice board, social feed, and messaging app combined into one platform.
