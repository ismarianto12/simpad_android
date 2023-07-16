import 'package:flutter/material.dart';

class Datepicker extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Function(DateTime) onDateSelected; // Menambahkan function parameter

  Datepicker(
      {required this.label,
      required this.controller,
      required this.onDateSelected});

  @override
  _DatepickerState createState() => _DatepickerState();
}

class _DatepickerState extends State<Datepicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    widget.controller.text = _formatDate(_selectedDate!);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.controller.text = _formatDate(_selectedDate!);
      widget.onDateSelected(_selectedDate!); // Memanggil callback function
    }
  }

  // String _formatDate(DateTime date) {
  //   return '${date.day}/${date.month}/${date.year}';
  // }
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        _selectDate(context);
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
      ),
      controller: widget.controller,
    );
  }
}
