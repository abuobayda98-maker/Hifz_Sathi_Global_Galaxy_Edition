# পরবর্তী ধাপের রোডম্যাপ

## P0 — Build & verification
- Flutter SDK version নির্ধারণ; `flutter pub get`, `flutter analyze`, Android build চালানো।
- API থেকে Arabic edition ও সঠিক Bengali translation edition ID যাচাই।
- আরবি টেক্সট/বাংলা অনুবাদ নমুনা ধর্মীয় ও ভাষাগতভাবে যাচাই।
- ফোনের Android TTS engine-এ Bengali voice পরীক্ষা।

## P1 — Quran experience
- সূরা/পারা/পৃষ্ঠা নেভিগেশন, বুকমার্ক, সর্বশেষ পড়া স্থান।
- যাচাইকৃত আরবি + বাংলা অনুবাদ cache/offline storage।
- কুরআন তিলাওয়াত অডিও প্লেয়ার; reciter নির্বাচন; download controls।
- অডিও ও অনুবাদের উৎস/লাইসেন্স স্ক্রিন।

## P2 — Hifz features
- দৈনিক হিফজ লক্ষ্য, revision scheduler, ভুল/দুর্বল আয়াতের তালিকা।
- quiz প্রশ্নের যাচাইকৃত কনটেন্ট।
- local profile; পরে secure sign-in ও cloud sync।

## P3 — Family & global
- অভিভাবক/শিক্ষক ড্যাশবোর্ড; শিশুর privacy ও consent।
- ভাষা ও accessibility options।
- AI recitation assessment কেবল যথাযথ speech model, consent, security ও validation থাকলে।

## Voice recording policy
নির্দিষ্ট বাংলাদেশি ব্যক্তির রেকর্ডিং কেবল প্রকৃত অডিও, প্রমাণযোগ্য উৎস, ব্যবহারের অনুমতি এবং প্রযোজ্য লাইসেন্স যাচাই করে যুক্ত করতে হবে। অনুমতি না থাকলে Android Bengali TTS বা স্পষ্ট লাইসেন্সযুক্ত বিকল্প ব্যবহার করুন।
