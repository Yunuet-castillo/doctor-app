import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoctorCitasPage extends StatefulWidget {
  final int doctorId;

  DoctorCitasPage({required this.doctorId});

  @override
  _DoctorCitasPageState createState() => _DoctorCitasPageState();
}

class _DoctorCitasPageState extends State<DoctorCitasPage> {
  List citas = [];
  bool loading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    obtenerCitas();
  }

  Future<void> obtenerCitas() async {
    try {
      final url =
          Uri.parse("http://192.168.15.183:8000/api/citas/${widget.doctorId}/");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          citas = json.decode(response.body);
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
          error = 'Error al cargar las citas: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
        error = 'Error de conexión: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Citas del Doctor"),
        backgroundColor: Colors.blue,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(error),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: obtenerCitas,
                        child: Text('Reintentar'),
                      ),
                    ],
                  ),
                )
              : citas.isEmpty
                  ? Center(child: Text('No hay citas disponibles'))
                  : ListView.builder(
                      itemCount: citas.length,
                      itemBuilder: (context, index) {
                        final cita = citas[index];
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: ListTile(
                            leading:
                                Icon(Icons.calendar_today, color: Colors.blue),
                            title: Text(cita['paciente'] ?? 'Sin nombre'),
                            subtitle: Text(
                                "Fecha: ${cita['fecha'] ?? 'Fecha no disponible'}"),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        );
                      },
                    ),
    );
  }
}
