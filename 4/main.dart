import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Machine {
  final String name;
  final int power; // Consumo em Watts
  int usageTime; // Tempo de utilização em horas

  Machine(this.name, this.power, this.usageTime);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Machine> machines = [
    Machine('Torno', 1000, 0),
    Machine('Fresa', 1200, 0),
    Machine('Furadeira', 800, 0),
  ];

  int calculateTotalConsumption() {
    int totalConsumption = 0;
    for (var machine in machines) {
      totalConsumption += machine.power * machine.usageTime;
    }
    return totalConsumption;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumo de Energia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Máquinas Industriais'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: machines.map((machine) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(machine.name),
                    subtitle: Text('Consumo: ${machine.power}W'),
                    trailing: SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            machine.usageTime = int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                  ),
                  Text('Consumo: ${machine.power * machine.usageTime} Watts-hora'),
                  Divider(),
                ],
              );
            }).toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            int totalConsumption = calculateTotalConsumption();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Consumo Total de Energia'),
                  content: Text('O consumo total é de $totalConsumption Watts-hora.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.calculate),
        ),
      ),
    );
  }
}
