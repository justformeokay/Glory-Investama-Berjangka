# GifX - Components & Theme Documentation

## 🎨 Theme System

### Glassmorphism Design
Aplikasi menggunakan **Liquid Glass** (Glassmorphism) design pattern dengan:
- Backdrop blur effect
- Semi-transparent backgrounds
- Smooth, frosted glass appearance
- iOS-style rounded corners (14-20px)

### Font System
**Default Font**: Poppins (dari Google Fonts)
- Semua text style menggunakan Poppins untuk consistency
- Small font sizes:
  - **Title/Headline**: 12px
  - **Medium/Body**: 10px  
  - **Small/Caption**: 8px
  - **Button**: 11px

### Color Palette
```dart
// Primary
primaryGold: #D4AF37

// Secondary
secondaryBlack: #000000
secondaryWhite: #FFFFFF

// Status Colors
errorRed: #D32F2F
successGreen: #388E3C
warningOrange: #F57C00
infoBlue: #1976D2
```

---

## 📦 Reusable Widgets

### 1. **GlassmorphicContainer**
Container dengan efek glassmorphism.

```dart
import 'package:gifx/app/views/widgets/index.dart';

GlassmorphicContainer(
  borderRadius: 16,
  opacity: 0.1,
  padding: const EdgeInsets.all(16),
  child: Column(
    children: [
      Text('Glassmorphic Content'),
    ],
  ),
)
```

**Parameters**:
- `child` (Widget): Widget yang dibungkus
- `borderRadius` (double): Radius sudut, default 16
- `backgroundColor` (Color?): Warna dasar
- `opacity` (double): Opacity level, default 0.1
- `padding` (EdgeInsets): Padding dalam
- `margin` (EdgeInsets): Margin luar
- `border` (Border?): Custom border
- `boxShadow` (BoxShadow?): Custom shadow

---

### 2. **CustomAppBar**
AppBar dengan styling custom dan Poppins font.

```dart
import 'package:gifx/app/views/widgets/index.dart';

CustomAppBar(
  title: 'Home',
  actions: [
    CustomIconButton(
      icon: Icons.settings,
      onPressed: () {},
    ),
  ],
  centerTitle: true,
)
```

**Parameters**:
- `title` (String): Judul AppBar
- `actions` (List<Widget>?): Action buttons
- `leading` (Widget?): Leading widget
- `centerTitle` (bool): Center title, default true
- `elevation` (double): Shadow elevation
- `backgroundColor` (Color?): Background color
- `foregroundColor` (Color?): Text/icon color
- `height` (double): Height, default 56

---

### 3. **CustomElevatedButton**
Tombol elevated dengan ikon opsional dan loading state.

```dart
CustomElevatedButton(
  label: 'Login',
  icon: Icons.login,
  onPressed: () {},
  isLoading: false,
  width: double.infinity,
  height: 48,
)
```

**Parameters**:
- `label` (String): Text label
- `onPressed` (VoidCallback): Callback saat ditekan
- `icon` (IconData?): Icon opsional
- `isLoading` (bool): Show loading indicator
- `isDisabled` (bool): Disable button
- `backgroundColor` (Color?): Background color
- `foregroundColor` (Color?): Text/icon color
- `padding` (EdgeInsets): Button padding
- `borderRadius` (double): Border radius, default 14
- `width` (double?): Custom width
- `height` (double?): Custom height

---

### 4. **CustomIconButton**
Icon button dengan glassmorphic background.

```dart
CustomIconButton(
  icon: Icons.favorite,
  onPressed: () {},
  size: 44,
  iconSize: 24,
  tooltip: 'Like',
  borderRadius: 12,
)
```

**Parameters**:
- `icon` (IconData): Icon untuk ditampilkan
- `onPressed` (VoidCallback): Callback saat ditekan
- `backgroundColor` (Color?): Background color
- `iconColor` (Color?): Icon color
- `size` (double): Size button, default 44
- `iconSize` (double): Icon size, default 24
- `tooltip` (String?): Tooltip text
- `isLoading` (bool): Show loading
- `isDisabled` (bool): Disable button
- `borderRadius` (double): Border radius, default 12

---

### 5. **SocialLoginButton**
Tombol login dengan ikon/logo media sosial.

```dart
SocialLoginButton(
  label: 'Login with Google',
  icon: Icons.flutter_dash,
  imagePath: 'assets/images/google_logo.png', // Optional
  onPressed: () {},
  iconColor: Colors.blue,
  height: 50,
)
```

**Parameters**:
- `label` (String): Button label/text
- `icon` (IconData): Icon default
- `onPressed` (VoidCallback): Callback
- `backgroundColor` (Color?): Background
- `iconColor` (Color?): Icon color
- `isLoading` (bool): Show loading
- `isDisabled` (bool): Disable button
- `height` (double): Height, default 50
- `imagePath` (String?): Path ke image logo (priority dari icon)

---

## 🎯 Text Styles Usage

