Perfect 👍
Bas tumhari purani README ko replace karna hai. Neeche **final cleaned README.md** de raha hoon — no extra formatting junk, GitHub-ready, professional.

Copy this whole content and replace your old README.

---

# 🚀 folder_stuture

Flutter Clean Architecture Template
Provider • Dio • GoRouter • Multipart Ready • Production Ready

---

## 📌 Overview

This project follows a **Feature-Based Clean Architecture** with clear separation of concerns:

```
Presentation → Domain → Data → Core
```

Designed to be:

* Scalable
* Modular
* Clone-friendly
* Backend-agnostic
* Production-ready

---

# 🏗 Architecture Layers

## 1️⃣ Presentation Layer

* UI Screens
* Providers (ViewModels)
* Dialog handling
* UI state management

## 2️⃣ Domain Layer

* UseCases
* Repository contracts
* Business logic
* No Flutter/Dio imports

## 3️⃣ Data Layer

* API Sources
* Repository implementations
* Models
* JSON mapping

## 4️⃣ Core Layer

* Network (Dio setup)
* Error handling system
* Storage wrapper
* Shared widgets & dialogs
* Theme & utilities

---

# 📁 Project Structure

```
lib/
│
├── core/
│   ├── bootstrap/
│   ├── constants/
│   ├── error/
│   ├── extensions/
│   ├── logger/
│   ├── network/
│   │   ├── base_api_service.dart
│   │   ├── network_api_service.dart
│   │   ├── interceptors/
│   │   └── multipart_helper.dart
│   ├── permissions/
│   ├── shared/
│   │   ├── dialogs/
│   │   ├── state/
│   │   ├── views/
│   │   └── widgets/
│   ├── storage/
│   ├── theme/
│   └── utils/
│
├── features/
│   ├── auth/
│   ├── branches/
│   └── other_feature/
│
├── routes/
│
├── main_dev.dart
├── main_staging.dart
├── main_prod.dart
└── main_common.dart
```

---

# 🧱 Feature Structure

Each feature must follow:

```
feature_name/
│
├── data/
│   ├── model/
│   ├── repositories/
│   └── sources/
│
├── domain/
│   ├── repositories/
│   └── usecases/
│
└── presentation/
    ├── pages/
    ├── providers/
    └── widgets/
```

---

# 📛 Naming Conventions

### Files

* `auth_model.dart`
* `auth_api.dart`
* `auth_repository.dart`
* `auth_repository_impl.dart`
* `login_usecase.dart`
* `login_vm.dart`

### Classes

* `AuthRepository`
* `AuthRepositoryImpl`
* `LoginUseCase`
* `LoginVM`
* `ServerException`

---

# 🌐 Network Layer Rules

Located in:

```
core/network/
```

### Rules:

* Always return `dynamic`
* No model parsing inside network layer
* JSON → Model mapping happens in RepositoryImpl
* Centralized exception handling
* Supports multipart uploads

---

# 🖼 Multipart Support

Supports:

* Single image
* Multiple images
* Optional image (nullable)
* Text + File together

Used via:

```
MultipartHelper.build(...)
```

Use cases supported:

* Profile update with optional image
* Blog post with multiple images
* Mixed form-data requests

---

# ❗ Error Handling System

Located in:

```
core/error/
```

### Exception Types

* NoInternetException
* ValidationException
* UnauthorizedException
* ServerException
* UnknownException

---

# ⚠ Error Handling Flow

| Layer      | Responsibility     |
| ---------- | ------------------ |
| Repository | Throw AppException |
| UseCase    | Validate & throw   |
| VM         | Catch exception    |
| Dialog     | Show error         |

Never show dialogs inside:

* Repository
* UseCase
* Network layer

VM handles error like:

```dart
try {
  await useCase.execute();
} on AppException catch (e) {
  await AppExceptionHandler.handle(context, e);
}
```

---

# 🔐 Authentication System

* `AuthState` manages login & role
* Role-based routing supported
* Router auto-refresh:

```dart
refreshListenable: Listenable.merge([auth, bootstrap])
```

---

# 💾 Storage

Located in:

```
core/storage/
```

Uses SharedPreferences wrapper.

Must initialize before app start:

```dart
await AppLocalStorage.init();
```

---

# 🧠 Domain Rules

* No Flutter imports
* No Dio imports
* No UI logic
* Only business logic

---

# 🖥 Presentation Rules

* Uses Provider
* Manages UI state
* Shows dialogs
* Calls UseCases

---

# 🚫 Not Allowed

* Dio inside ViewModel
* Navigator inside Repository
* UI inside Domain
* Direct SharedPreferences inside Feature

---

# 🔄 New Feature Checklist

1. Create feature folder
2. Add data/domain/presentation layers
3. Add routes
4. Register providers
5. Done

No core modification required.

---

# 🔄 Clone Workflow

To create a new project from this template:

1. Change Base URL
2. Replace Models
3. Update Endpoints
4. Update Routes
5. Build UI

Everything else remains unchanged.

---

# 📈 Supported Capabilities

* JSON APIs
* Multipart uploads
* Optional images
* Role-based routing
* Environment configs
* Modular features
* Centralized error handling
* Provider state management

---

# 🏁 Status

✔ Clean Architecture
✔ Modular
✔ Scalable
✔ Clone-Friendly
✔ Production Ready
