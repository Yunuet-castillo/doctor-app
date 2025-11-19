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

  @override
  void initState() {
    super.initState();
    obtenerCitas();
  }

  Future<void> obtenerCitas() async {
    final url = Uri.parse("https://TUSERVIDOR/api/citas/${widget.doctorId}/");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        citas = json.decode(response.body);
        loading = false;
      });
    } else {
      setState(() => loading = false);
      print("Error en API: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Citas del Doctor")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: citas.length,
              itemBuilder: (context, index) {
                final cita = citas[index];
                return Card(
                  child: ListTile(
                    title: Text(cita['paciente']),
                    subtitle: Text("Fecha: ${cita['fecha']}"),
                  ),
                );
              },
            ),
    );
  }
}
