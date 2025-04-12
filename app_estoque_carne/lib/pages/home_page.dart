import 'package:app_estoque_carne/models/carne.dart';
import 'package:app_estoque_carne/models/freezer.dart';
import 'package:app_estoque_carne/models/funcionario.dart';
import 'package:app_estoque_carne/pages/cadastro_carne_page.dart';
import 'package:app_estoque_carne/services/carne_storage.dart';
import 'package:app_estoque_carne/services/freezer_storage.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class HomePage extends StatefulWidget {
  final Funcionario funcionario;

  const HomePage({super.key, required this.funcionario});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _temCarneProximaDoVencimento = false;
  bool _ordenarPorDataValidade = false;

  List<Carne> _carnes = [];
  List<Freezer> _freezers = [];

  @override
  void initState() {
    super.initState();
    _carregarFreezers();
    _carregarCarnes();
    _verificarAlertas();
  }

  Future<void> _carregarCarnes() async {
    final carnes = await CarneStorage.carregarCarnes();
    setState(() {
      _carnes = carnes;
    });
  }

  Future<void> _carregarFreezers() async {
    final freezers = await FreezerStorage.carregarFreezers();
    setState(() {
      _freezers = freezers;
    });
  }

  void _alternarOrdenacao() {
    setState(() {
      _ordenarPorDataValidade = !_ordenarPorDataValidade;
    });
  }

  Color _corParaValidade(Carne carne) {
    switch (carne.corValidade) {
      case 'preto':
        return Colors.black45;

      case 'verde':
      default:
        return Colors.green[300]!;
    }
  }

  Future<void> _verificarAlertas() async {
    final carnes = await CarneStorage.carregarCarnes();
    final alerta = carnes.any((carne) => carne.estaProximaDoVencimento);
    setState(() {
      _temCarneProximaDoVencimento = alerta;
    });
  }

  void _irParaCadastro(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CadastroCarnePage(funcionario: widget.funcionario),
      ),
    ).then((_) {
      _carregarFreezers();
      _carregarCarnes();
      _verificarAlertas();
    }); // Recarrega alerta ao voltar
  }

  void _irParaEdicao(Carne carne) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroCarnePage(
          funcionario: widget.funcionario,
          carne: carne,
        ),
      ),
    ).then((_) {
      _carregarFreezers();
      _carregarCarnes();
      _verificarAlertas();
    });
  }

  String obterNomeFreezer(String freezerId) {
    final freezer = _freezers.firstWhere((f) => f.id == freezerId,
        orElse: () => Freezer(id: '', nome: 'Desconhecido'));
    return freezer.nome;
  }

  @override
  Widget build(BuildContext context) {
    List<Carne> carnesParaExibir = [..._carnes];

    if (_ordenarPorDataValidade) {
      carnesParaExibir.sort((a, b) => a.dataValidade.compareTo(b.dataValidade));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${widget.funcionario.nome}'),
        actions: [
          if (_temCarneProximaDoVencimento)
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                Symbols.skull_list,
                size: 30,
              ),
              tooltip: 'Ordenar por validade',
              onPressed: _alternarOrdenacao,
            ),
          ),
        ],
      ),
      body: carnesParaExibir.isEmpty
          ? Center(child: Text('Nenhuma carne cadastrada ainda.'))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_temCarneProximaDoVencimento)
                  Container(
                    width: double.infinity,
                    color: Colors.redAccent,
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.warning, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            'Atenção! Há carnes próximas do vencimento.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: carnesParaExibir.length,
                    itemBuilder: (context, index) {
                      final carne = carnesParaExibir[index];
                      return Dismissible(
                        key: Key(carne.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          padding: EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.delete_sweep, color: Colors.white),
                        ),
                        onDismissed: (_) async {
                          setState(() {
                            _carnes.removeWhere((c) => c.id == carne.id);
                          });

                          await CarneStorage.salvarCarnes(_carnes);
                          await _verificarAlertas();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('${carne.nome} removida com sucesso')),
                          );
                        },
                        child: InkWell(
                          onTap: () {
                            _irParaEdicao(carne);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: _corParaValidade(carne),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(carne.nome,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: carne.estaProximaDoVencimento
                                              ? Colors.white
                                              : Colors.black,
                                        )),
                                    Text(
                                        'Freezer: ${obterNomeFreezer(carne.freezerId)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: carne.estaProximaDoVencimento
                                              ? Colors.white
                                              : Colors.black,
                                        )),
                                    Text(
                                      'Validade: ${carne.dataValidade.day}/${carne.dataValidade.month}/${carne.dataValidade.year}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: carne.estaProximaDoVencimento
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Responsável: ${carne.funcionario}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: carne.estaProximaDoVencimento
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                carne.estaProximaDoVencimento
                                    ? Image.asset('assets/images/morte.png',
                                        width: 80, height: 80)
                                    : SizedBox.shrink()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[800],
          foregroundColor: Colors.white,
          onPressed: () => _irParaCadastro(context),
          tooltip: 'Cadastrar Carne',
          // child: Icon(Icons.add),
          child: Image.asset(
            'assets/images/meat.png',
            width: 25,
            height: 25,
            color: Colors.white,
          )),
    );
  }
}
