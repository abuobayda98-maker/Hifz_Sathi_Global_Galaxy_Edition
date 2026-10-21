import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const HifzSathiApp());

const bg = Color(0xFF070B14);
const panel = Color(0xFF111827);
const emerald = Color(0xFF10B981);
const cyan = Color(0xFF22D3EE);
const gold = Color(0xFFFBBF24);

class HifzSathiApp extends StatelessWidget {
  const HifzSathiApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Hifz Sathi: Global Galaxy Edition',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(seedColor: emerald, brightness: Brightness.dark),
      useMaterial3: true,
      fontFamily: 'sans-serif',
      cardTheme: const CardThemeData(color: panel, elevation: 0),
    ),
    home: const GalaxyHome(),
  );
}

class GalaxyHome extends StatefulWidget {
  const GalaxyHome({super.key});
  @override
  State<GalaxyHome> createState() => _GalaxyHomeState();
}

class _GalaxyHomeState extends State<GalaxyHome> {
  int tab = 0;
  int completed = 0;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((p) {
      if (mounted) setState(() => completed = p.getInt('completed') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(completed: completed, onOpenQuran: () => setState(() => tab = 1)),
      const QuranPage(),
      const RevisionPage(),
      const ProgressPage(),
      const SettingsPage(),
    ];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF07152C), bg, Color(0xFF071D25)]),
        ),
        child: SafeArea(child: IndexedStack(index: tab, children: pages)),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF091321),
        indicatorColor: emerald.withValues(alpha: .18),
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'হোম'),
          NavigationDestination(icon: Icon(Icons.menu_book_rounded), label: 'কুরআন'),
          NavigationDestination(icon: Icon(Icons.autorenew_rounded), label: 'রিভিশন'),
          NavigationDestination(icon: Icon(Icons.insights_rounded), label: 'অগ্রগতি'),
          NavigationDestination(icon: Icon(Icons.settings_rounded), label: 'সেটিংস'),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final int completed;
  final VoidCallback onOpenQuran;
  const DashboardPage({super.key, required this.completed, required this.onOpenQuran});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      Row(children: [
        Container(width: 54, height: 54, decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(colors: [emerald, cyan]),
          boxShadow: [BoxShadow(color: cyan.withValues(alpha: .22), blurRadius: 18)],
        ), child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 29)),
        const SizedBox(width: 12),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('হিফজ সাথী', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          Text('Hifz Sathi • Global Galaxy Edition', style: TextStyle(color: cyan, fontSize: 11)),
        ])),
        const Icon(Icons.stars_rounded, color: gold, size: 28),
      ]),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: cyan.withValues(alpha: .55)),
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF123B55), Color(0xFF10223C), Color(0xFF092B2B)]),
          boxShadow: [BoxShadow(color: cyan.withValues(alpha: .10), blurRadius: 24)],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('আসসালামু আলাইকুম 👋', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          const Text('আজকের হিফজ যাত্রা', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('ছোট পদক্ষেপ, বড় স্বপ্ন—প্রতিদিন কুরআনের সঙ্গে থাকুন।'),
          const SizedBox(height: 18),
          ClipRRect(borderRadius: BorderRadius.circular(20), child: LinearProgressIndicator(
            value: (completed.clamp(0, 30)) / 30, minHeight: 9,
            backgroundColor: Colors.white12, color: emerald)),
          const SizedBox(height: 8),
          Text('$completed / 30 রিভিশন সেশন সম্পন্ন', style: const TextStyle(color: cyan)),
          const SizedBox(height: 14),
          FilledButton.icon(onPressed: onOpenQuran, icon: const Icon(Icons.menu_book),
            label: const Text('কুরআন পড়া শুরু করুন'),
            style: FilledButton.styleFrom(backgroundColor: emerald, foregroundColor: Colors.white)),
        ]),
      ),
      const SizedBox(height: 20),
      const Text('আপনার স্টাডি স্পেস', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.18,
        children: const [
          FeatureTile(icon: Icons.auto_awesome, title: '৩০ পারা', subtitle: 'কুরআন ব্রাউজ করুন', color: emerald),
          FeatureTile(icon: Icons.psychology_alt_rounded, title: 'হিফজ কুইজ', subtitle: 'মুখস্থ যাচাই', color: cyan),
          FeatureTile(icon: Icons.repeat_rounded, title: 'Revision Vault', subtitle: 'পুনরাবৃত্তির রুটিন', color: Color(0xFFC084FC)),
          FeatureTile(icon: Icons.emoji_events_rounded, title: 'অর্জন', subtitle: 'নিজের অগ্রগতি', color: gold),
        ]),
      const SizedBox(height: 14),
      OutlinedButton.icon(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizPage())),
        icon: const Icon(Icons.psychology_alt_rounded),
        label: const Text('হিফজ কুইজ অনুশীলন'),
        style: OutlinedButton.styleFrom(foregroundColor: cyan, side: BorderSide(color: cyan.withValues(alpha: .5)), padding: const EdgeInsets.all(14)),
      ),
      const SizedBox(height: 18),
      const Text('নোট: কুরআন ও অনুবাদ প্রথমবার লোড করতে ইন্টারনেট লাগবে। বাংলা অনুবাদের সংস্করণ প্রকাশের আগে যাচাই করুন।', style: TextStyle(color: Colors.white54, fontSize: 12)),
    ],
  );
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final Color color;
  const FeatureTile({super.key, required this.icon, required this.title, required this.subtitle, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: .45))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: color, size: 27), const SizedBox(height: 10),
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 11)),
    ]),
  );
}

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});
  @override
  State<QuranPage> createState() => _QuranPageState();
}
class _QuranPageState extends State<QuranPage> {
  List<dynamic> surahs = [];
  bool loading = true;
  String? error;
  final search = TextEditingController();
  @override
  void initState() { super.initState(); load(); }
  Future<void> load() async {
    try {
      final r = await http.get(Uri.parse('https://api.alquran.cloud/v1/surah')).timeout(const Duration(seconds: 20));
      if (r.statusCode != 200) throw Exception('সূরা তালিকা লোড হয়নি');
      final data = jsonDecode(r.body);
      if (data['code'] != 200) throw Exception('API response error');
      if (mounted) setState(() { surahs = data['data']; loading = false; error = null; });
    } catch (_) {
      if (mounted) setState(() { loading = false; error = 'ইন্টারনেট সংযোগ পরীক্ষা করে আবার চেষ্টা করুন।'; });
    }
  }
  @override
  void dispose() { search.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final filtered = surahs.where((s) {
      final q = search.text.trim().toLowerCase();
      return q.isEmpty || '${s['englishName']} ${s['name']} ${s['number']}'.toLowerCase().contains(q);
    }).toList();
    return Column(children: [
      const Padding(padding: EdgeInsets.fromLTRB(18, 20, 18, 12), child: Align(alignment: Alignment.centerLeft,
        child: Text('কুরআন শরীফ', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)))),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: TextField(
        controller: search, onChanged: (_) => setState(() {}),
        decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: 'সূরা খুঁজুন...',
          filled: true, fillColor: panel, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)),
      )),
      const SizedBox(height: 8),
      Expanded(child: loading ? const Center(child: CircularProgressIndicator(color: emerald))
        : error != null ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(error!, textAlign: TextAlign.center), const SizedBox(height: 12),
          FilledButton(onPressed: () { setState(() { loading = true; error = null; }); load(); }, child: const Text('আবার চেষ্টা করুন'))
        ]) : ListView.builder(padding: const EdgeInsets.all(12), itemCount: filtered.length, itemBuilder: (context, i) {
          final s = filtered[i];
          return Card(child: ListTile(
            leading: CircleAvatar(backgroundColor: emerald.withValues(alpha: .16), child: Text('${s['number']}', style: const TextStyle(color: emerald))),
            title: Text('${s['englishName']} • ${s['name']}', maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text('${s['englishNameTranslation']} • ${s['numberOfAyahs']} আয়াত'),
            trailing: const Icon(Icons.chevron_right, color: cyan),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SurahPage(number: s['number'], name: s['englishName']))),
          ));
        })),
    ]);
  }
}

