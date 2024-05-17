import 'package:contacts_app/common/input.dart';
import 'package:dio/dio.dart';
import 'package:contacts_app/pages/auth/sing_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({}); // Configuración inicial para SharedPreferences

  group('SingInPage Widget Tests', () {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);

    setUp(() {
      // Configura el adaptador mock para http
      dioAdapter.onPost('/token/', (server) {
        server.reply(200, {'access': 'dummy_access_token'});
      });
    });

    testWidgets('SignInPage navigates to home on valid credentials', (WidgetTester tester) async {
      // Configura las preferencias compartidas
      SharedPreferences.setMockInitialValues({});

      // Construye el widget
      await tester.pumpWidget(const MaterialApp(home: SingInPage()));

      // Ingresa datos de usuario correctos
      await tester.enterText(find.byType(InputWidget).at(0), 'correct_user');
      await tester.enterText(find.byType(InputWidget).at(1), 'correct_pass');
      await tester.tap(find.byType(IconButton));
      await tester.pump(); // Espera a que se procese el tap

      // Verifica que se navega a la página de inicio ("/")
      expect(find.byType(SingInPage), findsNothing); // La página actual ya no debe ser SingInPage
    });
  });
}
