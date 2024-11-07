import 'package:flutter/material.dart';
import 'package:app/DatabaseHelper.dart';
import 'package:app/model/Carro.dart';
import 'package:app/model/Destino.dart';
import 'package:app/model/PrecoCombustivel.dart';
import 'package:app/AddDados.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Viagem',
      home: ViagemPage(),
    );
  }
}

class ViagemPage extends StatefulWidget {
  const ViagemPage({super.key});

  @override
  _ViagemPageState createState() => _ViagemPageState();
}

class _ViagemPageState extends State<ViagemPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  Carro? carroSelecionado;
  Destino? destinoSelecionado;
  PrecoCombustivel? precoSelecionado;

  List<Carro> _carros = [];
  List<Destino> _destinos = [];
  List<PrecoCombustivel> _precos = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    _carros = await _databaseHelper.getCarros();
    _destinos = await _databaseHelper.getDestinos();
    _precos = await _databaseHelper.getPrecos();
    setState(() {});
  }

  double calcularGastoViagem(Carro carro, Destino destino, PrecoCombustivel preco) {
    double litrosNecessarios = destino.distancia / carro.autonomia;
    return litrosNecessarios * preco.preco;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Viagem'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdicionarDadosPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<Carro>(
              hint: const Text("Selecione o carro"),
              value: carroSelecionado,
              onChanged: (Carro? novoCarro) {
                setState(() {
                  carroSelecionado = novoCarro;
                });
              },
              items: _carros.map((Carro carro) {
                return DropdownMenuItem<Carro>(
                  value: carro,
                  child: Text(carro.modelo),
                );
              }).toList(),
            ),
            DropdownButton<Destino>(
              hint: const Text("Selecione o destino"),
              value: destinoSelecionado,
              onChanged: (Destino? novoDestino) {
                setState(() {
                  destinoSelecionado = novoDestino;
                });
              },
              items: _destinos.map((Destino destino) {
                return DropdownMenuItem<Destino>(
                  value: destino,
                  child: Text(destino.nome),
                );
              }).toList(),
            ),
            DropdownButton<PrecoCombustivel>(
              hint: const Text("Selecione o preço do combustível"),
              value: precoSelecionado,
              onChanged: (PrecoCombustivel? novoPreco) {
                setState(() {
                  precoSelecionado = novoPreco;
                });
              },
              items: _precos.map((PrecoCombustivel preco) {
                return DropdownMenuItem<PrecoCombustivel>(
                  value: preco,
                  child: Text('${preco.tipo}: R\$ ${preco.preco}'),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (carroSelecionado != null && destinoSelecionado != null && precoSelecionado != null) {
                  double gasto = calcularGastoViagem(carroSelecionado!, destinoSelecionado!, precoSelecionado!);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Custo da Viagem'),
                      content: Text('O custo será: R\$ $gasto'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Fechar'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Calcular Custo'),
            ),
          ],
        ),
      ),
    );
  }
}