class SurahPage extends StatefulWidget {
  final int number; final String name;
  const SurahPage({super.key, required this.number, required this.name});
  @override
  State<SurahPage> createState() => _SurahPageState();
}
class _SurahPageState extends State<SurahPage> {
  List<dynamic> arabic = [], bangla = [];
  bool loading = true; String? error;
  final tts = FlutterTts();
  @override
  void initState() { super.initState(); load(); }
  Future<void> load() async {
    try {
      // Resolve a currently available Bengali translation instead of assuming a fixed edition ID.
      final editionsResponse = await http.get(
        Uri.parse('https://api.alquran.cloud/v1/edition/language/bn'),
      ).timeout(const Duration(seconds: 20));
      if (editionsResponse.statusCode != 200) throw Exception('Edition list unavailable');
      final editionsJson = jsonDecode(editionsResponse.body);
      final available = (editionsJson['data'] as List? ?? []);
      final textEditions = available.where((e) => e['format'] == 'text').toList();
      if (textEditions.isEmpty) throw Exception('No Bengali translation edition');
      // Prefer a translation edition; API language list can contain several text types.
      final translationEditions = textEditions.where((e) =>
        (e['type'] ?? '').toString().toLowerCase().contains('translation')).toList();
      final chosen = translationEditions.isNotEmpty ? translationEditions.first : textEditions.first;
      final translationId = chosen['identifier'].toString();
      final url = Uri.parse('https://api.alquran.cloud/v1/surah/${widget.number}/editions/quran-uthmani,$translationId');
      final r = await http.get(url).timeout(const Duration(seconds: 25));
      if (r.statusCode != 200) throw Exception('Surah unavailable');
      final data = jsonDecode(r.body);
      final editions = data['data'] as List;
      if (editions.length < 2) throw Exception('Translation missing');
      if (mounted) setState(() { arabic = editions[0]['ayahs']; bangla = editions[1]['ayahs']; loading = false; });
    } catch (_) {
      if (mounted) setState(() { loading = false; error = 'কুরআন বা বাংলা অনুবাদ লোড হয়নি। ইন্টারনেট পরীক্ষা করে আবার চেষ্টা করুন। প্রকাশের আগে অনুবাদের নাম ও নির্ভুলতা যাচাই করুন।'; });
    }
  }
  Future<void> speak(String text) async {
    try {
      await tts.setLanguage('bn-BD');
      await tts.setSpeechRate(0.42);
      await tts.speak(text);
    } catch (_) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('এই ফোনে বাংলা TTS ভয়েস পাওয়া যায়নি।')));
    }
  }
  @override
  void dispose() { tts.stop(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.name), backgroundColor: bg),
    body: loading ? const Center(child: CircularProgressIndicator(color: emerald))
      : error != null ? Center(child: Padding(padding: const EdgeInsets.all(24), child: Text(error!, textAlign: TextAlign.center)))
      : ListView.builder(padding: const EdgeInsets.all(14), itemCount: arabic.length, itemBuilder: (context, i) {
        final a = arabic[i]; final b = i < bangla.length ? bangla[i] : null;
        final translation = b?['text']?.toString() ?? 'বাংলা অনুবাদ পাওয়া যায়নি।';
        return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(18), border: Border.all(color: cyan.withValues(alpha: .18))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('${widget.number}:${a['numberInSurah']}', style: const TextStyle(color: gold, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(a['text'] ?? '', textAlign: TextAlign.right, style: const TextStyle(fontSize: 27, height: 1.8, fontFamily: 'serif')),
            const SizedBox(height: 12),
            Text(translation, style: const TextStyle(fontSize: 16, height: 1.6)),
            Align(alignment: Alignment.centerRight, child: IconButton(
              tooltip: 'বাংলা অর্থ শুনুন', onPressed: () => speak(translation),
              icon: const Icon(Icons.volume_up_rounded, color: cyan))),
          ]),
        );
      }),
  );
}


