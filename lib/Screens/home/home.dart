import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/Screens/sidebar.dart';
import 'package:flutter_mobile_app/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedChartType;
  List<PHData> _phChartData = getPHData30days();
  List<ORPdata> _orpChartData = getORPData30days();
  List<ECData> _ecChartData = getECData30days();
  List<DOData> _doChartData = getDOData30days();
  List<TurbidityData> _turbidityChartData = getTurbidityData30days();

  String _selectedDeviceOption = "Device 1";
  List<String> _deviceoptions = [
    'Device 1',
    'Device 2',
    'Device 3',
  ];
  String _selectedTimeOption = "24 giờ gần nhất";
  List<String> _timeoptions = [
    '24 giờ gần nhất',
    '30 ngày gần nhất',
    '12 tháng gần nhất'
  ];

  bool isPHVisible = false;
  bool isORPVisible = false;
  bool isECVisible = false;
  bool isDOVisible = true;
  bool isTurbidityVisible = false;
  String TextTitle = "Chất lượng nước (Độ ôxy hoà tan)";

  void _onDropdownTimeChanged(String? newValue) {
    if (newValue != _selectedTimeOption) {
      if (newValue == '12 tháng gần nhất') {
        setState(() {
          _selectedTimeOption = newValue!;
          // print('New dropdown value: $_selectedTimeOption');
          _phChartData = getPHData();
          _orpChartData = getORPData();
          _ecChartData = getECData();
          _doChartData = getDOData();
          _turbidityChartData = getTurbidityData();
        });
      }
    }
  }

  void _onDropdownDeviceChanged(String? newValue) {
    if (newValue != _selectedTimeOption) {
      setState(() {
        _selectedDeviceOption = newValue!;
        print('New dropdown value: $_selectedDeviceOption');
      });
    }
  }

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
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: _buildDropDown(_selectedDeviceOption, _deviceoptions,
                    Icons.smartphone, _onDropdownDeviceChanged),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: _buildDropDown(_selectedTimeOption, _timeoptions,
                    Icons.access_alarm, _onDropdownTimeChanged),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15.0),
                    right: Radius.circular(15.0),
                  ),
                  // color: Colors.blueAccent.withAlpha(50), // Màu nền của ô chứa
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // Các nút của bạn
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isPHVisible = true;
                          isORPVisible = false;
                          isECVisible = false;
                          isDOVisible = false;
                          isTurbidityVisible = false;
                          TextTitle = "Độ pH";
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black, // Màu chữ của nút
                      ),
                      child: Text('PH'),
                    ),
                    Container(
                      width: 1.0,
                      height: 25,
                      color: Colors.black,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isPHVisible = false;
                          isORPVisible = true;
                          isECVisible = false;
                          isDOVisible = false;
                          isTurbidityVisible = false;
                          TextTitle = "Độ ôxy hoá khử - ORP (mV)";
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black, // Màu chữ của nút
                      ),
                      child: Text('ORP'),
                    ),
                    Container(
                      width: 1.0,
                      height: 25,
                      color: Colors.black,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isPHVisible = false;
                          isORPVisible = false;
                          isECVisible = true;
                          isDOVisible = false;
                          isTurbidityVisible = false;
                          TextTitle = "Độ dẫn điện - EC (mS/cm)";
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black, // Màu chữ của nút
                      ),
                      child: Text('EC'),
                    ),
                    Container(
                      width: 1.0,
                      height: 25,
                      color: Colors.black,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isPHVisible = false;
                          isORPVisible = false;
                          isECVisible = false;
                          isDOVisible = true;
                          isTurbidityVisible = false;
                          TextTitle = "Độ ôxy hoà tan - DO (mg/l)";
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black, // Màu chữ của nút
                      ),
                      child: Text('DO'),
                    ),
                    Container(
                      width: 1.0,
                      height: 25,
                      color: Colors.black,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isPHVisible = false;
                          isORPVisible = false;
                          isECVisible = false;
                          isDOVisible = false;
                          isTurbidityVisible = true;
                          TextTitle = "Độ đục - Turbidity (NTU)";
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black, // Màu chữ của nút
                      ),
                      child: Text('TUR'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildBarChart(
                    _phChartData,
                    _orpChartData,
                    _ecChartData,
                    _doChartData,
                    _turbidityChartData,
                    isPHVisible,
                    isORPVisible,
                    isECVisible,
                    isDOVisible,
                    isTurbidityVisible,
                    TextTitle),
              ),
            ],
          )),
    );
  }
}

