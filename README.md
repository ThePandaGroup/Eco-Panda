# Eco Panda 🐼

Eco Panda is a Flutter-based mobile application designed to encourage environmentally friendly transportation choices and track users' carbon footprint. The app gamifies eco-friendly travel by rewarding users with points for choosing sustainable transportation options.

## Features

### 🗺️ Route Planning & Navigation
- Plan routes using different transportation modes (Walk, Bicycle, Transit, Drive)
- Real-time navigation with Google Maps integration
- Carbon footprint calculation based on transportation mode
- Earn eco-points for choosing environmentally friendly options

### 📊 Carbon Footprint Tracking
- Monthly carbon footprint history
- Visual representation of historical data through graphs
- Detailed list of past carbon footprint records
- Track and store recent destinations

### 🏆 Challenges & Rewards
- Complete various eco-challenges to earn points
- Different challenge types:
  - Eco-points based challenges
  - Route completion challenges
- Track progress and claim rewards
- View completed challenges

### 📈 Leaderboard System
- Global leaderboard showing top eco-conscious users
- Personal ranking tracking
- Real-time score updates
- Compete with other users

### 👤 User Profile
- Customizable user profiles
- Change username and avatar
- View personal statistics
- Track recent destinations
- View earned eco-points

## Technical Implementation

### Architecture
- Built with Flutter for cross-platform compatibility
- Firebase integration for authentication and cloud functions
- Local SQLite database using Floor ORM
- Provider pattern for state management

### Key Components
- Firebase Authentication for user management
- Cloud Firestore for global leaderboard and challenge data
- Floor Database for local data persistence
- Google Maps API for navigation features
- Real-time location tracking and route calculation

### Data Models
- Person: User profile and statistics
- Challenge: Available eco-challenges
- History: Monthly carbon footprint records
- Destination: Recent travel destinations
- ChallengeStatus: Track completed challenges

### Sync Management
- Bi-directional sync between local and cloud data
- Real-time updates for user scores and rankings
- Offline capability with local data storage

## Getting Started

1. Clone the repository
2. Set up Firebase project and add configuration
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Dependencies
- firebase_core: Firebase integration
- firebase_auth: User authentication
- cloud_firestore: Cloud database
- floor: Local database ORM
- google_maps_flutter: Maps integration
- fl_chart: Data visualization
- provider: State management

## Testing
The project includes integration tests to verify core functionality and user flows. Run tests using:
```bash
flutter test integration_test
```