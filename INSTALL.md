# 🚀 دليل التثبيت - Soware Rafinar

## 📋 المتطلبات

| المتطلب | النسخة | الرابط |
|---------|--------|--------|
| Flutter SDK | >= 3.0.0 | [flutter.dev](https://flutter.dev) |
| Android Studio | آخر نسخة | [developer.android.com](https://developer.android.com/studio) |
| JDK | 8 أو أحدث | [oracle.com/java](https://www.oracle.com/java/) |
| Git | أي نسخة | [git-scm.com](https://git-scm.com) |

## 🔧 خطوات التثبيت

### 1. تثبيت Flutter

```bash
# Windows
# صب من الموقع الرسمي: https://flutter.dev/docs/get-started/install/windows

# macOS
brew install flutter

# Linux
sudo snap install flutter --classic
```

### 2. التحقق من التثبيت

```bash
flutter doctor
```

غادي يعطيك تقرير. خاصك تحل أي مشاكل قبل ما تكمل.

### 3. نسخ المشروع

```bash
git clone https://github.com/yourusername/soware_rafinar.git
cd soware_rafinar
```

### 4. تثبيت Dependencies

```bash
flutter pub get
```

### 5. تشغيل التطبيق

```bash
# على محاكي أو جهاز متصل
flutter run

# أو بناء APK
flutter build apk --release

# أو بناء App Bundle (لـ Play Store)
flutter build appbundle --release
```

## 📱 التثبيت على الجهاز

### طريقة 1: Flutter Install

```bash
flutter install
```

### طريقة 2: ADB

```bash
adb install build/app/outputs/flutter-apk/release/app-release.apk
```

### طريقة 3: يدوي

1. انقل APK للجهاز
2. فتح الملف
3. سمح بالتثبيت من "مصادر غير معروفة"
4. ثبت

## 🐛 حل المشاكل

### مشكلة: `flutter command not found`

**الحل:**
```bash
# أضف Flutter لـ PATH
export PATH="$PATH:/path/to/flutter/bin"

# أو صب عبر snap
sudo snap install flutter --classic
```

### مشكلة: `Gradle build failed`

**الحل:**
```bash
flutter clean
flutter pub get
cd android
./gradlew clean
./gradlew build
cd ..
flutter build apk
```

### مشكلة: `Permission denied`

**الحل:**
```bash
# Linux/macOS
chmod +x build.sh
chmod +x android/gradlew

# Windows (PowerShell as Admin)
# ما خاصكش تدير حاجة
```

### مشكلة: الصور ما كتحملش

**الحل:**
1. تأكد من الإنترنت
2. جرب VPN
3. غير API key فـ `lib/services/unsplash_service.dart`

## 🎯 أوامر مفيدة

| الأمر | الوصف |
|-------|-------|
| `flutter run` | تشغيل debug |
| `flutter run --release` | تشغيل release |
| `flutter build apk` | بناء APK |
| `flutter build appbundle` | بناء AAB |
| `flutter clean` | مسح cache |
| `flutter doctor` | فحص المشاكل |
| `flutter pub get` | تحديث packages |
| `flutter pub upgrade` | upgrade packages |

## 📦 حجم APK

| النوع | الحجم التقريبي |
|-------|---------------|
| Debug APK | ~50 MB |
| Release APK | ~20 MB |
| App Bundle | ~15 MB |

## 🌐 التواصل

| المنصة | الرابط |
|--------|--------|
| GitHub | [github.com/yourusername/soware_rafinar](https://github.com) |
| Issues | [github.com/yourusername/soware_rafinar/issues](https://github.com) |
| Email | soware.rafinar@example.com |

---

**بالتوفيق! 🌿**
