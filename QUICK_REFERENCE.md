# Quick Reference Guide - GifX Components

## 🚀 Quick Start

### Import Widgets
```dart
import 'package:gifx/app/views/widgets/index.dart';
```

### Import Theme & Colors
```dart
import 'package:gifx/config/theme/app_text_styles.dart';
import 'package:gifx/constants/colors.dart';
```

---

## 📋 Common Patterns

### 1. Screen dengan Glassmorphic Container
```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Page'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GlassmorphicContainer(
                child: Text('Content Here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 2. Form dengan Custom Buttons & TextFields
```dart
Column(
  children: [
    // Email text field
    CustomTextField(
      label: 'Email',
      hint: 'Enter email',
      type: TextFieldType.email,
      prefixIcon: 'email',
      validator: (value) {
        if (value?.isEmpty ?? true) return 'Email is required';
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
          return 'Invalid email';
        }
        return null;
      },
    ),
    const SizedBox(height: 16),
    
    // Password text field
    CustomTextField(
      label: 'Password',
      hint: 'Enter password',
      type: TextFieldType.password,
      prefixIcon: 'lock',
      minLength: 8,
      validator: (value) {
        if (value?.isEmpty ?? true) return 'Password required';
        if (value!.length < 8) return 'Min 8 chars';
        return null;
      },
    ),
    const SizedBox(height: 16),
    
    // Submit button
    CustomElevatedButton(
      label: 'Login',
      onPressed: () {},
      width: double.infinity,
      height: 48,
    ),
  ],
)
```

### 3. List dengan Custom Cards
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return GlassmorphicContainer(
      borderRadius: 16,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      child: ListTile(
        title: Text(
          items[index].title,
          style: AppTextStyles.titleMedium,
        ),
        subtitle: Text(
          items[index].description,
          style: AppTextStyles.bodySmall,
        ),
      ),
    );
  },
)
```

### 4. Reactive State Management
```dart
import 'package:get/get.dart';
import 'package:gifx/config/theme/app_text_styles.dart';

class MyController extends GetxController {
  final Rx<String> username = ''.obs;
  
  void updateUsername(String name) {
    username.value = name;
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyController());
    
    return Column(
      children: [
        Obx(() => Text(
          'Hello ${controller.username.value}',
          style: AppTextStyles.titleLarge,
        )),
        TextField(
          onChanged: controller.updateUsername,
        ),
      ],
    );
  }
}
```

---

## 🎨 Theme Switching Example

```dart
import 'package:get/get.dart';
import 'package:gifx/app/controllers/theme_controller.dart';

// In AppBar
Obx(() {
  final themeController = Get.find<ThemeController>();
  return CustomIconButton(
    icon: themeController.isDarkMode 
      ? Icons.light_mode 
      : Icons.dark_mode,
    onPressed: themeController.toggleTheme,
  );
})
```

---

## � System UI Overlay (Status Bar & Nav Bar)

### Automatic Theme-Aware Colors
Status bar dan bottom navigation bar otomatis menyesuaikan dengan theme:

```dart
// Light Mode
// ✅ Status Bar: Gold (#D4AF37) dengan dark icons
// ✅ Bottom Nav: Light background dengan dark icons

// Dark Mode  
// ✅ Status Bar: Dark gray (#1F1F1F) dengan light icons
// ✅ Bottom Nav: Very dark (#121212) dengan light icons
```

### Responsive Page with AnnotatedRegion
```dart
import 'package:gifx/app/views/widgets/theme_annotated_region.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ThemeAnnotatedRegion(
      isDarkMode: isDark,
      child: Scaffold(
        appBar: AppBar(title: Text('My Page')),
        body: Container(
          color: isDark ? Colors.black : Colors.white,
          child: Center(child: Text('Content')),
        ),
      ),
    );
  }
}
```

### Custom Status/Nav Bar Colors
```dart
ThemeAnnotatedRegion(
  isDarkMode: isDark,
  customStatusBarColor: Colors.blue,
  customNavBarColor: Colors.blueAccent,
  child: Scaffold(...),
)
```

### Automatic Switching (Main.dart)
Main.dart sudah setup dengan reactive `AnnotatedRegion`:
- ✅ Saat user toggle theme, status bar & nav bar otomatis berubah
- ✅ Tidak perlu manual `SystemChrome.setSystemUIOverlayStyle()`
- ✅ Sinkron dengan page background color

**See**: [SYSTEM_UI_GUIDE.md](SYSTEM_UI_GUIDE.md) for detailed documentation

---

## �🌍 Multi-Language Example

