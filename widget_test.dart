import 'package:flutter_test/flutter_test.dart';
import 'package:hifz_sathi_global/main.dart';

void main() {
  testWidgets('Hifz Sathi dashboard renders', (tester) async {
    await tester.pumpWidget(const HifzSathiApp());
    expect(find.text('হিফজ সাথী'), findsOneWidget);
    expect(find.text('Hifz Sathi • Global Galaxy Edition'), findsOneWidget);
  });
}