class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override State<QuizPage> createState() => _QuizPageState();
}
class _QuizPageState extends State<QuizPage> {
  int index = 0;
  int? selected;
  int score = 0;
  final questions = const [
    {'q': 'কুরআনে মোট কতটি সূরা আছে?', 'answers': ['৩০টি', '১১৪টি', '৬০টি', '৯৯টি'], 'correct': 1},
    {'q': 'কুরআনের প্রথম সূরা কোনটি?', 'answers': ['আল-ফাতিহা', 'আল-বাকারা', 'আল-ইখলাস', 'আন-নাস'], 'correct': 0},
    {'q': 'কুরআনে মোট কতটি পারা আছে?', 'answers': ['১২টি', '২০টি', '৩০টি', '৪০টি'], 'correct': 2},
  ];
  @override Widget build(BuildContext context) {
    if (index >= questions.length) return Scaffold(
      appBar: AppBar(title: const Text('হিফজ কুইজ')),
      body: Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.emoji_events_rounded, color: gold, size: 60),
        const SizedBox(height: 16), Text('আপনার স্কোর: $score / ${questions.length}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16), FilledButton(onPressed: () => setState(() { index = 0; selected = null; score = 0; }), child: const Text('আবার খেলুন')),
      ]))),
    );
    final q = questions[index];
    final answers = q['answers'] as List<String>;
    return Scaffold(
      appBar: AppBar(title: const Text('হিফজ কুইজ'), backgroundColor: bg),
      body: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        LinearProgressIndicator(value: (index + 1) / questions.length, color: emerald, backgroundColor: Colors.white12),
        const SizedBox(height: 22), Text('প্রশ্ন ${index + 1} / ${questions.length}', style: const TextStyle(color: cyan)),
        const SizedBox(height: 12), Text(q['q'] as String, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 18),
        ...List.generate(answers.length, (i) => Padding(padding: const EdgeInsets.only(bottom: 10), child: OutlinedButton(
          onPressed: selected == null ? () => setState(() { selected = i; if (i == q['correct']) score++; }) : null,
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(14), foregroundColor: selected == i ? emerald : Colors.white),
          child: Align(alignment: Alignment.centerLeft, child: Text('${String.fromCharCode(65 + i)}. ${answers[i]}')),
        ))),
        if (selected != null) Text(selected == q['correct'] ? 'সঠিক উত্তর! আলহামদুলিল্লাহ।' : 'সঠিক উত্তর: ${answers[q['correct']]}', style: TextStyle(color: selected == q['correct'] ? emerald : gold)),
        const Spacer(),
        FilledButton(onPressed: selected == null ? null : () => setState(() { index++; selected = null; }), child: Text(index == questions.length - 1 ? 'ফলাফল দেখুন' : 'পরবর্তী প্রশ্ন')),
      ])),
    );
  }
}

