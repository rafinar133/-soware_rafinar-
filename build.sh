#!/bin/bash

# Soware Rafinar - Build Script
# هاد السكريپ باش تبني التطبيق

echo "🌿 Soware Rafinar - Build Script"
echo "================================"

# Check Flutter
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter ماشي منصب!"
    echo "صب من: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -1)"

# Clean
echo "🧹 Cleaning..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build APK
echo "🔨 Building APK..."
flutter build apk --release

# Check result
if [ -f "build/app/outputs/flutter-apk/release/app-release.apk" ]; then
    echo "✅ Build successful!"
    echo "📱 APK: build/app/outputs/flutter-apk/release/app-release.apk"
    ls -lh build/app/outputs/flutter-apk/release/app-release.apk
else
    echo "❌ Build failed!"
    exit 1
fi

# Optional: Build app bundle
echo "🔨 Building App Bundle..."
flutter build appbundle --release

if [ -f "build/app/outputs/bundle/release/app-release.aab" ]; then
    echo "✅ App Bundle built!"
    echo "📦 AAB: build/app/outputs/bundle/release/app-release.aab"
fi

echo ""
echo "🎉 تم البناء بنجاح!"
echo ""
echo "باش تنصب على جهازك:"
echo "  flutter install"
echo ""
echo "ولا نقل APK للجهاز ونصبو يدويا."
