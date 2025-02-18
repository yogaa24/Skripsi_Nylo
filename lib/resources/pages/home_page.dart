import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:nylo_framework/nylo_framework.dart';

class HomePage extends NyStatefulWidget {
  static RouteView path = ("/home", (_) => HomePage());

  HomePage({super.key}) : super(child: () => _HomePageState());
}

class _HomePageState extends NyPage<HomePage> {
  bool isRelayOn = true; // Default kondisi relay
  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Realtime Monitoring"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Energi total",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 0.15,
                      cornerStyle: CornerStyle.bothCurve,
                      color: Color.fromARGB(30, 0, 0, 0),
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: 3.14,
                        width: 0.15,
                        sizeUnit: GaugeSizeUnit.factor,
                        gradient: const SweepGradient(
                          colors: [Colors.pink, Colors.blue],
                        ),
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: const Text(
                          '3,14 KWh',
                          style: TextStyle(fontSize: 16),
                        ),
                        positionFactor: 0.1,
                        angle: 90,
                      )
                    ],
                  )
                ]),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildStatusCard("Volt", 30),
                    _buildSwitchCard("Relay", isRelayOn),
                    _buildStatusCard("Watt", 50),
                    _buildStatusCard("Total Harga", 10000),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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

  Widget _buildStatusCard(String title, double value) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 1000,
                  showTicks: false,
                  showLabels: false,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 0.15,
                    cornerStyle: CornerStyle.bothFlat,
                    color: Color.fromARGB(30, 0, 0, 0),
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: value,
                      width: 0.15,
                      sizeUnit: GaugeSizeUnit.factor,
                      gradient: const SweepGradient(
                        colors: [Colors.pink, Colors.blue],
                      ),
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        value.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      positionFactor: 0.1, // Menempatkan value di tengah
                      angle: 90,
                    ),
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchCard(String title, bool isOn) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Switch(
              value: isOn,
              activeColor: Colors.green,
              activeTrackColor: Colors.green.shade300,
              inactiveThumbColor: Colors.red,
              inactiveTrackColor: Colors.red.shade300,
              onChanged: (value) {
                setState(() {
                  isRelayOn = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}