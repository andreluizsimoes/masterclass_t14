// lib/services/carne_storage.dart
import 'package:app_estoque_carne/models/carne.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarneStorage {
  static const String _key = 'carnes_sabor_morte';

  static Future<List<Carne>> carregarCarnes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);
    if (jsonStr == null) return [];
    return Carne.decode(jsonStr);
  }

  static Future<void> salvarCarnes(List<Carne> carnes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = Carne.encode(carnes);
    await prefs.setString(_key, jsonStr);
  }

  static Future<void> adicionarCarne(Carne nova) async {
    final carnes = await carregarCarnes();
    carnes.add(nova);
    await salvarCarnes(carnes);
  }

  static Future<void> salvarOuAtualizarCarne(Carne carne) async {
    final carnes = await carregarCarnes();
    final index = carnes.indexWhere((c) => c.id == carne.id);

    if (index != -1) {
      carnes[index] = carne; // Atualiza
    } else {
      carnes.add(carne); // Adiciona nova
    }

    await salvarCarnes(carnes);
  }
}
