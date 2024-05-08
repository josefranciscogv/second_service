import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:provider/provider.dart'; // Import for Provider
import 'package:second_service/content/field_schedule/field_schedule_provider.dart';
import 'package:second_service/forms/reservation_match_forms/new_reservation_form.dart';

// Assuming your reservation provider is named FieldScheduleProvider

class FieldSchedule extends StatefulWidget {
  final String image;
  final String exchangeName;
  final String date; // Optional
  final int fieldNumber; // Field number

  const FieldSchedule({
    Key? key,
    required this.image,
    required this.exchangeName,
    required this.date,
    required this.fieldNumber, // Pass field number
  }) : super(key: key);

  @override
  State<FieldSchedule> createState() => _FieldScheduleState();
}

class _FieldScheduleState extends State<FieldSchedule> {
  // No need for reservations state variable

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exchangeName),
      ),
      body: Consumer<FieldScheduleProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final reservationsQuery = FirebaseFirestore.instance
                .collection('reservations') // Replace with your collection name
                .where('field_number', isEqualTo: widget.fieldNumber);

            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(widget.image),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Reservaciones: ${widget.exchangeName}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FirestoreListView<Map<String, dynamic>>(
                      query: reservationsQuery,
                      itemBuilder: (context, snapshot) {
                        final reservation = snapshot.data();
                        final reservationDate = reservation['start_date']
                            as Timestamp; // Cast to Timestamp
                        final formattedDateTime = DateFormat(
                                'd MMM, y - hh:mm a')
                            .format(reservationDate
                                .toDate()); // Combine formatting// Convert and format

                        return ListTile(
                          title: Text(reservation['title']),
                          subtitle: Text(formattedDateTime),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20.0,
            right: 15.0,
            child: FloatingActionButton(
              onPressed: () {
                // Navigate to NewReservationForm
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewReservationForm(
                      fieldNumber: widget.fieldNumber, // Pass field number
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
              heroTag: "addButton",
            ),
          ),
        ],
      ),
    );
  }
}