```dart
import 'package:get/get.dart';
import 'package:gifx/config/localization/localization_service.dart';

// Using translations
Text('hello'.tr) // Automatically translated

// Change language
LocalizationService.changeLocale('id'); // Indonesian
LocalizationService.changeLocale('en'); // English

// Add new translation in app_translations.dart
const Map<String, Map<String, String>> translations = {
  'id': {
    'new_key': 'Nilai Indonesia',
  },
  'en': {
    'new_key': 'English Value',
  },
};
```

---

## 🎯 Custom TextField Cheatsheet

### Quick Setup
```dart
// Email field
CustomTextField(
  label: 'Email',
  hint: 'Enter email',
  type: TextFieldType.email,
  prefixIcon: 'email',
  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
)

// Password field
CustomTextField(
  label: 'Password',
  hint: 'Enter password',
  type: TextFieldType.password,
  prefixIcon: 'lock',
  minLength: 8,
)

// Number field (currency)
CustomTextField(
  label: 'Amount',
  hint: 'Enter amount',
  type: TextFieldType.number,
  currencyFormat: CurrencyFormat.IDR,
)

// Descriptive field
CustomTextField(
  label: 'Description',
  hint: 'Write here...',
  type: TextFieldType.descriptive,
  maxLines: 5,
  maxLength: 500,
)
```

**See**: [TEXTFIELD_GUIDE.md](TEXTFIELD_GUIDE.md) for complete documentation

---

## 🎯 Font Sizes at a Glance

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `displayLarge` | 12px | 700 | Main titles |
| `displayMedium` | 11px | 600 | Section titles |
| `headlineLarge` | 12px | 700 | Headings |
| `headlineMedium` | 11px | 600 | Subheadings |
| `titleLarge` | 12px | 600 | Card titles |
| `titleMedium` | 10px | 600 | Small titles |
| `bodyLarge` | 11px | 400 | Body text |
| `bodyMedium` | 10px | 400 | Regular text |
| `bodySmall` | 8px | 400 | Small text |
| `labelLarge` | 11px | 600 | Labels |
| `buttonText` | 11px | 600 | Button text |
| `caption` | 8px | 400 | Captions |

---

## 🎨 Color Usage Quick Reference

```dart
// Use theme colors for auto dark/light support
backgroundColor: Theme.of(context).scaffoldBackgroundColor
textColor: Theme.of(context).textTheme.bodyLarge?.color

// Or use fixed AppColors
primaryColor: AppColors.primaryGold
accentColor: AppColors.secondaryBlack
errorColor: AppColors.errorRed
```

---

## 📦 Component Import Cheatsheet

```dart
// All-in-one import
import 'package:gifx/app/views/widgets/index.dart';

// Then use:
// - CustomAppBar
// - CustomElevatedButton
// - CustomIconButton
// - SocialLoginButton
// - GlassmorphicContainer
// - ThemeAnnotatedRegion
// - CustomTextField (NEW!)
```

---

## ⚙️ Common Configurations

### Change Global Font Size
Edit `lib/config/theme/app_text_styles.dart` - modify fontSize values

### Change Global Border Radius  
- For buttons: Edit `borderRadius` in `app_theme.dart`
- For widgets: Pass `borderRadius` parameter

### Change Global Padding/Margins
- Edit `EdgeInsets` values in each widget
- Or pass custom values via parameters

### Add New Colors
Edit `lib/constants/colors.dart`:
```dart
static const Color myNewColor = Color(0xFF123456);
```

---

## 🐛 Troubleshooting

### Glassmorphic Container looks plain
**Solution**: Ensure background has content behind it (scaffold background or parent with color)

### Text not using Poppins font
**Solution**: Use `AppTextStyles.bodyMedium` instead of plain TextStyle

### Dark mode colors not working
**Solution**: Use `Theme.of(context).brightness` to check theme mode

### Custom AppBar not rounded
**Solution**: Update might override shape - check `app_theme.dart`

---

## 📱 Example Page Template

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gifx/app/views/widgets/index.dart';
import 'package:gifx/config/theme/app_text_styles.dart';
import 'package:gifx/constants/colors.dart';

class TemplatePage extends StatelessWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(title: 'Template Page'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              GlassmorphicContainer(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: AppTextStyles.headlineLarge.copyWith(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Subtitle or description',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Content
              CustomElevatedButton(
                label: 'Action',
                onPressed: () {},
                width: double.infinity,
              ),
              const SizedBox(height: 12),
              
              CustomIconButton(
                icon: Icons.info,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

**Last Updated**: December 2025
