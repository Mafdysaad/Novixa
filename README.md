# 🤖 AI Chat Bot

A modern AI chat application built with **Flutter** and powered by the **Google Gemini API**.

The project focuses on clean architecture, state management, dependency injection, API communication, error handling, automatic retry mechanisms, and integration testing.

## ✨ Features

* 💬 AI-powered chat using Google Gemini API
* 🔄 Automatic retry for retryable API errors
* ⚠️ Error handling with user-friendly failure states
* 🔁 Manual retry after all automatic retry attempts fail
* ⏳ Loading state while waiting for AI responses
* 🧩 BLoC/Cubit state management
* 💉 Dependency Injection using GetIt
* 🌐 REST API communication using Dio
* 🧪 Widget and integration testing
* 🛠️ Mock API responses for success and failure scenarios
* 📱 Responsive Flutter UI

## 🏗️ Architecture

The project follows a layered architecture to keep responsibilities separated and make the application easier to maintain and test.

```text
Presentation
    │
    ▼
Cubit / BLoC
    │
    ▼
Repository
    │
    ▼
Gemini Chat Service
    │
    ▼
API Client
    │
    ▼
Dio
    │
    ▼
Gemini API
```

### Main Layers

#### Presentation

Contains:

* Chat screen
* Message input
* AI message bubbles
* User message bubbles
* Error/failure bubbles
* Loading indicators

#### State Management

The application uses **Cubit/BLoC** to manage:

* Sending messages
* Loading states
* Successful AI responses
* API failures
* Retry states

#### Repository

The repository acts as an abstraction between the presentation/business logic and the data layer.

It is responsible for coordinating chat operations and keeping the UI independent from the API implementation.

#### Gemini Service

Handles communication with the Gemini API and contains the retry behavior for retryable failures.

#### API Client

A reusable API client built on top of **Dio**.

It handles HTTP communication and API responses.

## 🔄 Retry Mechanism

The application distinguishes between retryable and non-retryable API errors.

For example, when the API returns a retryable error such as:

```text
429 Too Many Requests
```

the application automatically retries the request.

Example flow:

```text
User sends message
       │
       ▼
   API Request
       │
       ▼
   429 Error
       │
       ▼
 Automatic Retry
       │
       ▼
   API Request
       │
       ├──── Success ────► AI Response
       │
       └──── Failure
                  │
                  ▼
           Retry Attempts
                  │
                  ▼
           Failure State
                  │
                  ▼
          Manual Retry
```

This prevents temporary API failures from immediately being shown as permanent errors to the user.

## 🧪 Testing

The project includes tests for important chat scenarios.

### Successful Request

```text
Send Message
     ↓
API Success
     ↓
AI Response
```

### Automatic Retry Success

```text
Send Message
     ↓
API → 429
     ↓
Automatic Retry
     ↓
API → Success
     ↓
AI Response
```

### Automatic Retry Exhausted

```text
Send Message
     ↓
API → 429
     ↓
Retry
     ↓
API → 429
     ↓
Retry
     ↓
API → 429
     ↓
Failure State
```

### Manual Retry

After all automatic retry attempts fail, the user can manually retry the request from the failure state.

The API client is mocked during testing so different API scenarios can be reproduced without depending on the real Gemini API.

## 🧰 Technologies

| Technology        | Purpose                         |
| ----------------- | ------------------------------- |
| Flutter           | Cross-platform UI               |
| Dart              | Programming language            |
| BLoC / Cubit      | State management                |
| GetIt             | Dependency injection            |
| Dio               | HTTP client                     |
| Google Gemini API | AI responses                    |
| Mocktail          | Mocking dependencies in tests   |
| Flutter Test      | Widget testing                  |
| Integration Test  | End-to-end UI flow testing      |
| Firebase          | Project services where required |

## 📁 Project Structure

```text
lib/
├── core/
│   ├── api/
│   ├── error/
│   ├── network/
│   └── dependency_injection/
│
├── features/
│   └── chat/
│       ├── data/
│       │   ├── models/
│       │   ├── services/
│       │   └── repositories/
│       │
│       ├── presentation/
│       │   ├── cubit/
│       │   ├── screens/
│       │   └── widgets/
│       │
│       └── domain/
│
└── main.dart

test/
└── ...

integration_test/
└── chat/
    └── chat_integration_test.dart
```

> The exact structure may vary depending on the current project implementation.

## 🔐 API Configuration

The application requires a Gemini API key.

For local development, store sensitive configuration outside the source code.

Example:

```text
.env
```

```env
GEMINI_API_KEY=your_api_key_here
```

Make sure sensitive files are included in `.gitignore` and are **not committed to GitHub**.

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/Mafdysaad/Novixa.git
```

### 2. Navigate to the project

```bash
cd Novixa
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Configure the API key

Add your Gemini API configuration according to the project's environment configuration.

### 5. Run the application

```bash
flutter run
```

## 🧪 Running Tests

Run all Flutter tests:

```bash
flutter test
```

Run the integration tests:

```bash
flutter test integration_test/chat/chat_integration_test.dart
```

## 📌 Testing Scenarios

The integration tests cover the main user flow:

```text
Open Chat Screen
      ↓
Enter Message
      ↓
Send Message
      ↓
Show Loading State
      ↓
Receive API Response
      ↓
Display AI Response
```

They also verify failure and retry behavior.

## 🛠️ Development Principles

The project aims to follow:

* Separation of concerns
* Dependency injection
* Repository pattern
* Reusable components
* Testable business logic
* Clear error handling
* Maintainable state management
* Minimal coupling between UI and data sources

## 🔮 Future Improvements

Possible future improvements include:

* Conversation history
* Local message persistence
* Streaming AI responses
* Markdown rendering
* Image and file support
* Voice input
* Improved offline handling
* More comprehensive integration tests
* CI/CD automated testing

## 👨‍💻 Author

**Mafdy Saad**

Flutter Developer focused on cross-platform mobile applications, clean architecture, API integration, and scalable Flutter development.

---

⭐ If you find this project useful, feel free to explore the code and give it a star.
