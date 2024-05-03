import 'package:flutter/material.dart';

class NewUserForm extends StatefulWidget {
  const NewUserForm({super.key});

  @override
  State<NewUserForm> createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Usuario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align labels to left
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0), // Add spacing between fields
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress, // Set keyboard type
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu email.';
                  } else if (!value.isValidEmail) {
                    return 'Por favor ingresa una dirección de correo válida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0), // Add spacing between fields
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Hide password characters
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0), // Add spacing between fields
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Hide password characters
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor confirma tu contraseña.';
                  } else if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0), // Add spacing after last field
              Row(
                // Wrap button in a Row for centering
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the button
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission logic here
                        // You can access form values using controllers (e.g., _nameController.text)
                        print('Nombre: ${_nameController.text}');
                        print('Email: ${_emailController.text}');
                        print('Contraseña: ${_passwordController.text}');
                        // Implement logic to submit data (e.g., API call, database)

                        // String name = _nameController.text;
                        // String email = _emailController.text;
                        // String password = _passwordController.text;
                      }
                    },
                    child: Text('Crear Cuenta'),
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

// Extension method for email validation (replace with your actual validation logic)
extension EmailValidator on String {
  bool get isValidEmail {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
        .hasMatch(this);
  }
}
