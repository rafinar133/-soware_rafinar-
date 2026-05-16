# 🌿 Soware Rafinar - صور رفيعة منتقاة

<div align="center">

![Soware Rafinar](assets/images/2_5_Gorgeous_Sage_Green_Color_Palettes.png)

**تطبيق مشاركة الصور بالدارجة المغربية 🇲🇦**

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-9CAF88.svg)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-E07A5F.svg)](LICENSE)
[![F-Droid](https://img.shields.io/badge/F--Droid-Coming%20Soon-81B29A.svg)]()

</div>

## ✨ الميزات

| الميزة | الوصف | الأيقونة |
|--------|-------|----------|
| 📌 **Pin صورة** | حفظ الصور في الجهاز | 🔖 |
| 📂 **لوحات (Boards)** | تنظيم الصور في مجموعات | 📁 |
| 🔍 **استكشاف** | تصفح صور من Unsplash | 🔎 |
| ❤️ **Like** | الإعجاب بالصور | 💚 |
| 🏷️ **تصنيفات** | 10 تصنيفات مختلفة | 🏷️ |
| 🌙 **ألوان مريحة** | واجهة بألوان هادئة | 🎨 |
| 👤 **Guest Mode** | بلا تسجيل | 🆓 |

## 🎨 الألوان المستخدمة

<div align="center">

| اللون | الكود | الاستعمال |
|-------|-------|-----------|
| 🟢 **Sage Green** | `#9CAF88` | الخلفية الرئيسية |
| 🟤 **Warm Beige** | `#F5F1E8` | خلفية التطبيق |
| 🟠 **Terracotta** | `#E07A5F` | الأزرار النشطة |
| 🔵 **Muted Blue** | `#81B29A` | التفاعلات الثانوية |
| ⚫ **Dark Olive** | `#3D405B` | النص الرئيسي |

</div>

## 📱 الشاشات

```
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   🏠 الرئيسية    │  │  🔍 البحث      │  │  🖼️ تفاصيل     │
│                 │  │                 │  │    الصورة      │
│  • تصنيفات      │  │  • بحث حر      │  │  • Like        │
│  • صور شائعة    │  │  • اقتراحات    │  │  • Save        │
│  • شبكة صور     │  │  • نتائج       │  │  • Share       │
│                 │  │                 │  │  • Download    │
└─────────────────┘  └─────────────────┘  └─────────────────┘

┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│ 📌 المحفوظات    │  │ 📂 اللوحات      │  │ 👤 البروفايل   │
│                 │  │                 │  │                 │
│  • swipe لحذف    │  │  • إنشاء لوحة  │  │  • إحصائيات    │
│  • صور محفوظة   │  │  • صور اللوحة  │  │  • الإعدادات    │
│                 │  │                 │  │  • مسح البيانات│
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

## 🚀 التثبيت

### الطريقة 1: F-Droid (قريباً)

```bash
# غادي يكون متاح فـ F-Droid
```

### الطريقة 2: Build يدوي

#### المتطلبات
- Flutter SDK >= 3.0.0
- Android SDK
- JDK 8+

#### الخطوات

```bash
# 1. نسخ المستودع
git clone https://github.com/yourusername/soware_rafinar.git
cd soware_rafinar

# 2. تثبيت الـ dependencies
flutter pub get

# 3. تشغيل التطبيق (debug)
flutter run

# 4. أو بناء APK
flutter build apk --release

# 5. نقل APK للجهاز
flutter install
```

### الطريقة 3: السكريپ التلقائي

```bash
# تشغيل سكريپ البناء
chmod +x build.sh
./build.sh
```

## 📦 الـ Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0                    # API calls
  cached_network_image: ^3.3.0    # تحميل الصور
  image_picker: ^1.0.4             # اختيار صور
  path_provider: ^2.1.1            # مسارات الجهاز
  permission_handler: ^11.0.1      # الصلاحيات
  shared_preferences: ^2.2.2       # التخزين المحلي
  flutter_staggered_grid_view: ^0.7.0  # شبكة متنوعة
  shimmer: ^3.0.0                  # تأثير التحميل
  share_plus: ^7.2.1               # المشاركة
```

## 🏷️ التصنيفات المتاحة

| التصنيف | الأيقونة | البحث |
|---------|----------|-------|
| 🌿 الطبيعة | `forest` | nature landscape |
| 🎨 الفن | `palette` | art painting |
| 🍲 الطبخ | `restaurant` | food cooking |
| 🏠 الديكور | `chair` | interior design |
| 👗 الأزياء | `checkroom` | fashion style |
| ✈️ السفر | `flight` | travel adventure |
| 💪 الرياضة | `fitness` | sports fitness |
| 📚 القراءة | `menu_book` | books reading |
| 📷 التصوير | `camera` | photography |
| 🐾 الحيوانات | `pets` | animals cute |

## 📁 هيكلة المشروع

```
soware_rafinar/
├── 📂 android/              # إعدادات Android
├── 📂 assets/             # الصور والخطوط
├── 📂 lib/
│   ├── 📄 main.dart        # نقطة الدخول
│   ├── 📂 models/          # النماذج
│   │   ├── soware_image.dart
│   │   ├── board.dart
│   │   └── categories.dart
│   ├── 📂 screens/         # الشاشات
│   │   ├── home_screen.dart
│   │   ├── search_screen.dart
│   │   ├── image_detail_screen.dart
│   │   ├── saved_screen.dart
│   │   ├── boards_screen.dart
│   │   ├── board_detail_screen.dart
│   │   └── profile_screen.dart
│   ├── 📂 services/        # الخدمات
│   │   ├── unsplash_service.dart
│   │   └── storage_service.dart
│   ├── 📂 widgets/         # الويدجات
│   │   ├── image_card.dart
│   │   ├── category_chip.dart
│   │   └── shimmer_loading.dart
│   └── 📂 utils/           # الأدوات
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       └── app_theme.dart
├── 📄 pubspec.yaml         # الـ dependencies
├── 📄 build.sh             # سكريپ البناء
└── 📄 README.md            # هاد الملف
```

## 🔧 API

التطبيق يستخدم **Unsplash API** باش يجيب صور مجانية عالية الجودة.

```
https://api.unsplash.com
```

> **ملاحظة:** للاستخدام التجاري، خاصك تسجل فـ [Unsplash Developers](https://unsplash.com/developers) وجيب API Key.

## 🤝 المساهمة

مرحبا بأي مساهمة! يمكنك:

- 🐛 [الإبلاغ عن الأخطاء](https://github.com/yourusername/soware_rafinar/issues)
- 💡 [اقتراح ميزات جديدة](https://github.com/yourusername/soware_rafinar/issues)
- 🔧 [تحسين الكود](https://github.com/yourusername/soware_rafinar/pulls)
- 🌍 [الترجمة للغات أخرى](https://github.com/yourusername/soware_rafinar/issues)

## 📄 الترخيص

هاد المشروع مفتوح المصدر ومرخص تحت **MIT License**.

```
MIT License

Copyright (c) 2026 Soware Rafinar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

## 🙏 شكر خاص

- **[Unsplash](https://unsplash.com)** - للصور المجانية 📸
- **[Flutter](https://flutter.dev)** - للإطار البرمجي 💙
- **[المغرب](https://en.wikipedia.org/wiki/Morocco)** - للإلهام 🇲🇦
- **كل المساهمين** - اللي ساعدو فالمشروع 🤝

---

<div align="center">

**صمم ب❤️ في المغرب**

🌿 **Soware Rafinar** - صور رفيعة منتقاة 🌿

</div>