Widget _buildDropDown(
  String _selectedOption,
  List<String> _options,
  IconData icon,
  void Function(String?)? onSelectedValueChanged,
) {
  return Container(
    height: 40.0,
    decoration: BoxDecoration(
      color: Colors.blueAccent.withAlpha(50),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.blueAccent,
                    size: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          value: _selectedOption,
                          items: _options.map((String option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: onSelectedValueChanged),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              )),
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
    bool isPHVisible,
    bool isORPVisible,
    bool isECVisible,
    bool isDOVisible,
    bool isTurbidityVisible,
    String TextTitle) {
  return Container(
    child: SfCartesianChart(
      primaryXAxis: CategoryAxis(
        desiredIntervals: 30,
        labelStyle: TextStyle(fontSize: 8),
      ),
      primaryYAxis: NumericAxis(),
      title: ChartTitle(text: TextTitle),
      onLegendTapped: (args) {},
      series: <ChartSeries>[
        BarSeries<PHData, String>(
          dataSource: phData,
          xValueMapper: (PHData data, _) => data.day,
          yValueMapper: (PHData data, _) => data.data,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 8)),
          enableTooltip: true,
          isVisible: isPHVisible,
          name: 'PH',
          color: Colors.blue,
        ),
        BarSeries<ORPdata, String>(
          dataSource: orpData,
          xValueMapper: (ORPdata data, _) => data.day,
          yValueMapper: (ORPdata data, _) => data.data,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 8)),
          enableTooltip: true,
          isVisible: isORPVisible,
          name: 'ORP',
          color: Colors.blue,
        ),
        BarSeries<ECData, String>(
          dataSource: ecData,
          xValueMapper: (ECData data, _) => data.day,
          yValueMapper: (ECData data, _) => data.data,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 8)),
          enableTooltip: true,
          isVisible: isECVisible,
          name: 'EC',
          color: Colors.blue,
        ),
        BarSeries<DOData, String>(
          dataSource: doData,
          xValueMapper: (DOData data, _) => data.day,
          yValueMapper: (DOData data, _) => data.data,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 8)),
          enableTooltip: true,
          isVisible: isDOVisible,
          name: 'DO',
          color: Colors.blue,
        ),
        BarSeries<TurbidityData, String>(
          dataSource: turbidityData,
          xValueMapper: (TurbidityData data, _) => data.day,
          yValueMapper: (TurbidityData data, _) => data.data,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 8)),
          enableTooltip: true,
          isVisible: isTurbidityVisible,
          name: 'Turbidity',
          color: Colors.blue,
        ),
      ],
    ),
  );
}

//Device 1
//24h
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
    ECData("Mon", 31),
    ECData("Tue", 22),
    ECData("Wed", 33),
    ECData("Thu", 25),
    ECData("Fri", 26),
    ECData("Sat", 34),
    ECData("Sun", 22),
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

//30 ngày
List<PHData> getPHData30days() {
  final List<PHData> phData = [
    PHData("1", 6.2),
    PHData("2", 6.5),
    PHData("3", 6.4),
    PHData("4", 6.9),
    PHData("5", 6.2),
    PHData("6", 6.0),
    PHData("7", 6.1),
    PHData("8", 6.8),
    PHData("9", 6.8),
    PHData("10", 6.0),
    PHData("11", 7.5),
    PHData("12", 7.4),
    PHData("13", 6.1),
    PHData("14", 6.3),
    PHData("15", 7.1),
    PHData("16", 6.6),
    PHData("17", 7.6),
    PHData("18", 6.7),
    PHData("19", 7.3),
    PHData("20", 6.0),
    PHData("21", 6.1),
    PHData("22", 7.8),
    PHData("23", 6.1),
    PHData("24", 6.0),
    PHData("25", 7.7),
    PHData("26", 7.3),
    PHData("27", 7.1),
    PHData("28", 7.3),
    PHData("29", 7.1),
    PHData("30", 6.6),
  ];
  return phData;
}

List<ORPdata> getORPData30days() {
  final List<ORPdata> orpData = [
    ORPdata("1", 199),
    ORPdata("2", 205),
    ORPdata("3", 185),
    ORPdata("4", 203),
    ORPdata("5", 191),
    ORPdata("6", 195),
    ORPdata("7", 185),
    ORPdata("8", 194),
    ORPdata("9", 206),
    ORPdata("10", 205),
    ORPdata("11", 208),
    ORPdata("12", 201),
    ORPdata("13", 208),
    ORPdata("14", 190),
    ORPdata("15", 189),
    ORPdata("16", 189),
    ORPdata("17", 186),
    ORPdata("18", 191),
    ORPdata("19", 197),
    ORPdata("20", 210),
    ORPdata("21", 180),
    ORPdata("22", 209),
    ORPdata("23", 200),
    ORPdata("24", 187),
    ORPdata("25", 204),
    ORPdata("26", 188),
    ORPdata("27", 207),
    ORPdata("28", 181),
    ORPdata("29", 208),
    ORPdata("30", 206),
  ];
  return orpData;
}

List<ECData> getECData30days() {
  //20-35 mS/cm
  final List<ECData> ecData = [
    ECData("1", 28),
    ECData("2", 25),
    ECData("3", 31),
    ECData("4", 35),
    ECData("5", 27),
    ECData("6", 27),
    ECData("7", 21),
    ECData("8", 30),
    ECData("9", 24),
    ECData("10", 27),
    ECData("11", 20),
    ECData("12", 28),
    ECData("13", 31),
    ECData("14", 33),
    ECData("15", 32),
    ECData("16", 22),
    ECData("17", 35),
    ECData("18", 34),
    ECData("19", 28),
    ECData("20", 33),
    ECData("21", 27),
    ECData("22", 26),
    ECData("23", 32),
    ECData("24", 28),
    ECData("25", 31),
    ECData("26", 28),
    ECData("27", 30),
    ECData("28", 34),
    ECData("29", 28),
    ECData("30", 27),
  ];
  return ecData;
}

