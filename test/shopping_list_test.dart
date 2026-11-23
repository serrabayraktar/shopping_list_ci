import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_ci/main.dart';

void main() {
  testWidgets('Uygulama boş listeyle açılır', (tester) async {
    await tester.pumpWidget(const ShoppingListApp());
    expect(find.text('Henüz ürün yok'), findsOneWidget);
  });

  testWidgets('Ürün eklenebilir', (tester) async {
    await tester.pumpWidget(const ShoppingListApp());
    await tester.enterText(find.byKey(const Key('item_input')), 'Süt');
    await tester.tap(find.byKey(const Key('add_button')));
    await tester.pump();
    expect(find.text('Süt'), findsOneWidget);
    expect(find.text('Henüz ürün yok'), findsNothing);
  });

  testWidgets('Boş ürün eklenemez', (tester) async {
    await tester.pumpWidget(const ShoppingListApp());
    await tester.tap(find.byKey(const Key('add_button')));
    await tester.pump();
    expect(find.text('Ürün adı boş olamaz'), findsOneWidget);
    expect(find.text('Henüz ürün yok'), findsOneWidget);
  });

  testWidgets('Ürün alındı olarak işaretlenebilir', (tester) async {
    await tester.pumpWidget(const ShoppingListApp());
    await tester.enterText(find.byKey(const Key('item_input')), 'Ekmek');
    await tester.tap(find.byKey(const Key('add_button')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('toggle_0')));
    await tester.pump();
    final tile = tester.widget<CheckboxListTile>(
      find.byKey(const Key('toggle_0')),
    );
    expect(tile.value, isTrue);
  });

  testWidgets('Ürün silinebilir', (tester) async {
    await tester.pumpWidget(const ShoppingListApp());
    await tester.enterText(find.byKey(const Key('item_input')), 'Yumurta');
    await tester.tap(find.byKey(const Key('add_button')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('delete_0')));
    await tester.pump();
    expect(find.text('Yumurta'), findsNothing);
    expect(find.text('Henüz ürün yok'), findsOneWidget);
  });
}
