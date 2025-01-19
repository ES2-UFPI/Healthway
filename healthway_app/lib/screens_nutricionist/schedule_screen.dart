import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Appointment>> _appointments = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // Mock data - replace with actual data fetching
    _appointments = {
      DateTime.now().subtract(Duration(days: 1)): [
        Appointment("Maria Oliveira", "Consulta de Rotina", "14:00"),
        Appointment("João Silva", "Avaliação Nutricional", "16:30"),
      ],
      DateTime.now(): [
        Appointment("Ana Santos", "Revisão de Dieta", "10:00"),
        Appointment("Carlos Mendes", "Primeira Consulta", "15:00"),
      ],
      DateTime.now().add(Duration(days: 1)): [
        Appointment("Fernanda Lima", "Acompanhamento", "11:30"),
        Appointment("Ricardo Souza", "Consulta de Rotina", "14:00"),
      ],
    };
  }

  List<Appointment> _getAppointmentsForDay(DateTime day) {
    return _appointments[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Agenda', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF31BAC2),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildCalendar(),
          Expanded(child: _buildAppointmentList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAppointment,
        backgroundColor: const Color(0xFF31BAC2),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      eventLoader: _getAppointmentsForDay,
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: const Color(0xFF31BAC2),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: const Color(0xFF31BAC2).withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: const Color(0xFF31BAC2),
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAppointmentList() {
    final appointments = _getAppointmentsForDay(_selectedDay!);
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF31BAC2),
              child: Text(
                appointment.patientName[0],
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(appointment.patientName),
            subtitle: Text(appointment.type),
            trailing: Text(
              appointment.time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF31BAC2),
              ),
            ),
            onTap: () => _viewAppointmentDetails(appointment),
          ),
        );
      },
    );
  }

  void _addAppointment() {
    // TODO: Implement add appointment functionality
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Consulta'),
          content:
              Text('Funcionalidade de adicionar consulta a ser implementada.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _viewAppointmentDetails(Appointment appointment) {
    // TODO: Implement view appointment details functionality
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalhes da Consulta'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Paciente: ${appointment.patientName}'),
              Text('Tipo: ${appointment.type}'),
              Text('Horário: ${appointment.time}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Appointment {
  final String patientName;
  final String type;
  final String time;

  Appointment(this.patientName, this.type, this.time);
}
