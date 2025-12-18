# Custom TextField Component Documentation

## Overview
`CustomTextField` adalah komponen text field yang elegant, modern, dan fully-animated dengan dukungan berbagai tipe input, validation, dan currency formatting.

---

## Fitur Utama

✅ **4 Tipe TextField**: email, password, number, descriptive
✅ **Full Animation**: Focus state, border glow, label color transition
✅ **Validation Support**: Custom validator dengan error display
✅ **Currency Formatting**: Support IDR (Rp) dan USD ($) dengan thousand separator
✅ **Min/Max Length**: Validation untuk panjang text
✅ **Password Toggle**: Animated visibility icon untuk password field
✅ **Glassmorphism Design**: Backdrop blur + glassmorphic effect
✅ **Dark/Light Theme**: Otomatis adapt dengan theme
✅ **Helper Text**: Smart hints untuk tipe field tertentu
✅ **Icons Support**: Prefix & suffix icons yang customizable

---

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | String | Required | Label teks di atas field |
| `hint` | String | Required | Placeholder text di dalam field |
| `type` | TextFieldType | Required | Tipe field: email, password, number, descriptive |
| `controller` | TextEditingController | null | Controller untuk mengakses text |
| `minLength` | int | 0 | Minimum character length |
| `maxLength` | int | 255 | Maximum character length |
| `maxLines` | int | 1 | Hanya untuk descriptive type |
| `validator` | Function | null | Custom validation function |
| `onChanged` | Function | null | Callback saat text berubah |
| `onSubmitted` | Function | null | Callback saat submit |
| `enabled` | bool | true | Enable/disable field |
| `prefixIcon` | String | null | Icon sebelum text |
| `suffixIcon` | String | null | Icon sesudah text |
| `obscureText` | bool | false | Hide text (auto true untuk password) |
| `currencyFormat` | CurrencyFormat | null | IDR atau USD (untuk number type) |
| `padding` | EdgeInsets | 12 all | Padding dalam field |
| `borderRadius` | double | 14 | Border radius |

---

## TextFieldType

```dart
enum TextFieldType {
  email,        // Email input dengan keyboard email
  password,     // Password dengan toggle visibility
  number,       // Number input, support currency format
  descriptive   // Multi-line textarea untuk deskripsi
}
```

---

## CurrencyFormat

```dart
enum CurrencyFormat {
  IDR,  // Indonesia Rupiah (Rp 1.234.567)
  USD   // US Dollar ($ 1,234,567)
}
```

---

## Animasi

### 1. Focus Animation (300ms)
- Label berubah warna → Gold
- TextField scale 1.0 → 1.02
- Border menebal dan berubah ke gold

### 2. Border Glow Animation (400ms)
- Shadow gold muncul saat focused
- Glow effect mengikuti border radius

### 3. Error State
- Label dan border berubah merah
- Error text dengan smooth appearance

---

## Contoh Penggunaan

### Email Field
```dart
CustomTextField(
  label: 'Email Address',
  hint: 'Enter your email',
  type: TextFieldType.email,
  prefixIcon: 'email',
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Email is required';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
      return 'Enter a valid email';
    }
    return null;
  },
)
```

### Password Field
```dart
CustomTextField(
  label: 'Password',
  hint: 'Enter your password',
  type: TextFieldType.password,
  prefixIcon: 'lock',
  minLength: 8,
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Password is required';
    if (value!.length < 8) return 'Min 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Must contain uppercase';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Must contain number';
    }
    return null;
  },
)
```

### Number Field dengan Currency
```dart
// IDR Format
CustomTextField(
  label: 'Amount',
  hint: 'Enter amount',
  type: TextFieldType.number,
  prefixIcon: 'money',
  currencyFormat: CurrencyFormat.IDR,
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Amount is required';
    return null;
  },
)

// USD Format
CustomTextField(
  label: 'Price',
  hint: 'Enter price',
  type: TextFieldType.number,
  prefixIcon: 'money',
  currencyFormat: CurrencyFormat.USD,
)
```

### Number Field (Plain)
```dart
CustomTextField(
  label: 'Phone Number',
  hint: 'Enter phone number',
  type: TextFieldType.number,
  prefixIcon: 'phone',
  minLength: 10,
  maxLength: 13,
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Phone is required';
    if (value!.replaceAll(RegExp(r'[^0-9]'), '').length < 10) {
      return 'Min 10 digits';
    }
    return null;
  },
)
```

### Descriptive Field
```dart
CustomTextField(
  label: 'Description',
  hint: 'Write your description here...',
  type: TextFieldType.descriptive,
  maxLines: 5,
  maxLength: 500,
  prefixIcon: 'description',
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Description is required';
    if (value!.length < 20) return 'Min 20 characters';
    return null;
  },
)
```

