import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/Screens/home/listdevice.dart';
import 'package:flutter_mobile_app/Screens/sidebar.dart';
import 'package:flutter_mobile_app/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? selectedChartType;
  List<ChartData> _chartData = [];
  @override
  void initState() {
    getListDevice();
    getChartDataApi();
    super.initState();
  }

  String _selectedDeviceOption = "";
  String _selectedDeviceAeId = "";
  List<Device> _deviceoptions = [];
  String _selectedTimeOption = "24 giờ gần nhất";
  int _selectedTypeOption = 1;
  List<String> _timeoptions = [
    '24 giờ gần nhất',
    '30 ngày gần nhất',
    '12 tháng gần nhất'
  ];

  Color colorBtnPH = Colors.black;
  Color colorBtnORP = Colors.black;
  Color colorBtnEC = Colors.black;
  Color colorBtnDO = Colors.blueAccent;
  Color colorBtnTUR = Colors.black;

  Color colorContaner1 = Colors.black;
  Color colorContaner2 = Colors.black;
  Color colorContaner3 = Colors.blueAccent;
  Color colorContaner4 = Colors.blueAccent;

  bool isPHVisible = false;
  bool isORPVisible = false;
  bool isECVisible = false;
  bool isDOVisible = true;
  bool isTurbidityVisible = false;
  String TextTitle = "Chất lượng nước (Độ ôxy hoà tan)";

  void _onDropdownTimeChanged(String? newValue) {
    if (newValue != _selectedTimeOption) {
      setState(() {
        _selectedTimeOption = newValue!;
        if (newValue == '24 giờ gần nhất') {
            _selectedTypeOption = 1!;
        }
        if (newValue == '30 ngày gần nhất') {
            _selectedTypeOption = 2!;
        }
        if (newValue == '12 tháng gần nhất') {
            _selectedTypeOption = 3!;
        }
      });
      print('New dropdown value: $_selectedTimeOption');

      getChartDataApi();
    }
  }

  void getChartDataApi() async {
    final SharedPreferences? prefs = await _prefs;
    final String? token = prefs?.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse("http://10.2.9.144:8080/api/content-instant/getDataHourReport?deviceId=$_selectedDeviceAeId&type=$_selectedTypeOption");
    http.Response response = await http.get(url, headers: headers);
    var json = jsonDecode(response.body);
    List<ChartData> listChartData = [];
    if (response.statusCode == 200) {
      for (var data in json) {
        listChartData.add(ChartData.fromJson(data));
      }
      setState(() {
        _chartData = listChartData;
      });
    }
  }

  void getListDevice() async {
    final SharedPreferences? prefs = await _prefs;
    final String? token = prefs?.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse("http://10.2.9.144:8080/api/devices/search?query=&page=0&size=10&sort=created,desc");
    http.Response response = await http.get(url, headers: headers);
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var device in json) {
        _deviceoptions.add(Device.fromJson(device));
      }
      setState(() {
        _selectedDeviceOption =_deviceoptions.first.name;
        _selectedDeviceAeId = _deviceoptions.first.aeId;
        _deviceoptions;
      });
    }
  }

  void _onDropdownDeviceChanged(String? newValue) {
    if (newValue != _selectedDeviceOption) {
      setState(() {
        _selectedDeviceOption = newValue!;
        _selectedDeviceAeId = _deviceoptions.firstWhere((element) =>
          element.name == newValue
        ).aeId;
        print('New dropdown value: $_selectedDeviceOption');
      });
      getChartDataApi();
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
                child: _buildDropDownDevice(_selectedDeviceOption, _deviceoptions.map((e) => e.name).toList(),
                    Icons.smartphone, _onDropdownDeviceChanged),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: _buildDropDown(_selectedTimeOption, _timeoptions,
                    Icons.access_alarm, _onDropdownTimeChanged),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
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
                          //Nút
                          colorBtnPH = Colors.blueAccent;
                          colorBtnORP = Colors.black;
                          colorBtnEC = Colors.black;
                          colorBtnDO = Colors.black;
                          colorBtnTUR = Colors.black;
                          //Ngăn cách
                          colorContaner1 = Colors.blueAccent;
                          colorContaner2 = Colors.black;
                          colorContaner3 = Colors.black;
                          colorContaner4 = Colors.black;
                          //Biểu đồ
                          isPHVisible = true;
                          isORPVisible = false;
                          isECVisible = false;
                          isDOVisible = false;
                          isTurbidityVisible = false;
                          TextTitle = "Độ pH";
                        });
                      },
                      style: TextButton.styleFrom(
                          primary: colorBtnPH // Màu chữ của nút
                          ),
                      child: Text('PH'),
                    ),
                    Container(
                      width: 1.0,
                      height: 25,
                      color: colorContaner1,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          //Nút
                          colorBtnPH = Colors.black;
                          colorBtnORP = Colors.blueAccent;
                          colorBtnEC = Colors.black;
                          colorBtnDO = Colors.black;
                          colorBtnTUR = Colors.black;
                          //Ngăn cách
                          colorContaner1 = Colors.blueAccent;
                          colorContaner2 = Colors.blueAccent;
                          colorContaner3 = Colors.black;
                          colorContaner4 = Colors.black;
                          //Biểu đồ
                          isPHVisible = false;
                          isORPVisible = true;
                          isECVisible = false;
                          isDOVisible = false;
                          isTurbidityVisible = false;
                          TextTitle = "Độ ôxy hoá khử - ORP (mV)";
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: colorBtnORP, // Màu chữ của nút
                      ),
                      child: Text('ORP'),
                    ),
                    Container(
                      width: 1.0,
                      height: 25,
                      color: colorContaner2,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          //Nút
                          colorBtnPH = Colors.black;
                          colorBtnORP = Colors.black;
                          colorBtnEC = Colors.blueAccent;
                          colorBtnDO = Colors.black;
                          colorBtnTUR = Colors.black;
                          //Ngăn cách
                          colorContaner1 = Colors.black;
                          colorContaner2 = Colors.blueAccent;
                          colorContaner3 = Colors.blueAccent;
                          colorContaner4 = Colors.black;
                          //Biểu đồ
                          isPHVisible = false;
                          isORPVisible = false;
                          isECVisible = true;
                          isDOVisible = false;
                          isTurbidityVisible = false;
                          TextTitle = "Độ dẫn điện - EC (mS/cm)";
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: colorBtnEC, // Màu chữ của nút
                      ),
                      child: Text('EC'),
                    ),
                    Container(
                      width: 1.0,
                      height: 25,
                      color: colorContaner3,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          //Nút
                          colorBtnPH = Colors.black;
                          colorBtnORP = Colors.black;
                          colorBtnEC = Colors.black;
                          colorBtnDO = Colors.blueAccent;
                          colorBtnTUR = Colors.black;
                          //Ngăn cách
                          colorContaner1 = Colors.black;
                          colorContaner2 = Colors.black;
                          colorContaner3 = Colors.blueAccent;
                          colorContaner4 = Colors.blueAccent;
                          //Biểu đồ
                          isPHVisible = false;
                          isORPVisible = false;
                          isECVisible = false;
                          isDOVisible = true;
                          isTurbidityVisible = false;
                          TextTitle = "Độ ôxy hoà tan - DO (mg/l)";
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: colorBtnDO, // Màu chữ của nút
                      ),
                      child: Text('DO'),
                    ),
                    Container(
                      width: 1.0,
                      height: 25,
                      color: colorContaner4,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          //Nút
                          colorBtnPH = Colors.black;
                          colorBtnORP = Colors.black;
                          colorBtnEC = Colors.black;
                          colorBtnDO = Colors.black;
                          colorBtnTUR = Colors.blueAccent;
                          //Ngăn cách
                          colorContaner1 = Colors.black;
                          colorContaner2 = Colors.black;
                          colorContaner3 = Colors.black;
                          colorContaner4 = Colors.blueAccent;
                          //Biểu đồ
                          isPHVisible = false;
                          isORPVisible = false;
                          isECVisible = false;
                          isDOVisible = false;
                          isTurbidityVisible = true;
                          TextTitle = "Độ đục - Turbidity (NTU)";
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: colorBtnTUR, // Màu chữ của nút
                      ),
                      child: Text('TUR'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildBarChart(_chartData, isPHVisible, isORPVisible,
                    isECVisible, isDOVisible, isTurbidityVisible, TextTitle),
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

Widget _buildDropDownDevice(
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
    List<ChartData> chartData,
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
        BarSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.time,
          yValueMapper: (ChartData data, _) => data.ph,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 8)),
          enableTooltip: true,
          isVisible: isPHVisible,
          name: 'PH',
          color: Colors.blue,
        ),
        BarSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.time,
          yValueMapper: (ChartData data, _) => data.orp,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 8)),
          enableTooltip: true,
          isVisible: isORPVisible,
          name: 'ORP',
          color: Colors.blue,
        ),
        BarSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.time,
          yValueMapper: (ChartData data, _) => data.ec,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 8)),
          enableTooltip: true,
          isVisible: isECVisible,
          name: 'EC',
          color: Colors.blue,
        ),
        BarSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.time,
          yValueMapper: (ChartData data, _) => data.dso,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 8)),
          enableTooltip: true,
          isVisible: isDOVisible,
          name: 'DO',
          color: Colors.blue,
        ),
        BarSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.time,
          yValueMapper: (ChartData data, _) => data.turb,
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

// Water Quality PH/ ORP / EC / DO / Turbidity
// ORP: độ oxy hóa khử
// EC: độ dẫn điện
// DO: oxy hòa tan
// Turbidity: Độ đục
//Create class
class ChartData {
  final String time;
  final double ph;
  final double orp;
  final double ec;
  final double dso;
  final double turb;
  ChartData(this.time, this.ph, this.orp, this.ec, this.dso,
      this.turb);
  ChartData.fromJson(Map<String, dynamic> json):
        time= json['time'],
        ph = json['ph'],
        orp = json['orp'],
        ec = json['ec'],
        dso = json['dso'],
        turb = json['turb'];
}

class PHData {
  final String day;
  final double data;
  PHData(this.day, this.data);
}

class ORPdata {
  final String day;
  final double data;
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
