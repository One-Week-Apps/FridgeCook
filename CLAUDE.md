# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**FridgeCook** is a Flutter app demonstrating Clean Architecture and TDD principles. It lets users scan ingredients and get recipe suggestions based on what they have available, powered by OpenAI APIs for product identification and recipe generation.

## Common Development Commands

### Building & Running
```bash
# Get dependencies
flutter pub get

# Run the app (default to iOS simulator)
flutter run

# Run on Android emulator
flutter run -d <device_id>

# Run with debug mode (hot reload enabled)
flutter run -v

# Build release APK (Android)
flutter build apk --release

# Build release iOS app
flutter build ios --release
```

### Testing
```bash
# Run all tests
flutter test

# Run a specific test file
flutter test test/add_product_usecase_test.dart

# Run tests with coverage
flutter test --coverage

# Run tests in verbose mode
flutter test -v
```

### Code Quality & Linting
```bash
# Analyze code for issues
flutter analyze

# Format code
dart format lib/ test/

# Format with line length
dart format --line-length 100 lib/ test/
```

### Utilities
```bash
# Generate app icons (updates iOS and Android icons from assets/icon/icon.png)
flutter pub run flutter_launcher_icons:main

# Clean build artifacts
flutter clean

# Get pubspec updates
flutter pub upgrade
```

## Architecture Overview

FridgeCook uses **Clean Architecture** with strict layer separation:

```
Presentation (app/) → Domain (domain/) → Data (data/)
```

### Layer Responsibilities

**Presentation Layer (lib/src/app/)**
- Contains all UI screens (pages) and reusable widgets
- Uses MVC pattern: Controller + Presenter + View
- Controllers manage state and orchestrate navigation
- Presenters execute use cases and handle responses via observer pattern
- Views are stateless and rebuild when controller state changes
- Notable pages:
  - `onboarding/` - Tutorial flow shown on first launch
  - `products_listing/` - Manage ingredients with add/edit/delete
  - `recipes_listing/` - Display AI-generated recipes
  - `recipes_details/` - Recipe details with image, ingredients, directions

**Domain Layer (lib/src/domain/)**
- Pure business logic, framework-agnostic
- Abstract repository interfaces define data contracts
- Use cases orchestrate business operations
- Entities define core business objects (Product, Recipe, ProductCategory)
- OpenAI API contracts (CompletionsAPI, CreateImageAPI) abstract external services
- All use cases extend `UseCase<Response, Params>` from flutter_clean_architecture

**Data Layer (lib/src/data/)**
- Implements domain repository interfaces
- Multiple implementations per interface (in-memory, remote, persisted):
  - `in_memory_*` - For development/testing without network calls
  - `remote_*` - For OpenAI API calls
  - `shared_*` - For SharedPreferences persistence
  - `data_*` - Composite implementations that orchestrate the above
- External integrations: OpenAI API (recipes, product IDs, images), SharedPreferences (local storage)

### Key Design Patterns

**Observer Pattern**: Use cases emit responses via StreamController. Presenters observe these streams and notify controllers, which trigger UI rebuilds.

**Strategy Pattern**: Multiple repository implementations (in-memory, remote, persisted) allow flexible switching between live APIs, mocks, and cached data.

**Repository Pattern**: Abstract repositories in domain layer decouple business logic from data source implementation.

## Important Files & Concepts

### Core Entity Models
- `domain/entities/product.dart` - Product with name, quantity, category, image; JSON serializable
- `domain/entities/recipe.dart` - Recipe with name, ingredients, directions, generated image
- `domain/entities/product_category.dart` - Enum-like categories for filtering

### Use Cases
Each represents a business operation:
- `AddProductUseCase` - Checks if product exists, fetches details via ProductFetcher if new, adds to repository
- `DeleteProductUseCase` - Removes or decrements product quantity
- `GetAllProductsUseCase` - Retrieves limited product list
- `GetAllRecipesUseCase` - Generates recipes from OpenAI based on available products
- `GetAllCategoriesUseCase` - Returns available product categories

