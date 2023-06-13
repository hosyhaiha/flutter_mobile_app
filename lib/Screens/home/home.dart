import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/Screens/sidebar.dart';
import 'package:flutter_mobile_app/components/rounded_dropdown.dart';
import 'package:flutter_mobile_app/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedChartType;
  List<PHData> _phChartData = getPHData();
  List<ORPdata> _orpChartData = getORPData();
  List<ECData> _ecChartData = getECData();
  List<DOData> _doChartData = getDOData();
  List<TurbidityData> _turbidityChartData = getTurbidityData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(
        isHomePage: true,
        isDevicePage: false,
      ),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => null, icon: Icon(Icons.notifications))
        ],
      ),
      // drawer: const NavigationDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              RoundedDropdown(
                icon: Icons.access_alarm,
                hint: 'From',
                dropdownValue: '24 giờ gần nhất',
                dropdownItems: [
                  '24 giờ gần nhất',
                  '7 ngày gần nhất',
                  '30 ngày gần nhất'
                ],
                onChanged: (String? value) {
                  // TODO: Handle dropdown value change
                },
              ),
              RoundedDropdown(
                icon: Icons.insert_chart_outlined_outlined,
                hint: 'From',
                dropdownValue: 'Tất cả biểu đồ',
                dropdownItems: [
                  'Tất cả biểu đồ',
                  'Biểu đồ đường',
                  'Biểu đồ cột',
                  'Biểu đồ hàng'
                ],
                onChanged: (String? value) {
                  setState(() {
                    selectedChartType = value;
                  });
                  // TODO: Handle dropdown value change
                },
              ),
              Expanded(
                child: ListView(
                  children: [
                    if (selectedChartType == null ||
                        selectedChartType == 'Tất cả biểu đồ' ||
                        selectedChartType == 'Biểu đồ đường')
                      _buildLineChart(
                        _phChartData,
                        _orpChartData,
                        _ecChartData,
                        _doChartData,
                        _turbidityChartData,
                      ),
                    if (selectedChartType == null ||
                        selectedChartType == 'Tất cả biểu đồ' ||
                        selectedChartType == 'Biểu đồ hàng')
                      _buildBarChart(
                        _phChartData,
                        _orpChartData,
                        _ecChartData,
                        _doChartData,
                        _turbidityChartData,
                      ),
                    if (selectedChartType == null ||
                        selectedChartType == 'Tất cả biểu đồ' ||
                        selectedChartType == 'Biểu đồ cột')
                      _buildColumnChart(
                        _phChartData,
                        _orpChartData,
                        _ecChartData,
                        _doChartData,
                        _turbidityChartData,
                      ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

Widget _buildLineChart(
  List<PHData> phData,
  List<ORPdata> orpData,
  List<ECData> ecData,
  List<DOData> doData,
  List<TurbidityData> turbidityData,
) {
  bool isPHVisible = false;
  bool isORPVisible = false;
  bool isECVisible = false;
  bool isDOVisible = true;
  bool isTurbidityVisible = false;

  return Container(
    child: Column(
      children: [
        SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          title: ChartTitle(text: "Chất lượng nước (Biểu đồ đường)"),
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
          series: <ChartSeries>[
            LineSeries<PHData, String>(
              dataSource: phData,
              xValueMapper: (PHData data, _) => data.day,
              yValueMapper: (PHData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isPHVisible,
              name: 'PH',
              // name: 'PH (pH)',
            ),
            LineSeries<ORPdata, String>(
              dataSource: orpData,
              xValueMapper: (ORPdata data, _) => data.day,
              yValueMapper: (ORPdata data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isORPVisible,
              name: 'ORP',
              // name: 'ORP (mV)',
            ),
            LineSeries<ECData, String>(
              dataSource: ecData,
              xValueMapper: (ECData data, _) => data.day,
              yValueMapper: (ECData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isECVisible,
              name: 'EC',
              // name: 'EC (µS/cm)',
            ),
            LineSeries<DOData, String>(
              dataSource: doData,
              xValueMapper: (DOData data, _) => data.day,
              yValueMapper: (DOData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isDOVisible,
              name: 'DO',
              // name: 'DO (mg/L)',
            ),
            LineSeries<TurbidityData, String>(
              dataSource: turbidityData,
              xValueMapper: (TurbidityData data, _) => data.day,
              yValueMapper: (TurbidityData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isTurbidityVisible,
              name: 'Turbidity',
              // name: 'Turbidity (NTU)',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBarChart(
  List<PHData> phData,
  List<ORPdata> orpData,
  List<ECData> ecData,
  List<DOData> doData,
  List<TurbidityData> turbidityData,
) {
  bool isPHVisible = false;
  bool isORPVisible = false;
  bool isECVisible = false;
  bool isDOVisible = true;
  bool isTurbidityVisible = false;

  return Container(
    child: Column(
      children: [
        SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          title: ChartTitle(text: "Chất lượng nước (Biểu đồ cột)"),
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
          series: <ChartSeries>[
            BarSeries<PHData, String>(
              dataSource: phData,
              xValueMapper: (PHData data, _) => data.day,
              yValueMapper: (PHData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isPHVisible,
              name: 'PH',
            ),
            BarSeries<ORPdata, String>(
              dataSource: orpData,
              xValueMapper: (ORPdata data, _) => data.day,
              yValueMapper: (ORPdata data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isORPVisible,
              name: 'ORP',
            ),
            BarSeries<ECData, String>(
              dataSource: ecData,
              xValueMapper: (ECData data, _) => data.day,
              yValueMapper: (ECData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isECVisible,
              name: 'EC',
            ),
            BarSeries<DOData, String>(
              dataSource: doData,
              xValueMapper: (DOData data, _) => data.day,
              yValueMapper: (DOData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isDOVisible,
              name: 'DO',
            ),
            BarSeries<TurbidityData, String>(
              dataSource: turbidityData,
              xValueMapper: (TurbidityData data, _) => data.day,
              yValueMapper: (TurbidityData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isTurbidityVisible,
              name: 'Turbidity',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildColumnChart(
  List<PHData> phData,
  List<ORPdata> orpData,
  List<ECData> ecData,
  List<DOData> doData,
  List<TurbidityData> turbidityData,
) {
  bool isPHVisible = false;
  bool isORPVisible = false;
  bool isECVisible = false;
  bool isDOVisible = true;
  bool isTurbidityVisible = false;

  return Container(
    child: Column(
      children: [
        SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          title: ChartTitle(text: "Chất lượng nước (Biểu đồ cột)"),
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
          series: <ChartSeries>[
            ColumnSeries<PHData, String>(
              dataSource: phData,
              xValueMapper: (PHData data, _) => data.day,
              yValueMapper: (PHData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isPHVisible,
              name: 'PH',
              // name: 'PH (pH)',
            ),
            ColumnSeries<ORPdata, String>(
              dataSource: orpData,
              xValueMapper: (ORPdata data, _) => data.day,
              yValueMapper: (ORPdata data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isORPVisible,
              name: 'ORP',
              // name: 'ORP (mV)',
            ),
            ColumnSeries<ECData, String>(
              dataSource: ecData,
              xValueMapper: (ECData data, _) => data.day,
              yValueMapper: (ECData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isECVisible,
              name: 'EC',
              // name: 'EC (µS/cm)',
            ),
            ColumnSeries<DOData, String>(
              dataSource: doData,
              xValueMapper: (DOData data, _) => data.day,
              yValueMapper: (DOData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isDOVisible,
              name: 'DO',
              // name: 'DO (mg/L)',
            ),
            ColumnSeries<TurbidityData, String>(
              dataSource: turbidityData,
              xValueMapper: (TurbidityData data, _) => data.day,
              yValueMapper: (TurbidityData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              isVisible: isTurbidityVisible,
              name: 'Turbidity',
              // name: 'Turbidity (NTU)',
            ),
          ],
        ),
      ],
    ),
  );
}

List<PHData> getPHData() {
  final List<PHData> phData = [
    PHData("Mon", 6.5),
    PHData("Tue", 6.8),
    PHData("Wed", 7.2),
    PHData("Thu", 6.9),
    PHData("Fri", 7.1),
    PHData("Sat", 6.7),
    PHData("Sun", 7.0),
  ];
  return phData;
}

List<ORPdata> getORPData() {
  final List<ORPdata> orpData = [
    ORPdata("Mon", 200),
    ORPdata("Tue", 180),
    ORPdata("Wed", 210),
    ORPdata("Thu", 195),
    ORPdata("Fri", 205),
    ORPdata("Sat", 190),
    ORPdata("Sun", 195),
  ];
  return orpData;
}

List<ECData> getECData() {
  final List<ECData> ecData = [
    ECData("Mon", 100),
    ECData("Tue", 110),
    ECData("Wed", 115),
    ECData("Thu", 105),
    ECData("Fri", 120),
    ECData("Sat", 125),
    ECData("Sun", 115),
  ];
  return ecData;
}

List<DOData> getDOData() {
  final List<DOData> doData = [
    DOData("Mon", 7.5),
    DOData("Tue", 7.8),
    DOData("Wed", 7.3),
    DOData("Thu", 7.2),
    DOData("Fri", 7.4),
    DOData("Sat", 7.1),
    DOData("Sun", 7.3),
  ];
  return doData;
}

List<TurbidityData> getTurbidityData() {
  final List<TurbidityData> turbidityData = [
    TurbidityData("Mon", 10),
    TurbidityData("Tue", 12),
    TurbidityData("Wed", 11),
    TurbidityData("Thu", 13),
    TurbidityData("Fri", 10),
    TurbidityData("Sat", 9),
    TurbidityData("Sun", 11),
  ];
  return turbidityData;
}

// Water Quality PH/ ORP / EC / DO / Turbidity
// ORP: độ oxy hóa khử
// EC: độ dẫn điện
// DO: oxy hòa tan
// Turbidity: Độ đục
//Create class
class PHData {
  final String day;
  final double data;
  PHData(this.day, this.data);
}

class ORPdata {
  final String day;
  final int data;
  ORPdata(this.day, this.data);
}

class ECData {
  final String day;
  final double data;
  ECData(this.day, this.data);
}

class DOData {
  final String day;
  final double data;
  DOData(this.day, this.data);
}

class TurbidityData {
  final String day;
  final double data;
  TurbidityData(this.day, this.data);
}
