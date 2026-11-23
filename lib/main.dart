import 'package:flutter/material.dart';

void main() => runApp(const ShoppingListApp());

class ShoppingListApp extends StatelessWidget {
  const ShoppingListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alışveriş Listem',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const ShoppingListPage(),
    );
  }
}

class ShoppingItem {
  ShoppingItem({required this.id, required this.name});

  final int id;
  final String name;
  bool purchased = false;
}

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final TextEditingController _controller = TextEditingController();
  final List<ShoppingItem> _items = [];
  int _nextId = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addItem() {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ürün adı boş olamaz')),
      );
      return;
    }

    setState(() {
      _items.add(ShoppingItem(id: _nextId++, name: name));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alışveriş Listem')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('item_input'),
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Ürün adı',
                      hintText: 'Örn. Süt',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  key: const Key('add_button'),
                  onPressed: _addItem,
                  child: const Text('Ekle'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _items.isEmpty
                  ? const Center(child: Text('Henüz ürün yok'))
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return Card(
                          child: Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  key: Key('toggle_${item.id}'),
                                  title: Text(
                                    item.name,
                                    style: TextStyle(
                                      decoration: item.purchased
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                  value: item.purchased,
                                  onChanged: (value) => setState(
                                    () => item.purchased = value ?? false,
                                  ),
                                ),
                              ),
                              IconButton(
                                key: Key('delete_${item.id}'),
                                tooltip: 'Sil',
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => setState(
                                  () => _items.removeWhere(
                                    (element) => element.id == item.id,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