### Controllers (State Management)
Located in page folders alongside presenters and views:
- Extend `Controller` from flutter_clean_architecture
- Hold filtered/displayed data (e.g., products list, recipes list)
- Call presenter methods in response to user actions
- Implement callbacks (e.g., `addProductOnNext`, `deleteProductOnNext`) to handle presenter responses
- Call `refreshUI()` to trigger view rebuild

### Presenters
Located alongside controllers:
- Extend `Presenter` from flutter_clean_architecture
- Initialize dependencies and create use case observers in constructor
- Execute use cases and pass results to controller callbacks
- Implement observer methods to handle use case responses

### Key Dependencies
- `flutter_clean_architecture: ^5.0.3` - Clean architecture framework with Controller/Presenter base classes
- `http: ^0.13.0` - HTTP requests to OpenAI
- `shared_preferences: ^2.0.15` - Local data persistence
- `cached_network_image: ^3.2.3` - Network image caching
- `oktoast: ^3.3.1` - Toast notifications
- `lottie: ^2.1.0` - Animations

## Workflow: Adding a Product

This illustrates how the layers interact:

1. User enters product name in products_listing view
2. Controller `addProduct()` called → calls `presenter.addProduct(name)`
3. Presenter creates `AddProductUseCase` observer and executes use case
4. Use case checks if product exists in `ProductsRepository`
   - If exists: updates quantity
   - If not: calls `ProductFetcher.fetchProduct()` to get details (category, image from OpenAI), then adds to repository
5. Use case emits response to observer
6. Presenter receives response via `addProductOnNext()` callback
7. Presenter calls controller callback (e.g., `controller.addProductOnNext()`)
8. Controller updates internal products list and calls `refreshUI()`
9. View rebuilds, displaying updated products list

## Testing Strategy

Tests are located in `/test` directory. Use `flutter test` to run.

Test files mirror use case structure:
- `add_product_usecase_test.dart` - Tests AddProductUseCase with mocked repositories
- `delete_product_usecase_test.dart` - Tests DeleteProductUseCase
- `get_all_recipes_usecase_test.dart` - Tests recipe generation with mocked OpenAI responses
- `completions_request_formatter_test.dart` - Tests prompt formatting
- `completions_response_formatter_test.dart` - Tests response parsing

Mocking uses `mockito: ^5.2.0` package.

## Key Implementation Notes

### Onboarding Flow
- Checked on app startup in `main.dart` via SharedPreferences `tutorialCompleted` key
- Routes to onboarding page if not completed
- Onboarding pages demonstrate: scanning, ingredient listing, recipe listing, recipe details
- Persists completion state when user finishes

### Product Management
- Quantity range: 1-9 (handled in UI)
- Categories: Vegetables, Meat, Fish, Dairy, Fruits, Drinks, Cereals, Sugar, Food
- Filter UI allows selecting single category
- Products cached in SharedPreferences for offline access

### Recipe Generation
- Uses OpenAI GPT API (completions endpoint) with product list context
- Generates recipe images via DALL-E API (create_image endpoint)
- Recipe response is HTML, parsed via `html` package
- Recipes filtered to only include those using available products

### SharedPreferences Keys
- `tutorialCompleted` - Boolean indicating if onboarding shown
- Additional keys managed in `SharedPref.dart`

## File Structure Quick Reference

```
lib/src/
├── app/                          # Presentation Layer
│   ├── pages/                    # Each page has Controller, Presenter, View
│   │   ├── onboarding/
│   │   ├── products_listing/
│   │   ├── recipes_listing/
│   │   └── recipes_details/
│   └── widgets/                  # Reusable UI components
├── domain/                       # Business Logic (Pure Dart)
│   ├── entities/                 # Core models
│   ├── repositories/             # Abstract interfaces
│   ├── usecases/                 # Business operations
│   └── repositories/openai/      # OpenAI API contracts
└── data/                         # Data Implementations
    └── repositories/             # Concrete repository implementations
```

## Debugging Tips

- Use `flutter run -v` for verbose output showing hot reload and framework events
- Controllers and Presenters live in page folders alongside views
- Use `debugPrint()` in domain/data layers to avoid framework dependencies
- Check SharedPreferences via Android Studio/Xcode device file explorer or use `flutter run -v` logs
- OpenAI API responses logged in `remote_recipes_repository.dart` and `remote_product_fetcher.dart`