class RevisionPage extends StatefulWidget { const RevisionPage({super.key}); @override State<RevisionPage> createState() => _RevisionPageState(); }
class _RevisionPageState extends State<RevisionPage> {
  int count = 0;
  @override void initState() { super.initState(); SharedPreferences.getInstance().then((p) { if (mounted) setState(() => count = p.getInt('completed') ?? 0); }); }
  Future<void> done() async { final p = await SharedPreferences.getInstance(); count++; await p.setInt('completed', count); if (mounted) setState(() {}); }
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const SizedBox(height: 14), const Text('Revision Vault', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
    const SizedBox(height: 8), const Text('প্রতিদিন অল্প অল্প করে পুরোনো মুখস্থ অংশ ঝালাই করুন।', style: TextStyle(color: Colors.white70)),
    const SizedBox(height: 22), FeatureTile(icon: Icons.autorenew_rounded, title: 'আজকের রিভিশন', subtitle: '$countটি সেশন সম্পন্ন', color: cyan),
    const SizedBox(height: 18), FilledButton.icon(onPressed: done, icon: const Icon(Icons.check_circle), label: const Text('একটি রিভিশন সম্পন্ন করুন'), style: FilledButton.styleFrom(backgroundColor: emerald)),
    const SizedBox(height: 12), const Text('এই প্রাথমিক সংস্করণে সেশন কাউন্টার স্থানীয়ভাবে সংরক্ষিত হয়। পূর্ণ হিফজ শিডিউল পরবর্তী ধাপে যোগ করতে হবে.', style: TextStyle(color: Colors.white54, fontSize: 12)),
  ]));
}

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const SizedBox(height: 10), const Text('আমার অগ্রগতি', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
    const SizedBox(height: 20), Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(22), border: Border.all(color: emerald.withValues(alpha: .4))),
      child: const Column(children: [Icon(Icons.insights_rounded, color: emerald, size: 42), SizedBox(height: 12), Text('আপনার যাত্রা শুরু হয়েছে', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)), SizedBox(height: 8), Text('রিভিশন সম্পন্ন করলে আপনার সেশন সংখ্যা ড্যাশবোর্ডে দেখা যাবে.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70))])),
    const SizedBox(height: 18), const FeatureTile(icon: Icons.emoji_events_rounded, title: 'Galaxy Achievements', subtitle: 'পরবর্তী সংস্করণে ব্যাজ ও স্ট্রিক', color: gold),
  ]);
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const SizedBox(height: 10), const Text('সেটিংস', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
    const SizedBox(height: 16),
    const ListTile(leading: Icon(Icons.language, color: cyan), title: Text('ভাষা'), subtitle: Text('বাংলা UI • আরবি কুরআন')),
    const ListTile(leading: Icon(Icons.record_voice_over, color: emerald), title: Text('বাংলা ভয়েস'), subtitle: Text('ডিভাইসের Text-to-Speech ইঞ্জিন ব্যবহার করে; উপলব্ধতা ফোনভেদে আলাদা।')),
    const ListTile(leading: Icon(Icons.cloud_download, color: gold), title: Text('কুরআন ডেটা'), subtitle: Text('AlQuran Cloud API থেকে অনলাইনে লোড হয়।')),
    const ListTile(leading: Icon(Icons.verified_user, color: cyan), title: Text('ডেটা যাচাই'), subtitle: Text('প্রকাশের আগে অনুবাদ, অডিও, লাইসেন্স ও অফলাইন ক্যাশিং যাচাই করুন।')),
    const Divider(), const Text('Hifz Sathi: Global Galaxy Edition • Starter build', style: TextStyle(color: Colors.white54)),
  ]);
}
