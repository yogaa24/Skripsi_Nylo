import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalisisPage extends NyStatefulWidget {
  static RouteView path = ("/analisis", (_) => AnalisisPage());
  
  AnalisisPage({super.key}) : super(child: () => _AnalisisPageState());
}

class _AnalisisPageState extends NyPage<AnalisisPage> {
  DateTime selectedDate = DateTime.now();

  @override
  get init => () {
    // Initialize data or fetch from API
  };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analisis"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date picker
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pilih tanggal',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                
                // Usage graph
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 220,
                          child: _buildUsageChart(),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.info_outline, size: 18, color: Colors.grey),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'sumbu x mewakili tanggal\nsumbu y mewakili jenis penggunaan',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Usage table
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tabel Penggunaan Kwh',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.info_outline, size: 18, color: Colors.grey),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Tabel ini menampilkan data analisis dari tabel yang di pilih.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        _buildUsageTable(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildUsageChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 0.1,
          verticalInterval: 4,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                String text = '';
                if (value.toInt() == 12) {
                  text = '12.00';
                } else if (value.toInt() == 18) {
                  text = '18.00';
                } else if (value.toInt() == 22) {
                  text = '22.00';
                }
                return Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                );
              },
              interval: 4,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                );
              },
              interval: 0.1,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d)),
        ),
        minX: 12,
        maxX: 22,
        minY: 0.2,
        maxY: 0.6,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(12, 0.42),
              FlSpot(14, 0.36),
              FlSpot(16, 0.38),
              FlSpot(18, 0.42),
              FlSpot(20, 0.46),
              FlSpot(22, 0.28),
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: 0.35,
              color: Colors.red.withOpacity(0.8),
              strokeWidth: 1,
              label: HorizontalLineLabel(
                show: true,
                padding: const EdgeInsets.only(left: 10),
                style: TextStyle(color: Colors.red, fontSize: 10),
                labelResolver: (_) => 'sedang',
              ),
            ),
            HorizontalLine(
              y: 0.22,
              color: Colors.red.withOpacity(0.8),
              strokeWidth: 1,
              label: HorizontalLineLabel(
                show: true,
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 5),
                style: TextStyle(color: Colors.red, fontSize: 10),
                labelResolver: (_) => 'rendah',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageTable() {
    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(
          width: 1,
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ),
        bottom: BorderSide(
          width: 1,
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ),
      ),
      columnWidths: {
        0: FlexColumnWidth(1.2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Tanggal',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Energy',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Biaya',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text('24-2-2025'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text('30 Kwh'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text('Rp 12.000'),
            ),
          ],
        ),
      ],
    );
  }
}