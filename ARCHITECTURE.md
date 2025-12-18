# GifX - Project Structure & Configuration Guide

## Struktur Direktori (MVC Architecture)

```
lib/
├── main.dart                          # Entry point aplikasi
├── app/
│   ├── controllers/                   # Business Logic Layer
│   │   ├── home_controller.dart      # Controller untuk Home Page
│   │   └── theme_controller.dart     # Controller untuk Theme Management
│   ├── models/                        # Data Models
│   │   └── [model files akan ditambahkan]
│   └── views/
│       ├── pages/                     # Full Page Screens
│       │   └── home_page.dart        # Home Page
│       └── widgets/                   # Reusable Widgets
│           └── [widget files akan ditambahkan]
├── config/
│   ├── theme/
│   │   └── app_theme.dart            # Theme configuration (light & dark)
│   └── localization/
│       ├── app_translations.dart     # Translation strings
│       └── localization_service.dart # Localization service
├── constants/
│   └── colors.dart                   # Color palette (Gold primary, B&W secondary)
└── utils/
    └── [utility files akan ditambahkan]
```

## Fitur Yang Telah Dikonfigurasi

### 1. **Multi-Language Support (i18n)**
- Mendukung: Indonesian (id) & English (en)
- Menggunakan: GetX untuk localization
- File: `lib/config/localization/`

**Cara menggunakan:**
```dart
Text('hello'.tr)  // Akan menampilkan "Halo" atau "Hello"
```

### 2. **Multi-Theme Support**
- Light Theme (Terang) - Gold AppBar, White Background
- Dark Theme (Gelap) - Dark AppBar, Dark Background
- Toggle theme dengan button di AppBar
- File: `lib/config/theme/app_theme.dart`

### 3. **Color Palette**
- **Primary**: Gold (#D4AF37)
- **Secondary**: Black (#000000) & White (#FFFFFF)
- **Accent Colors**: Light Gold, Dark Gold, Greys
- File: `lib/constants/colors.dart`

### 4. **MVC Architecture**
- **Models**: Data structures
- **Views**: UI Components & Pages
- **Controllers**: Business Logic (menggunakan GetX)

### 5. **Dependencies**
- `get: ^4.7.3` - State Management & Routing
- `intl: ^0.20.2` - Internationalization
- `flutter_localizations` - Flutter localization support

## Cara Menggunakan Localization

### Menambah Translation Baru
Edit `lib/config/localization/app_translations.dart`:

```dart
const Map<String, Map<String, String>> translations = {
  'id': {
    'key_name': 'Teks Indonesia',
  },
  'en': {
    'key_name': 'English Text',
  },
};
```

### Menggunakan di Widget
```dart
Text('key_name'.tr)  // Akan automatically menerjemahkan

// Dengan parameter
'welcome_user'.trParams({'name': 'John'})
```

## Cara Menggunakan Theme

### Mengakses Current Theme
```dart
final ThemeController themeController = Get.find<ThemeController>();

// Mengubah tema
themeController.toggleTheme();  // Toggle antara light & dark

// Cek apakah dark mode
if (themeController.isDarkMode) {
  // Do something
}
```

### Menggunakan Warna Aplikasi
```dart
import 'constants/colors.dart';

Container(
  color: AppColors.primaryGold,
  child: Text('Gold Background'),
);
```

### Menggunakan TextStyle dari Theme
```dart
Text(
  'Headline',
  style: Theme.of(context).textTheme.headlineSmall,
);

Text(
  'Body Text',
  style: Theme.of(context).textTheme.bodyMedium,
);
```

## Menjalankan Aplikasi

```bash
# Install dependencies
flutter pub get

# Run aplikasi
flutter run

# Build untuk release
flutter build apk      # Android
flutter build ios      # iOS
flutter build web      # Web
```

## Best Practices

### 1. **Membuat Page Baru**
```dart
// lib/app/views/pages/new_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/new_controller.dart';

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewController());
    
    return Scaffold(
      appBar: AppBar(title: Text('page_title'.tr)),
      body: // Your UI here
    );
  }
}
```

### 2. **Membuat Controller Baru**
```dart
// lib/app/controllers/new_controller.dart
import 'package:get/get.dart';

class NewController extends GetxController {
  static NewController get to => Get.find();
  
  final Rx<String> message = ''.obs;
  
  void updateMessage(String newMessage) {
    message.value = newMessage;
  }
}
```

### 3. **Menggunakan Reactive Widget**
```dart
// Otomatis rebuild saat data berubah
Obx(() => Text(controller.message.value))

// List of Obx
Obx(() => 
  ListView.builder(
    itemCount: controller.items.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(controller.items[index]),
      );
    },
  )
)
```

## Navigation (Using GetX)

```dart
// Navigate ke halaman baru
Get.to(() => const NewPage());

// Navigate dengan replacement
Get.offAll(() => const NewPage());

// Named navigation (untuk production)
Get.toNamed('/new-page');

// Back
Get.back();
```

## Environment Setup

- Flutter SDK: ^3.10.4
- Dart SDK: Latest
- Material Design 3: Enabled (useMaterial3: true)

## Next Steps

1. Tambahkan lebih banyak Pages sesuai kebutuhan
2. Implementasikan persistent storage (SharedPreferences/Hive)
3. Tambahkan networking layer (dio/http)
4. Implementasikan authentication
5. Tambahkan testing

## Troubleshooting

### GetX Controllers tidak terdafister
```dart
// Solusi: Pastikan put() dipanggil sebelum menggunakan controller
Get.put(HomeController());
```

### Translation tidak muncul
```dart
// Pastikan translation key ada di app_translations.dart
// dan locale sudah di-set di main.dart
```

### Theme tidak berubah
```dart
// Pastikan menggunakan Obx() untuk reactive theme change
Obx(() => GetMaterialApp(
  themeMode: Get.find<ThemeController>().themeMode,
))
```

---

**Last Updated**: December 2025
**Status**: Ready for Development
