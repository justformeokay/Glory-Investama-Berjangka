# System UI Overlay & AnnotatedRegion Documentation

## Overview

Sistem ini menggunakan `AnnotatedRegion` untuk mengelola status bar dan bottom navigation bar agar selalu sesuai dengan tema aplikasi (light/dark mode). Ini memastikan consistency visual di seluruh aplikasi.

---

## Komponen Utama

### 1. **SystemUIHelper** (`lib/utils/system_ui_helper.dart`)
Helper untuk mengatur system UI overlay style secara global.

```dart
// Set berdasarkan theme mode
SystemUIHelper.setSystemUIOverlayStyle(ThemeMode.light);
SystemUIHelper.setSystemUIOverlayStyle(ThemeMode.dark);

// Set light mode
SystemUIHelper.setLightSystemUIOverlay();

// Set dark mode
SystemUIHelper.setDarkSystemUIOverlay();
```

### 2. **ThemeAnnotatedRegion** (`lib/app/views/widgets/theme_annotated_region.dart`)
Widget reusable yang membungkus child dengan annotated region.

```dart
ThemeAnnotatedRegion(
  isDarkMode: true,
  child: Scaffold(...),
)
```

### 3. **ThemeController** (Updated)
Controller sekarang otomatis update system UI saat tema berubah.

---

## Fitur

### Light Mode
| Bagian | Warna | Icon Brightness |
|--------|-------|-----------------|
| Status Bar | Gold (#D4AF37) | Dark |
| Bottom Nav | Light (#FAFAFA) | Dark |
| Divider | Black (10%) | - |

### Dark Mode
| Bagian | Warna | Icon Brightness |
|--------|-------|-----------------|
| Status Bar | Dark (#1F1F1F) | Light |
| Bottom Nav | Very Dark (#121212) | Light |
| Divider | White (10%) | - |

---

## Implementasi

### Di Main.dart
Sudah menggunakan `AnnotatedRegion` yang reactive dengan Obx untuk automatic theme switching:

```dart
home: Obx(
  () {
    final themeMode = Get.find<ThemeController>().themeMode;
    final isDark = themeMode == ThemeMode.dark;
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(...),
      child: const HomePage(),
    );
  },
),
```

### Di Page Lain
Gunakan `ThemeAnnotatedRegion`:

```dart
import 'package:gifx/app/views/widgets/index.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ThemeAnnotatedRegion(
      isDarkMode: isDark,
      child: Scaffold(
        appBar: AppBar(...),
        body: ...,
      ),
    );
  }
}
```

### Dengan Custom Color
```dart
ThemeAnnotatedRegion(
  isDarkMode: isDark,
  customStatusBarColor: Colors.blue,
  customNavBarColor: Colors.blueAccent,
  child: Scaffold(...),
)
```

---

## Automatic Theme Switching

Saat user toggle theme dengan `themeController.toggleTheme()`:

1. ✅ Theme mode di-update
2. ✅ `GetMaterialApp` render ulang dengan theme baru
3. ✅ `AnnotatedRegion` di main.dart update secara otomatis (via Obx)
4. ✅ Status bar & nav bar colors berubah matching theme

---

## System UI Overlay Style Details

### Status Bar
- **Color**: Sesuai AppBar theme
- **Icon Brightness**: Dark saat light mode, Light saat dark mode
- **Brightness**: Inverse dari icon brightness untuk optimal contrast

### Navigation Bar (Bottom System Buttons)
- **Color**: Sesuai scaffold background
- **Icon Brightness**: Matching status bar untuk consistency
- **Divider Color**: Subtle line separator (10% opacity)

---

## Opacity Handling

Warna menggunakan `.withAlpha((0.7 * 255).toInt())` untuk:
- Menciptakan glassmorphism effect
- Memastikan transparency konsisten
- Menghindari deprecated `withOpacity()`

---

## Best Practices

### 1. **Untuk Pages Dengan Custom Colors**
```dart
// ✅ Good - Respect user theme but override if needed
ThemeAnnotatedRegion(
  isDarkMode: isDark,
  customStatusBarColor: _getThemeColor(isDark),
  child: Scaffold(...),
)
```

### 2. **Untuk Bottom Navigation Bar**
Status bar otomatis adjust, bottom nav biasanya sesuai scaffold background:

```dart
Scaffold(
  body: ThemeAnnotatedRegion(isDarkMode: isDark, child: ...), // Top part
  bottomNavigationBar: Container(...), // Bottom nav auto-styled
)
```

### 3. **Hindari Manual SystemChrome Calls**
```dart
// ❌ Avoid
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(...));

// ✅ Use helper atau AnnotatedRegion instead
SystemUIHelper.setSystemUIOverlayStyle(ThemeMode.dark);
// atau
ThemeAnnotatedRegion(isDarkMode: true, child: ...)
```

---

## Troubleshooting

### Status Bar Tidak Berubah Saat Theme Toggle
**Solusi**: Pastikan menggunakan `Obx()` di wrapping HomePage atau gunakan `ThemeAnnotatedRegion` dengan theme dari `Theme.of(context)`

### Bottom Nav Bar Masih Putih di Dark Mode
**Solusi**: 
1. Pastikan `systemNavigationBarColor` set ke dark color
2. Cek `systemNavigationBarIconBrightness` untuk icons

### Ikon Status Bar Tidak Terlihat
**Solusi**: 
1. Jika icon putih, gunakan `Brightness.light` untuk `statusBarIconBrightness`
2. Jika icon hitam, gunakan `Brightness.dark`

---

## File Locations

```
lib/
├── utils/
│   └── system_ui_helper.dart          # Global helper
├── app/
│   ├── controllers/
│   │   └── theme_controller.dart      # Updated dengan UI overlay
│   └── views/
│       ├── pages/
│       │   └── home_page.dart         # Responsive dengan Obx
│       └── widgets/
│           ├── theme_annotated_region.dart  # Reusable wrapper
│           └── index.dart
└── main.dart                          # AnnotatedRegion dengan Obx
```

---

## Contoh Implementasi Lengkap

```dart
import 'package:flutter/material.dart';
import 'package:gifx/app/views/widgets/theme_annotated_region.dart';

class MyCustomPage extends StatelessWidget {
  const MyCustomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ThemeAnnotatedRegion(
      isDarkMode: isDark,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Page'),
        ),
        body: Container(
          color: isDark ? Colors.black : Colors.white,
          child: Center(
            child: Text('Content Here'),
          ),
        ),
        // Bottom nav bar akan auto-styled dengan warna sesuai theme
        bottomNavigationBar: Container(
          color: isDark ? const Color(0xFF1F1F1F) : Colors.white,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: const Icon(Icons.home), onPressed: () {}),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              IconButton(icon: const Icon(Icons.profile), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Performance

- **No Performance Impact**: `AnnotatedRegion` adalah built-in Flutter widget yang lightweight
- **Reactive Updates**: Menggunakan `Obx()` hanya update saat theme benar-benar berubah
- **No Extra Rendering**: System UI styling doesn't trigger full app rebuild

---

**Last Updated**: December 18, 2025
**Status**: Production Ready ✅
