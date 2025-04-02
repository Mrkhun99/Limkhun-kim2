import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY", // Replace with your actual key
      appId: "YOUR_APP_ID",   // Replace with your actual ID
      messagingSenderId: "YOUR_SENDER_ID",
      projectId: "g1-testing-cb625",
      databaseURL: "https://g1-testing-cb625-default-rtdb.asia-southeast1.firebasedatabase.app",
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => FruitProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fruit Manager',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const FruitListScreen(),
    );
  }
}

class Fruit {
  final String id;
  final String name;
  final double price;
  final int amount;

  Fruit({
    required this.id,
    required this.name,
    required this.price,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'amount': amount,
  };

  factory Fruit.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map<dynamic, dynamic>;
    return Fruit(
      id: snapshot.key!,
      name: data['name']?.toString() ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      amount: (data['amount'] ?? 0).toInt(),
    );
  }
}

class FirebaseFruitRepository {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('fruits');

  Future<Fruit> addFruit({
    required String name,
    required double price,
    required int amount,
  }) async {
    final newRef = _dbRef.push();
    await newRef.set({
      'name': name,
      'price': price,
      'amount': amount,
    });
    return Fruit(
      id: newRef.key!,
      name: name,
      price: price,
      amount: amount,
    );
  }

  Future<List<Fruit>> getFruits() async {
    try {
      final snapshot = await _dbRef.get();
      if (!snapshot.exists) return [];
      
      return snapshot.children
          .map((child) => Fruit.fromSnapshot(child))
          .toList();
    } catch (e) {
      throw Exception('Failed to load fruits: $e');
    }
  }

  Future<void> removeFruit(String id) async => await _dbRef.child(id).remove();
}

class FruitProvider extends ChangeNotifier {
  final FirebaseFruitRepository _repository = FirebaseFruitRepository();
  List<Fruit> _fruits = [];
  bool _isLoading = true;
  String? _error;

  List<Fruit> get fruits => _fruits;
  bool get isLoading => _isLoading;
  String? get error => _error;

  FruitProvider() {
    loadFruits();
  }

  Future<void> loadFruits() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _fruits = await _repository.getFruits();
      debugPrint('Loaded ${_fruits.length} fruits'); // Debug log
    } catch (e) {
      _error = e.toString();
      debugPrint('Error loading fruits: $_error'); // Debug log
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFruit(String name, double price, int amount) async {
    try {
      await _repository.addFruit(name: name, price: price, amount: amount);
      await loadFruits();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> removeFruit(String id) async {
    try {
      await _repository.removeFruit(id);
      await loadFruits();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}

class FruitForm extends StatefulWidget {
  const FruitForm({super.key});

  @override
  State<FruitForm> createState() => _FruitFormState();
}

class _FruitFormState extends State<FruitForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Fruit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Fruit Name'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required';
                  return double.tryParse(value!) == null ? 'Invalid number' : null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required';
                  return int.tryParse(value!) == null ? 'Invalid number' : null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await Provider.of<FruitProvider>(context, listen: false).addFruit(
                      _nameController.text,
                      double.parse(_priceController.text),
                      int.parse(_amountController.text),
                    );
                    if (mounted) Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Add Fruit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FruitListScreen extends StatelessWidget {
  const FruitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fruitProvider = Provider.of<FruitProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FruitForm()),
            ),
          ),
        ],
      ),
      body: _buildBody(context, fruitProvider),
      floatingActionButton: fruitProvider.error != null
          ? FloatingActionButton(
              onPressed: fruitProvider.loadFruits,
              child: const Icon(Icons.refresh),
            )
          : null,
    );
  }

  Widget _buildBody(BuildContext context, FruitProvider fruitProvider) {
    if (fruitProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (fruitProvider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${fruitProvider.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fruitProvider.loadFruits,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (fruitProvider.fruits.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 48),
            SizedBox(height: 16),
            Text('No fruits available'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: fruitProvider.fruits.length,
      itemBuilder: (context, index) {
        final fruit = fruitProvider.fruits[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(fruit.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('Price: \$${fruit.price.toStringAsFixed(2)}'),
                Text('Stock: ${fruit.amount}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => fruitProvider.removeFruit(fruit.id),
            ),
          ),
        );
      },
    );
  }
}