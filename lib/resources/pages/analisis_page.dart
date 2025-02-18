import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analisis App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnalisisPage(),
    );
  }
}

class AnalisisPage extends NyStatefulWidget {
  static RouteView path = ("/analisis", (_) => AnalisisPage());

  AnalisisPage({super.key}) : super(child: () => _AnalisisPageState());
}

class _AnalisisPageState extends NyPage<AnalisisPage> {
  DateTime selectedDate = DateTime.now();

  @override
  get init => () {
        // Initialize any required data
      };

  Future<void> _selectDate(BuildContext context) async {
    print("Date picker triggered"); // Debug print
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), // Gunakan tanggal hari ini
        firstDate: DateTime(2000), // Tahun minimal 2000
        lastDate: DateTime(2025, 12, 31), // Ubah ke 31 Desember 2025
        locale: const Locale('id', 'ID'),
      );

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          print("Selected date: $picked"); // Debug print
        });
      }
    } catch (e) {
      print("Error showing date picker: $e"); // Debug print
    }
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analisis"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date picker button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print("Button tapped"); // Debug print
                    _selectDate(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Pilih tanggal: ${DateFormat('dd-MM-yyyy').format(selectedDate)}",
                          style: TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.calendar_today,
                            color: Colors.blue, size: 20),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Usage graph
              SizedBox(
                height: 300,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return const Text('0');
                              case 7:
                                return const Text('07:00');
                              case 12:
                                return const Text('12:00');
                              case 18:
                                return const Text('18:00');
                              case 22:
                                return const Text('22:00');
                              default:
                                return const Text('');
                            }
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toStringAsFixed(1));
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 0.4),
                          const FlSpot(1, 0.35),
                          const FlSpot(7, 0.38),
                          const FlSpot(12, 0.45),
                          const FlSpot(18, 0.35),
                          const FlSpot(22, 0.2),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 2,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                "Tabel Penggunaan Kwh",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1.5),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1.5),
                  4: FlexColumnWidth(2),
                },
                children: [
                  const TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Tanggal'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Energi'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Biaya'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Daya'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Total Penggunaan'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('24-2-2025'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('30 Kwh'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('12.000'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('200 v'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Sedang'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analisis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
