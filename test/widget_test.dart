import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex_dell/app/app_module.dart';
import 'package:pokedex_dell/app/app_widget.dart';


void main() {
  testWidgets('App loads AppWidget via ModularApp', (WidgetTester tester) async {
    final widget = ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(AppWidget), findsOneWidget);

  });
}
