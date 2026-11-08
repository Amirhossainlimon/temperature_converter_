
import 'package:flutter_test/flutter_test.dart';
import 'package:temperature_converter/main.dart';

void main() {
  testWidgets('Temperature Converter app loads successfully',
          (WidgetTester tester) async {
        await tester.pumpWidget(const TemperatureConverterApp());

        expect(find.text('Tempora'), findsOneWidget);
        expect(find.text('Temperature'), findsOneWidget);
        expect(find.text('Convert Temperature'), findsOneWidget);
      });

  testWidgets('Default temperature input is 72',
          (WidgetTester tester) async {
        await tester.pumpWidget(const TemperatureConverterApp());

        expect(find.text('72'), findsOneWidget);
      });
}
