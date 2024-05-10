import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart'; // Import Provider package

// Import PlayersProvider
import 'players_provider.dart';

class NewPlayerForm extends StatefulWidget {
  const NewPlayerForm({Key? key}) : super(key: key);

  @override
  State<NewPlayerForm> createState() => _NewPlayerFormState();
}

class _NewPlayerFormState extends State<NewPlayerForm> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _membershipController = TextEditingController();
  String? _picturePath; // Path to the selected picture (optional)

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _membershipController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      final path = result.files.single.path;
      setState(() {
        _picturePath = path;
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Jugador'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del jugador.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el email del jugador.';
                  } else if (!value.isValidEmail) {
                    return 'Por favor ingresa una dirección de correo válida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _membershipController,
                decoration: InputDecoration(
                  labelText: 'Membresia',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la membresía del jugador.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Seleccionar Imagen'),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String name = _nameController.text;
                        String email = _emailController.text;
                        String membership = _membershipController.text;

                        try {
                          // Get instance of PlayersProvider using Provider.of
                          final playersProvider = Provider.of<PlayersProvider>(
                              context,
                              listen: false);
                          await playersProvider.addPlayer(
                              name, email, membership, File(_picturePath!));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Jugador añadido exitosamente'),
                          ));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error al añadir jugador: $e'),
                          ));
                        }
                      }
                    },
                    child: Text('Crear Jugador'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool get isValidEmail {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
        .hasMatch(this);
  }
}