```dart
import 'package:gifx/config/theme/app_text_styles.dart';

// Display Styles (Large titles)
Text('Title', style: AppTextStyles.displayLarge) // 12px bold
Text('Subtitle', style: AppTextStyles.displayMedium) // 11px semibold

// Headline Styles
Text('Heading', style: AppTextStyles.headlineLarge) // 12px bold
Text('Subheading', style: AppTextStyles.headlineMedium) // 11px semibold

// Title Styles  
Text('Title', style: AppTextStyles.titleLarge) // 12px semibold
Text('Subtitle', style: AppTextStyles.titleMedium) // 10px semibold

// Body Styles
Text('Body', style: AppTextStyles.bodyLarge) // 11px regular
Text('Description', style: AppTextStyles.bodyMedium) // 10px regular
Text('Small text', style: AppTextStyles.bodySmall) // 8px regular

// Label & Button Styles
Text('Label', style: AppTextStyles.labelLarge) // 11px semibold
Text('Button Text', style: AppTextStyles.buttonText) // 11px semibold

// Special Styles
Text('Caption', style: AppTextStyles.caption) // 8px small
Text('OVERLINE', style: AppTextStyles.overline) // 7px uppercase
```

---

## 🌓 Dark/Light Theme

Aplikasi secara otomatis switch antara light dan dark theme:

```dart
import 'package:gifx/app/controllers/theme_controller.dart';
import 'package:get/get.dart';

final themeController = Get.find<ThemeController>();

// Toggle theme
themeController.toggleTheme();

// Set specific theme
themeController.setThemeMode(ThemeMode.dark);
themeController.setThemeMode(ThemeMode.light);

// Check current theme
if (themeController.isDarkMode) {
  // Dark mode active
}
```

---

## 🎨 Using Colors

```dart
import 'package:gifx/constants/colors.dart';

Container(
  color: AppColors.primaryGold,
  child: Text(
    'Gold Container',
    style: TextStyle(color: AppColors.secondaryBlack),
  ),
)
```

**Available Colors**:
```dart
// Primary Colors
AppColors.primaryGold
AppColors.primaryGoldLight
AppColors.primaryGoldDark

// Secondary Colors  
AppColors.secondaryBlack
AppColors.secondaryWhite
AppColors.secondaryGrey
AppColors.secondaryLightGrey

// Status Colors
AppColors.errorRed
AppColors.successGreen
AppColors.warningOrange
AppColors.infoBlue

// Disabled Colors
AppColors.disabledColor
AppColors.disabledTextColor
```

---

## 📱 Creating Custom Components

### Example: Custom Card Component

```dart
import 'package:flutter/material.dart';
import 'package:gifx/app/views/widgets/glassmorphic_container.dart';
import 'package:gifx/config/theme/app_text_styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const CustomCard({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassmorphicContainer(
      borderRadius: 16,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.titleLarge.copyWith(
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🚀 Best Practices

### 1. **Always Use Theme Colors**
```dart
// ✅ Good
Text(
  'Hello',
  style: TextStyle(
    color: Theme.of(context).brightness == Brightness.dark 
      ? Colors.white 
      : Colors.black,
  ),
)

// ❌ Avoid
Text(
  'Hello',
  style: const TextStyle(color: Colors.black), // Hardcoded color
)
```

### 2. **Use AppTextStyles for Consistency**
```dart
// ✅ Good
Text('Title', style: AppTextStyles.titleLarge)

// ❌ Avoid
Text(
  'Title',
  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
)
```

### 3. **Wrap Containers dengan GlassmorphicContainer**
```dart
// ✅ Good - Glassmorphic look
GlassmorphicContainer(
  child: Column(...),
)

// ❌ Avoid - Plain container
Container(
  color: Colors.white,
  child: Column(...),
)
```

### 4. **Use Custom Widgets untuk Buttons**
```dart
// ✅ Good - Consistent styling
CustomElevatedButton(
  label: 'Login',
  onPressed: () {},
)

// ❌ Avoid - Raw ElevatedButton
ElevatedButton(
  onPressed: () {},
  child: Text('Login'),
)
```

---

## 📁 File Structure

```
lib/
├── config/
│   ├── theme/
│   │   ├── app_theme.dart          # Theme definition
│   │   └── app_text_styles.dart    # Text styles
│   └── localization/
├── constants/
│   └── colors.dart                 # Color palette
└── app/
    └── views/
        └── widgets/
            ├── custom_app_bar.dart
            ├── custom_elevated_button.dart
            ├── custom_icon_button.dart
            ├── social_login_button.dart
            ├── glassmorphic_container.dart
            └── index.dart              # Widgets export
```

---

## 🔧 Advanced Customization

### Mengubah Font Size Global

Edit [lib/config/theme/app_text_styles.dart](lib/config/theme/app_text_styles.dart):

```dart
static TextStyle buttonText = GoogleFonts.poppins(
  fontSize: 11, // Change this
  fontWeight: FontWeight.w600,
);
```

### Mengubah Border Radius Global

Edit masing-masing widget atau theme file dan ubah nilai `borderRadius`.

### Mengubah Opacity Glassmorphic

```dart
GlassmorphicContainer(
  opacity: 0.15, // Increase opacity
  child: ...,
)
```

---

## 📚 Resources

- [Google Fonts - Poppins](https://fonts.google.com/specimen/Poppins)
- [Glassmorphism Design](https://uxdesign.cc/glassmorphism-in-user-interface-design-6289ebb899d0)
- [Flutter Material 3](https://m3.material.io/)
- [GetX Documentation](https://github.com/jonataslaw/getx)

---

**Last Updated**: December 2025
**Status**: Production Ready
