import 'package:app_estoque_carne/models/carne.dart';
import 'package:app_estoque_carne/models/freezer.dart';
import 'package:app_estoque_carne/models/funcionario.dart';
import 'package:app_estoque_carne/services/carne_storage.dart';
import 'package:app_estoque_carne/services/freezer_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CadastroCarnePage extends StatefulWidget {
  final Funcionario funcionario;
  // Carne opcional para edição
  final Carne? carne;

  const CadastroCarnePage({super.key, required this.funcionario, this.carne});

  @override
  State<CadastroCarnePage> createState() => _CadastroCarnePageState();
}

class _CadastroCarnePageState extends State<CadastroCarnePage> {
  final TextEditingController _nomeCarneController = TextEditingController();
  // final TextEditingController _nomeFreezerController = TextEditingController();
  DateTime? _dataValidade;
  List<Freezer> _freezers = [];
  Freezer? _freezerSelecionado;

  void _salvarCarne() async {
    final nome = _nomeCarneController.text.trim();

    if (nome.isNotEmpty &&
        _freezerSelecionado != null &&
        _dataValidade != null) {
      final carne = Carne(
        id: widget.carne?.id ?? const Uuid().v4(),
        nome: nome,
        freezerId: _freezerSelecionado!.id,
        dataValidade: _dataValidade!,
        funcionario: widget.funcionario.nome,
      );

      await CarneStorage.salvarOuAtualizarCarne(carne);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.carne != null
                ? 'Carne editada com sucesso!'
                : 'Carne cadastrada com sucesso!',
          ),
        ),
      );

      Navigator.pop(context);
    }
  }

  Future<void> _selecionarData() async {
    final dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (dataSelecionada != null) {
      setState(() {
        _dataValidade = dataSelecionada;
      });
    }
  }

  Future<void> _adicionarNovoFreezer() async {
    final nomeController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar Freezer'),
        content: TextField(
          controller: nomeController,
          decoration: InputDecoration(labelText: 'Nome do Freezer'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Cancelar')),
          TextButton(
            onPressed: () async {
              final nome = nomeController.text.trim();
              if (nome.isNotEmpty) {
                final novoFreezer = Freezer(id: const Uuid().v4(), nome: nome);
                await FreezerStorage.adicionarFreezer(novoFreezer);
                Navigator.pop(context);
                await _carregarFreezers();
                setState(() {
                  _freezerSelecionado = novoFreezer;
                });
              }
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Future<void> _editarFreezerSelecionado() async {
    if (_freezerSelecionado == null) return;

    final controller = TextEditingController(text: _freezerSelecionado!.nome);

    final confirmado = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Editar Freezer'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Salvar')),
        ],
      ),
    );

    if (confirmado ?? false) {
      final novoNome = controller.text.trim();
      if (novoNome.isNotEmpty) {
        final atualizado = Freezer(
          id: _freezerSelecionado!.id,
          nome: novoNome,
        );
        await FreezerStorage.atualizarFreezer(atualizado);
        await _carregarFreezers();
        setState(() {
          _freezerSelecionado = atualizado;
        });
      }
    }
  }

  Future<void> _removerFreezerSelecionado() async {
    if (_freezerSelecionado == null) return;

    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Remover Freezer'),
        content:
            Text('Deseja remover o freezer "${_freezerSelecionado!.nome}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Remover')),
        ],
      ),
    );

    if (confirmar ?? false) {
      await FreezerStorage.removerFreezer(_freezerSelecionado!.id);
      await _carregarFreezers();
      setState(() {
        _freezerSelecionado = null;
      });
    }
  }

  Future<void> _carregarFreezers() async {
    final freezers = await FreezerStorage.carregarFreezers();
    setState(() {
      _freezers = freezers;

      if (widget.carne != null) {
        _freezerSelecionado = freezers.firstWhere(
          (f) => f.id == widget.carne!.freezerId,
          orElse: () => Freezer(
              id: widget.carne!.freezerId, nome: 'Freezer não encontrado'),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _carregarFreezers();

    if (widget.carne != null) {
      _nomeCarneController.text = widget.carne!.nome;
      _dataValidade = widget.carne!.dataValidade;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.carne != null ? 'Editar Carne' : 'Cadastrar Carne')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeCarneController,
              decoration: InputDecoration(labelText: 'Nome da Carne'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DropdownButtonFormField<Freezer>(
                  value: _freezerSelecionado,
                  decoration: InputDecoration(labelText: 'Selecionar Freezer'),
                  items: _freezers.map((freezer) {
                    return DropdownMenuItem(
                      value: freezer,
                      child: Text(freezer.nome),
                    );
                  }).toList(),
                  onChanged: (valor) {
                    setState(() {
                      _freezerSelecionado = valor;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      tooltip: 'Adicionar Freezer',
                      onPressed: _adicionarNovoFreezer,
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      tooltip: 'Editar Freezer',
                      onPressed: _editarFreezerSelecionado,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      tooltip: 'Remover Freezer',
                      onPressed: _removerFreezerSelecionado,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Validade: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(_dataValidade == null
                      ? 'Selecione ao lado'
                      : '${_dataValidade!.day}/${_dataValidade!.month}/${_dataValidade!.year}'),
                ),
                TextButton.icon(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _selecionarData,
                  label: Text('Selecionar Data'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvarCarne,
              child: Text('Salvar Carne'),
            )
          ],
        ),
      ),
    );
  }
}