---

## Form Example (Complete)

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gifx/app/views/widgets/index.dart';
import 'package:gifx/config/theme/app_text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  late TextEditingController _descriptionController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form valid, do something
      Get.snackbar(
        'Success',
        'Form submitted successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(title: 'Login Form'),
      body: ThemeAnnotatedRegion(
        isDarkMode: isDark,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email Field
                  CustomTextField(
                    label: 'Email Address',
                    hint: 'Enter your email',
                    type: TextFieldType.email,
                    controller: _emailController,
                    prefixIcon: 'email',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  CustomTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    type: TextFieldType.password,
                    controller: _passwordController,
                    prefixIcon: 'lock',
                    minLength: 8,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Password is required';
                      }
                      if (value!.length < 8) {
                        return 'Min 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Phone Field
                  CustomTextField(
                    label: 'Phone Number',
                    hint: 'Enter phone number',
                    type: TextFieldType.number,
                    controller: _phoneController,
                    prefixIcon: 'phone',
                    minLength: 10,
                    maxLength: 13,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Phone is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Amount Field with Currency
                  CustomTextField(
                    label: 'Amount (IDR)',
                    hint: 'Enter amount',
                    type: TextFieldType.number,
                    controller: _descriptionController,
                    prefixIcon: 'money',
                    currencyFormat: CurrencyFormat.IDR,
                  ),
                  const SizedBox(height: 30),

                  // Submit Button
                  CustomElevatedButton(
                    label: 'Login',
                    onPressed: _submitForm,
                    width: double.infinity,
                    height: 48,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## Icon Names Supported

| Icon Name | Displays |
|-----------|----------|
| `email` | Email envelope icon |
| `lock` | Lock icon |
| `phone` | Phone icon |
| `user` | Person/User icon |
| `description` | Description/Document icon |
| `search` | Search icon |
| `check` | Check circle icon |

---

## Best Practices

### 1. **Validation**
```dart
// ✅ Good - Comprehensive validation
validator: (value) {
  if (value?.isEmpty ?? true) return 'Field is required';
  if (value!.length < minLength) return 'Too short';
  // Custom logic
  return null;
}

// ❌ Avoid - Incomplete validation
validator: (value) => value?.isEmpty ?? true ? 'Required' : null
```

### 2. **Controller Management**
```dart
// ✅ Good - Proper lifecycle
late TextEditingController _controller;

@override
void initState() {
  super.initState();
  _controller = TextEditingController();
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}

// ❌ Avoid - Forgot to dispose
TextEditingController _controller = TextEditingController();
```

### 3. **Currency Formatting**
```dart
// ✅ Good - Use CurrencyFormat enum
currencyFormat: CurrencyFormat.IDR

// ❌ Avoid - Manual formatting
// Format manually in validator
```

---

## Animation Details

### Focus Animation Timeline
```
0ms   ─────────────────────── 300ms
      Scale: 1.0 ──→ 1.02
      Label color: normal ──→ gold
      Border: 1.5px ──→ 2px
```

### Border Glow Timeline
```
0ms   ─────────────────────── 400ms
      Shadow opacity: 0 ──→ 0.3
      Blur radius: 0 ──→ 12
      Spread radius: 0 ──→ 2
```

---

## Accessibility

- ✅ Full keyboard support
- ✅ Clear focus indicators
- ✅ Error messages at 10px (readable)
- ✅ High contrast in dark/light mode
- ✅ Icon scaling for readability

---

## Performance

- Uses `TickerProviderStateMixin` for smooth animations
- `AnimatedBuilder` for optimized rebuilds
- No unnecessary widget rebuilds
- Efficient TextInputFormatter

---

## Troubleshooting

### Text Field tidak fokus dengan keyboard
**Solusi**: Pastikan `enabled: true` dan `focusNode` tidak di-dispose prematur

### Currency format tidak muncul
**Solusi**: Pastikan `type: TextFieldType.number` dan `currencyFormat` di-set

### Animation tidak smooth
**Solusi**: Pastikan using `TickerProviderStateMixin` dan dispose AnimationController

### Validator tidak jalan
**Solusi**: Pastikan field berada di dalam `Form` dan `validate()` dipanggil

---

## File Location

```
lib/app/views/widgets/
└── custom_text_field.dart
```

**Export**: Via `lib/app/views/widgets/index.dart`

```dart
import 'package:gifx/app/views/widgets/index.dart';

// Use CustomTextField
```

---

**Last Updated**: December 18, 2025
**Status**: Production Ready ✅
