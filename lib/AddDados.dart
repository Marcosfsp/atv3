import 'package:flutter/material.dart';
import 'package:app/DatabaseHelper.dart';
import 'package:app/model/Carro.dart';
import 'package:app/model/Destino.dart';
import 'package:app/model/PrecoCombustivel.dart';

class AdicionarDadosPage extends StatefulWidget {
  final Future<void> Function() func1;
  const AdicionarDadosPage({super.key, required this.func1});

  @override
  _AdicionarDadosPageState createState() => _AdicionarDadosPageState();
}

class _AdicionarDadosPageState extends State<AdicionarDadosPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _autonomiaController = TextEditingController();
  final TextEditingController _nomeDestinoController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _tipoCombustivelController =
      TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  void _adicionarCarro() async {
    final String modelo = _modeloController.text;
    final double autonomia = double.tryParse(_autonomiaController.text) ?? 0.0;

    if (modelo.isNotEmpty && autonomia > 0) {
      await _databaseHelper
          .insertCarro(Carro(modelo: modelo, autonomia: autonomia));
      _modeloController.clear();
      _autonomiaController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Carro adicionado!')));
    }
  }

  void _adicionarDestino() async {
    final String nome = _nomeDestinoController.text;
    final double distancia = double.tryParse(_distanciaController.text) ?? 0.0;

    if (nome.isNotEmpty && distancia > 0) {
      await _databaseHelper
          .insertDestino(Destino(nome: nome, distancia: distancia));
      _nomeDestinoController.clear();
      _distanciaController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Destino adicionado!')));
    }
  }

  void _adicionarPreco() async {
    final String tipo = _tipoCombustivelController.text;
    final double preco = double.tryParse(_precoController.text) ?? 0.0;

    if (tipo.isNotEmpty && preco > 0) {
      await _databaseHelper.insertPreco(
          PrecoCombustivel(tipo: tipo, preco: preco, data: DateTime.now()));
      _tipoCombustivelController.clear();
      _precoController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Preço de combustível adicionado!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Dados'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.func1();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: 'Modelo do Carro'),
              ),
              TextField(
                controller: _autonomiaController,
                decoration:
                    const InputDecoration(labelText: 'Autonomia (km/L)'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: _adicionarCarro,
                child: const Text('Adicionar Carro'),
              ),
              const Divider(),
              TextField(
                controller: _nomeDestinoController,
                decoration: const InputDecoration(labelText: 'Nome do Destino'),
              ),
              TextField(
                controller: _distanciaController,
                decoration: const InputDecoration(labelText: 'Distância (km)'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: _adicionarDestino,
                child: const Text('Adicionar Destino'),
              ),
              const Divider(),
              TextField(
                controller: _tipoCombustivelController,
                decoration:
                    const InputDecoration(labelText: 'Tipo de Combustível'),
              ),
              TextField(
                controller: _precoController,
                decoration: const InputDecoration(labelText: 'Preço por Litro'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: _adicionarPreco,
                child: const Text('Adicionar Preço de Combustível'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
