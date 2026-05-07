import 'package:flutter/material.dart';

void main() => runApp(const AppEdad());

class AppEdad extends StatelessWidget {
  const AppEdad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Edad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const PantallaEdad(),
    );
  }
}

class PantallaEdad extends StatefulWidget {
  const PantallaEdad({super.key});

  @override
  State<PantallaEdad> createState() => _PantallaEdadState();
}

class _PantallaEdadState extends State<PantallaEdad> {
  final TextEditingController _controller = TextEditingController();

  int? _edad;
  String? _error;

  void _calcular() {
    final texto = _controller.text.trim();
    final anio = int.tryParse(texto);
    final anioActual = DateTime.now().year;

    setState(() {
      if (texto.isEmpty) {
        _error = 'Ingrese su año de nacimiento';
        _edad = null;
      } else if (anio == null) {
        _error = 'Ingrese solo números';
        _edad = null;
      } else if (anio < 1900 || anio > anioActual) {
        _error = 'El año debe estar entre 1900 y $anioActual';
        _edad = null;
      } else {
        _error = null;
        _edad = anioActual - anio;
      }
    });
  }

  void _limpiar() {
    setState(() {
      _controller.clear();
      _edad = null;
      _error = null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Edad'),
        backgroundColor: colors.primaryContainer,
        foregroundColor: colors.onPrimaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Año de nacimiento',
                helperText: 'Ejemplo: 2004',
                errorText: _error,
                prefixIcon: const Icon(Icons.cake),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _calcular,
              icon: const Icon(Icons.calculate),
              label: const Text('Calcular edad'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _limpiar,
              icon: const Icon(Icons.clear),
              label: const Text('Limpiar'),
            ),
            const SizedBox(height: 24),
            if (_edad != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Tu edad es de $_edad años',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}