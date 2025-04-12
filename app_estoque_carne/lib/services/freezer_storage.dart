import 'package:app_estoque_carne/models/freezer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreezerStorage {
  static const String _key = 'Freezers_sabor_morte';

  static Future<List<Freezer>> carregarFreezers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);
    if (jsonStr == null) return [];
    return Freezer.decode(jsonStr);
  }

  static Future<void> salvarFreezers(List<Freezer> freezers) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = Freezer.encode(freezers);
    await prefs.setString(_key, jsonStr);
  }

  static Future<void> adicionarFreezer(Freezer nova) async {
    final freezers = await carregarFreezers();
    freezers.add(nova);
    await salvarFreezers(freezers);
  }

  static Future<void> atualizarFreezer(Freezer atualizado) async {
    final lista = await carregarFreezers();
    final index = lista.indexWhere((f) => f.id == atualizado.id);
    if (index != -1) {
      lista[index] = atualizado;
      await salvarFreezers(lista);
    }
  }

  static Future<void> removerFreezer(String id) async {
    final lista = await carregarFreezers();
    lista.removeWhere((f) => f.id == id);
    await salvarFreezers(lista);
  }
}
