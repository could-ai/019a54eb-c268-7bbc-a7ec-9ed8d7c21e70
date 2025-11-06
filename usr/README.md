# Tvog Social - Next-Generation Social Media App

![Tvog Social](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)
![Supabase](https://img.shields.io/badge/Backend-Supabase-3ECF8E?logo=supabase)
![License](https://img.shields.io/badge/License-MIT-green)

## 🌟 Overview

Tvog Social is a modern, feature-rich social media application built with Flutter and powered by Supabase. The platform focuses on authentic engagement, smart content sharing, and community building.

## ✨ Features

### Core Features
- 🔐 **Authentication System**
  - Email/Password authentication
  - Social login (Google, Apple)
  - Password recovery
  - Secure session management

- 📱 **Social Feed**
  - Infinite scrolling posts
  - Real-time updates
  - Like, comment, and share functionality
  - Rich media support (images, videos)

- 📖 **Stories**
  - 24-hour ephemeral content
  - Interactive story carousel
  - Create and view stories

- 🔍 **Explore & Discovery**
  - Category-based browsing
  - Trending content
  - Search functionality
  - Smart recommendations

- ✍️ **Content Creation**
  - Post creation with rich text
  - Photo and video uploads
  - Polls and interactive content
  - Location tagging
  - User mentions

- 👤 **User Profiles**
  - Customizable profiles
  - Follower/Following system
  - Post grid view
  - Saved and liked posts

### Technical Features
- 🎨 **Modern UI/UX**
  - Material Design 3
  - Dark/Light theme support
  - Smooth animations
  - Responsive design

- 🔄 **State Management**
  - Provider pattern
  - Efficient state updates
  - Separation of concerns

- 🌐 **Backend Integration**
  - Supabase authentication
  - Real-time database
  - Cloud storage for media
  - Row-level security

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.7.2)
- Dart SDK
- Supabase account
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/tvog-social.git
   cd tvog-social
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Supabase**
   - Create a new project at [supabase.com](https://supabase.com)
   - Copy your project URL and anon key
   - Update `lib/integrations/supabase.dart` with your credentials

4. **Set up database schema**
   - Run the SQL scripts in `supabase/migrations/`
   - Configure storage buckets for avatars and media

5. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── theme/
│   └── app_theme.dart       # Theme configuration
├── screens/
│   ├── splash_screen.dart   # Splash screen
│   ├── onboarding_screen.dart
│   ├── home_screen.dart     # Main feed
│   ├── explore_screen.dart  # Discovery page
│   ├── create_screen.dart   # Content creation
│   ├── profile_screen.dart  # User profile
│   └── auth/
│       ├── login_screen.dart
│       └── signup_screen.dart
├── widgets/
│   ├── post_card.dart       # Post component
│   └── story_carousel.dart  # Stories component
├── providers/
│   ├── auth_provider.dart   # Auth state management
│   ├── post_provider.dart   # Posts state management
│   └── profile_provider.dart
├── models/
│   ├── post_model.dart      # Post data model
│   └── profile_model.dart   # Profile data model
└── integrations/
    └── supabase.dart        # Supabase configuration
```

## 🎨 Design System

### Brand Colors
- **Primary Purple**: `#6C5CE7`
- **Secondary Blue**: `#00B8D4`
- **Accent Pink**: `#FF6B9D`
- **Success Green**: `#00E676`
- **Warning Orange**: `#FFAB00`

### Typography
- Font weights: Regular (400), Medium (500), SemiBold (600), Bold (700)
- Responsive text scaling
- Clear hierarchy

## 🔧 Configuration

### Supabase Setup

1. **Authentication**
   - Enable Email/Password provider
   - Configure OAuth providers (Google, Apple)
   - Set up email templates

2. **Database Tables**
   - `profiles` - User profiles
   - `posts` - User posts
   - `likes` - Post likes
   - `comments` - Post comments
   - `followers` - Follow relationships

3. **Storage Buckets**
   - `avatars` - User profile pictures
   - `posts` - Post media files
   - `stories` - Story media

4. **Row Level Security**
   - Enable RLS on all tables
   - Configure policies for read/write access

## 📦 Dependencies

### Main Dependencies
- `flutter`: SDK
- `supabase_flutter`: ^2.5.6 - Backend integration
- `provider`: ^6.1.2 - State management
- `image_picker`: ^1.0.7 - Image selection
- `cached_network_image`: ^3.3.1 - Image caching
- `file_picker`: ^8.0.0+1 - File selection
- `path_provider`: ^2.1.2 - File paths
- `shimmer`: ^3.0.0 - Loading effects
- `timeago`: ^3.6.1 - Time formatting
- `uuid`: ^4.3.3 - Unique IDs

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📱 Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Supabase for the backend infrastructure
- Material Design team for design guidelines
- Open source community

## 📞 Support

For support, email support@tvogsocial.com or join our community Discord.

## 🗺️ Roadmap

- [ ] Direct messaging
- [ ] Video calls
- [ ] Live streaming
- [ ] Community groups
- [ ] Advanced analytics
- [ ] Content monetization
- [ ] Multi-language support
- [ ] Accessibility improvements

---

**Made with ❤️ by the Tvog Social Team**