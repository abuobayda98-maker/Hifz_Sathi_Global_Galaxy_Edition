# Hifz Sathi: Global Galaxy Edition

এটি একটি **Flutter starter package**—Galaxy থিম, সূরা তালিকা, সূরা পড়ার স্ক্রিন, অনলাইন কুরআন API সংযোগ, বাংলা অনুবাদ লোড করার চেষ্টা, বাংলা TTS এবং স্থানীয় রিভিশন কাউন্টারসহ।

## গুরুত্বপূর্ণ সততা
- এটি এখনো সম্পূর্ণ production-ready অ্যাপ বা তৈরি APK নয়।
- কুরআনের আরবি ও অনুবাদ প্রথমবার অনলাইনে AlQuran Cloud API থেকে লোড হয়; সম্পূর্ণ অফলাইন ডেটা প্যাকেজে অন্তর্ভুক্ত নেই।
- বাংলা অনুবাদের edition `bn.bengali` API-তে না থাকলে সূরার অনুবাদ লোড নাও হতে পারে। প্রয়োজন হলে API edition তালিকা থেকে যাচাইকৃত বাংলা অনুবাদের সঠিক ID নির্বাচন করুন।
- বাংলা Text-to-Speech ফোনে ইনস্টল করা ভয়েসের ওপর নির্ভরশীল। এটি কোনো নির্দিষ্ট বাংলাদেশি ব্যক্তির রেকর্ড করা কণ্ঠ নয়।
- কোনো নির্দিষ্ট ব্যক্তির রেকর্ডিং যুক্ত করার আগে অডিও ফাইল, লিখিত অনুমতি এবং লাইসেন্স সংগ্রহ করতে হবে।
- AI তিলাওয়াত যাচাই, মাইক্রোফোন রেকর্ডিং বিশ্লেষণ, লগইন/ক্লাউড সিঙ্ক, প্যারেন্টাল অ্যাকাউন্ট, পূর্ণ কুইজ, Kids Mode, সম্পূর্ণ অডিও প্লেয়ার, push notifications ও production testing পরবর্তী কাজ।

## চালানোর জন্য
Flutter SDK ও Android build environment প্রয়োজন। শুধু ZIP ফাইল থাকা মানেই APK তৈরি হয়ে যায় না।

1. ZIP extract করুন।
2. Flutter ইনস্টল থাকা কম্পিউটার বা cloud development environment-এ প্রজেক্ট ফোল্ডারে যান।
3. চালান:
   ```bash
   flutter pub get
   flutter analyze
   flutter run
   ```
4. APK তৈরির জন্য:
   ```bash
   flutter build apk --release
   ```
5. তৈরি APK সাধারণত `build/app/outputs/flutter-apk/app-release.apk`-এ থাকবে।

## GitHub-এ আপলোড
GitHub-এ নতুন repository তৈরি করে এই ZIP-এর ফাইলগুলো extract করে repository root-এ upload করুন। ZIP-টিকে repository-তে শুধু একটি ZIP হিসেবে রাখলে GitHub Actions সরাসরি Flutter source হিসেবে build করতে পারবে না—ফাইলগুলো extract করে আপলোড করতে হবে।

## কুরআন ডেটা ও API
- API documentation: https://legacy.alquran.cloud/api
- Quran audio CDN documentation: https://legacy.alquran.cloud/cdn

প্রকাশের আগে API-এর বর্তমান প্রাপ্যতা, নির্বাচিত অনুবাদের পরিচয়, পুনর্বিতরণের শর্ত, কপিরাইট ও ধর্মীয় নির্ভুলতা যাচাই করুন। নেটওয়ার্ক না থাকলে বর্তমান সংস্করণে কুরআন ডেটা লোড হবে না।

## Galaxy UI
বর্তমান রঙ: `#070B14`, `#111827`, emerald `#10B981`, cyan `#22D3EE`, gold `#FBBF24`।


## GitHub Actions দিয়ে APK বিল্ড
এই প্যাকেজে `.github/workflows/android.yml` আছে। ফাইলগুলো `main` বা `master` branch-এ upload/push করার পর GitHub-এর **Actions** ট্যাবে `Build Android APK` workflow চালু হবে। Build সফল হলে run-এর Artifacts থেকে `hifz-sathi-android-apk` ডাউনলোড করা যাবে। এটি build সফল হওয়ার নিশ্চয়তা নয়—Actions log-এ কোনো dependency বা compile error এলে সেটি ঠিক করতে হবে।