List<DOData> getDOData30days() {
  final List<DOData> doData = [
    // 5 đến 7 mg/l
    DOData("1", 7.0),
    DOData("2", 5.1),
    DOData("3", 5.2),
    DOData("4", 6.9),
    DOData("5", 6.6),
    DOData("6", 5.1),
    DOData("7", 5.7),
    DOData("8", 6.8),
    DOData("9", 7.0),
    DOData("10", 6.0),
    DOData("11", 5.4),
    DOData("12", 6.8),
    DOData("13", 5.3),
    DOData("14", 6.6),
    DOData("15", 5.4),
    DOData("16", 6.1),
    DOData("17", 5.4),
    DOData("18", 5.6),
    DOData("19", 5.7),
    DOData("20", 5.7),
    DOData("21", 6.4),
    DOData("22", 5.8),
    DOData("23", 5.1),
    DOData("24", 6.1),
    DOData("25", 6.2),
    DOData("26", 5.8),
    DOData("27", 6.8),
    DOData("28", 6.2),
    DOData("29", 6.0),
    DOData("30", 6.1),
  ];
  return doData;
}

List<TurbidityData> getTurbidityData30days() {
  final List<TurbidityData> turbidityData = [
    // 5 đến 20 NT1
    TurbidityData("1", 19),
    TurbidityData("2", 14),
    TurbidityData("3", 17),
    TurbidityData("4", 20),
    TurbidityData("5", 18),
    TurbidityData("6", 10),
    TurbidityData("7", 10),
    TurbidityData("8", 14),
    TurbidityData("9", 17),
    TurbidityData("10", 11),
    TurbidityData("11", 11),
    TurbidityData("12", 13),
    TurbidityData("13", 13),
    TurbidityData("14", 17),
    TurbidityData("15", 14),
    TurbidityData("16", 20),
    TurbidityData("17", 11),
    TurbidityData("18", 15),
    TurbidityData("19", 10),
    TurbidityData("20", 17),
    TurbidityData("21", 12),
    TurbidityData("22", 14),
    TurbidityData("23", 10),
    TurbidityData("24", 12),
    TurbidityData("25", 11),
    TurbidityData("26", 14),
    TurbidityData("27", 15),
    TurbidityData("28", 20),
    TurbidityData("29", 10),
    TurbidityData("30", 10),
  ];
  return turbidityData;
}

//12 tháng
List<PHData> getPHData12months() {
  final List<PHData> phData = [
    PHData("1", 6.1),
    PHData("2", 7.1),
    PHData("3", 6.7),
    PHData("4", 7.4),
    PHData("5", 7.5),
    PHData("6", 6.2),
    PHData("7", 6.1),
    PHData("8", 7.4),
    PHData("9", 7.2),
    PHData("10", 6.5),
    PHData("11", 6.3),
    PHData("12", 6.2),
  ];
  return phData;
}

List<ORPdata> getORPData12months() {
  final List<ORPdata> orpData = [
    ORPdata("1", 183),
    ORPdata("2", 195),
    ORPdata("3", 199),
    ORPdata("4", 210),
    ORPdata("5", 193),
    ORPdata("6", 184),
    ORPdata("7", 205),
    ORPdata("8", 183),
    ORPdata("9", 203),
    ORPdata("10", 189),
    ORPdata("11", 203),
    ORPdata("12", 181),
  ];
  return orpData;
}

List<ECData> getECData12months() {
  //20-35 mS/cm
  final List<ECData> ecData = [
    ECData("1", 34),
    ECData("2", 25),
    ECData("3", 24),
    ECData("4", 27),
    ECData("5", 32),
    ECData("6", 26),
    ECData("7", 31),
    ECData("8", 29),
    ECData("9", 22),
    ECData("10", 25),
    ECData("11", 20),
    ECData("12", 20),
  ];
  return ecData;
}

List<DOData> getDOData12months() {
  final List<DOData> doData = [
    // 5 đến 7 mg/l
    DOData("1", 5.3),
    DOData("2", 6.6),
    DOData("3", 5.4),
    DOData("4", 7.0),
    DOData("5", 6.1),
    DOData("6", 5.0),
    DOData("7", 6.6),
    DOData("8", 6.7),
    DOData("9", 6.8),
    DOData("10", 5.8),
    DOData("11", 6.3),
    DOData("12", 6.3),
  ];
  return doData;
}

List<TurbidityData> getTurbidityData12months() {
  final List<TurbidityData> turbidityData = [
    // 5 đến 20 NT1
    TurbidityData("1", 13),
    TurbidityData("2", 14),
    TurbidityData("3", 13),
    TurbidityData("4", 10),
    TurbidityData("5", 20),
    TurbidityData("6", 15),
    TurbidityData("7", 9),
    TurbidityData("8", 9),
    TurbidityData("9", 13),
    TurbidityData("10", 12),
    TurbidityData("11", 12),
    TurbidityData("12", 10),
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
