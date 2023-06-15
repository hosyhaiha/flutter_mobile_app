import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/Screens/sidebar.dart';
import 'package:flutter_mobile_app/components/rounded_button.dart';
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

  bool isPHVisible = false;
  bool isORPVisible = false;
  bool isECVisible = false;
  bool isDOVisible = true;
  bool isTurbidityVisible = false;
  String TextTitle = "Chất lượng nước (Độ ôxy hoà tan)";

  // void handleLegendTapped(
  //     String seriesName,
  //     bool isPHVisible,
  //     bool isORPVisible,
  //     bool isECVisible,
  //     bool isDOVisible,
  //     bool isTurbidityVisible) {
  //   if (seriesName == 'PH') {
  //     setState(() {
  //       isPHVisible = true;
  //       isORPVisible = false;
  //       isECVisible = false;
  //       isDOVisible = false;
  //       isTurbidityVisible = false;
  //     });
  //   } else if (seriesName == 'ORP') {
  //     setState(() {
  //       isPHVisible = false;
  //       isORPVisible = true;
  //       isECVisible = false;
  //       isDOVisible = false;
  //       isTurbidityVisible = false;
  //     });
  //   } else if (seriesName == 'EC') {
  //     setState(() {
  //       isPHVisible = false;
  //       isORPVisible = false;
  //       isECVisible = true;
  //       isDOVisible = false;
  //       isTurbidityVisible = false;
  //     });
  //   } else if (seriesName == 'DO') {
  //     setState(() {
  //       isPHVisible = false;
  //       isORPVisible = false;
  //       isECVisible = false;
  //       isDOVisible = true;
  //       isTurbidityVisible = false;
  //     });
  //   } else if (seriesName == 'Turbidity') {
  //     setState(() {
  //       isPHVisible = false;
  //       isORPVisible = false;
  //       isECVisible = false;
  //       isDOVisible = false;
  //       isTurbidityVisible = true;
  //     });
  //   }
  //   print(seriesName);
  // }

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
  ) {
    // void handleLegendTapped(LegendTapArgs args) {
    //   final String seriesName = args.series.name;
    //   if (seriesName == 'PH') {
    //     isPHVisible = true;
    //     isORPVisible = true;
    //     isECVisible = true;
    //     isDOVisible = false;
    //     isTurbidityVisible = false;
    //     // _buildBarChart(
    //     //   phData,
    //     //   orpData,
    //     //   ecData,
    //     //   doData,
    //     //   turbidityData,
    //     //   isPHVisible,
    //     //   isORPVisible,
    //     //   isECVisible,
    //     //   isDOVisible,
    //     //   isTurbidityVisible,
    //     // );
    //   } else if (seriesName == 'ORP') {
    //     isPHVisible = false;
    //     isORPVisible = true;
    //     isECVisible = false;
    //     isDOVisible = false;
    //     isTurbidityVisible = false;
    //     _buildBarChart(
    //       phData,
    //       orpData,
    //       ecData,
    //       doData,
    //       turbidityData,
    //       isPHVisible,
    //       isORPVisible,
    //       isECVisible,
    //       isDOVisible,
    //       isTurbidityVisible,
    //     );
    //   } else if (seriesName == 'EC') {
    //     isPHVisible = false;
    //     isORPVisible = false;
    //     isECVisible = true;
    //     isDOVisible = false;
    //     isTurbidityVisible = false;
    //     _buildBarChart(
    //       phData,
    //       orpData,
    //       ecData,
    //       doData,
    //       turbidityData,
    //       isPHVisible,
    //       isORPVisible,
    //       isECVisible,
    //       isDOVisible,
    //       isTurbidityVisible,
    //     );
    //   } else if (seriesName == 'DO') {
    //     isPHVisible = false;
    //     isORPVisible = false;
    //     isECVisible = false;
    //     isDOVisible = true;
    //     isTurbidityVisible = false;
    //     _buildBarChart(
    //       phData,
    //       orpData,
    //       ecData,
    //       doData,
    //       turbidityData,
    //       isPHVisible,
    //       isORPVisible,
    //       isECVisible,
    //       isDOVisible,
    //       isTurbidityVisible,
    //     );
    //   } else if (seriesName == 'Turbidity') {
    //     isPHVisible = false;
    //     isORPVisible = false;
    //     isECVisible = false;
    //     isDOVisible = false;
    //     isTurbidityVisible = true;
    //     _buildBarChart(
    //       phData,
    //       orpData,
    //       ecData,
    //       doData,
    //       turbidityData,
    //       isPHVisible,
    //       isORPVisible,
    //       isECVisible,
    //       isDOVisible,
    //       isTurbidityVisible,
    //     );
    //   }
    //   // print(args.series.name);
    // }

    return Container(
      child: Column(
        children: [
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(),
            title: ChartTitle(text: TextTitle),
            // legend: Legend(
            //   isVisible: true,
            //   position: LegendPosition.top,
            //   textStyle: TextStyle(fontSize: 20),
            //   overflowMode: LegendItemOverflowMode.wrap,
            //   alignment: ChartAlignment.center,
            //   toggleSeriesVisibility: true,
            // ),
            onLegendTapped: (args) {
              // handleLegendTapped(
              //   args.series.name,
              //   isPHVisible,
              //   isORPVisible,
              //   isECVisible,
              //   isDOVisible,
              //   isTurbidityVisible,
              // );
            },
            series: <ChartSeries>[
              BarSeries<PHData, String>(
                dataSource: phData,
                xValueMapper: (PHData data, _) => data.day,
                yValueMapper: (PHData data, _) => data.data,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true,
                isVisible: isPHVisible,
                name: 'PH',
                color: Colors.blue,
              ),
              BarSeries<ORPdata, String>(
                dataSource: orpData,
                xValueMapper: (ORPdata data, _) => data.day,
                yValueMapper: (ORPdata data, _) => data.data,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true,
                isVisible: isORPVisible,
                name: 'ORP',
                color: Colors.blue,
              ),
              BarSeries<ECData, String>(
                dataSource: ecData,
                xValueMapper: (ECData data, _) => data.day,
                yValueMapper: (ECData data, _) => data.data,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true,
                isVisible: isECVisible,
                name: 'EC',
                color: Colors.blue,
              ),
              BarSeries<DOData, String>(
                dataSource: doData,
                xValueMapper: (DOData data, _) => data.day,
                yValueMapper: (DOData data, _) => data.data,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true,
                isVisible: isDOVisible,
                name: 'DO',
                color: Colors.blue,
              ),
              BarSeries<TurbidityData, String>(
                dataSource: turbidityData,
                xValueMapper: (TurbidityData data, _) => data.day,
                yValueMapper: (TurbidityData data, _) => data.data,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true,
                isVisible: isTurbidityVisible,
                name: 'Turbidity',
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
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
              RoundedDropdown(
                icon: Icons.smartphone,
                hint: 'From',
                dropdownValue: 'Device 1',
                dropdownItems: ['Device 1', 'Device 2', 'Device 3'],
                onChanged: (String? value) {
                  setState(() {
                    selectedChartType = value;
                  });
                  // TODO: Handle dropdown value change
                },
              ),
              RoundedDropdown(
                icon: Icons.access_alarm,
                hint: 'From',
                dropdownValue: '24 giờ gần nhất',
                dropdownItems: [
                  '24 giờ gần nhất',
                  '30 ngày gần nhất',
                  '12 tháng gần nhất'
                ],
                onChanged: (String? value) {
                  // TODO: Handle dropdown value change
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isPHVisible = true;
                        isORPVisible = false;
                        isECVisible = false;
                        isDOVisible = false;
                        isTurbidityVisible = false;
                        TextTitle = "Chất lượng nước (Độ pH)";
                      });
                    },
                    child: Text('PH'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isPHVisible = false;
                        isORPVisible = true;
                        isECVisible = false;
                        isDOVisible = false;
                        isTurbidityVisible = false;
                        TextTitle = "Chất lượng nước (Độ ôxy hoá khử)";
                      });
                    },
                    child: Text('ORP'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isPHVisible = false;
                        isORPVisible = false;
                        isECVisible = true;
                        isDOVisible = false;
                        isTurbidityVisible = false;
                        TextTitle = "Chất lượng nước (Độ dẫn điện)";
                      });
                    },
                    child: Text('EC'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isPHVisible = false;
                          isORPVisible = false;
                          isECVisible = false;
                          isDOVisible = true;
                          isTurbidityVisible = false;
                          TextTitle = "Chất lượng nước (Độ ôxy hoà tan)";
                        });
                      },
                      child: Text('DO')),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isPHVisible = false;
                          isORPVisible = false;
                          isECVisible = false;
                          isDOVisible = false;
                          isTurbidityVisible = true;
                          TextTitle = "Chất lượng nước (Độ đục)";
                        });
                      },
                      child: Text('TUR'))
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     ElevatedButton(
              //         onPressed: () {
              //           setState(() {
              //             isPHVisible = false;
              //             isORPVisible = false;
              //             isECVisible = false;
              //             isDOVisible = true;
              //             isTurbidityVisible = false;
              //             TextTitle = "Chất lượng nước (DO)";
              //           });
              //         },
              //         child: Text('DO')),
              //     ElevatedButton(
              //         onPressed: () {
              //           setState(() {
              //             isPHVisible = false;
              //             isORPVisible = false;
              //             isECVisible = false;
              //             isDOVisible = false;
              //             isTurbidityVisible = true;
              //             TextTitle = "Chất lượng nước (Turbidity)";
              //           });
              //         },
              //         child: Text('NTU'))
              //   ],
              // ),
              Expanded(
                child: ListView(
                  children: [
                    _buildBarChart(
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
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
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
