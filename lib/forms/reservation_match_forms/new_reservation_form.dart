import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:second_service/forms/reservation_match_forms/reservation_provider.dart';

class NewReservationForm extends StatefulWidget {
  final int fieldNumber; // Pass field number from FieldSchedule

  const NewReservationForm({
    Key? key,
    required this.fieldNumber,
  }) : super(key: key);

  @override
  State<NewReservationForm> createState() => _NewReservationFormState();
}

class _NewReservationFormState extends State<NewReservationForm> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _titleController = TextEditingController();
  final _dateController =
      TextEditingController(); // Assume date picker implementation
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Reserva'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el título de la reserva.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _dateController,
                readOnly: true, // Disable manual date entry
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023), // Adjust as needed
                    lastDate: DateTime(2040), // Adjust as needed
                  );
                  if (selectedDate != null) {
                    // Update _dateController.text with formatted date
                    final formattedDate =
                        DateFormat('y-MM-d').format(selectedDate);
                    _dateController.text = formattedDate;
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                  alignLabelWithHint:
                      true, // Adjust label position for larger descriptions
                ),
                maxLines: null, // Allow multiline input for descriptions
              ),
              SizedBox(height: 10.0),
              Text(
                'Cancha: ${widget.fieldNumber}', // Display field number
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final provider = Provider.of<ReservationProvider>(
                            context,
                            listen: false);
                        await provider.createReservation(
                          title: _titleController.text,
                          date: _dateController.text,
                          description: _descriptionController.text,
                          fieldNumber: widget.fieldNumber,
                        );
                        // Handle success or error (e.g., navigate back or show confirmation)
                        Navigator.pop(
                            context); // Assuming you want to pop back after successful creation
                      }
                    },
                    child: Text('Crear Reserva'),
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
