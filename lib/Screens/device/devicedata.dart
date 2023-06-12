import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/Screens/sidebar.dart';
import 'package:flutter_mobile_app/components/rounded_dropdown.dart';
import 'package:flutter_mobile_app/constants.dart';
import 'package:charts_flutter/flutter.dart' as chartmodel;

class DeviceData extends StatefulWidget {
  const DeviceData({super.key});

  @override
  State<DeviceData> createState() => _DeviceDataState();
}

class _DeviceDataState extends State<DeviceData> {
  static List<chartmodel.Series<BarDataModel, String>> _createSampleData() {
    final data = [
      BarDataModel("January", 1500),
      BarDataModel("F3bruary", 2600),
      BarDataModel("March", 1700),
      BarDataModel("April", 2300)
    ];
    return [
      chartmodel.Series<BarDataModel, String>(
          data: data,
          id: 'example',
          colorFn: (_, __) => chartmodel.MaterialPalette.teal.shadeDefault,
          domainFn: (BarDataModel barDataModel, _) => barDataModel.time,
          measureFn: (BarDataModel barDataModel, _) => barDataModel.value)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text("Device Infomation"),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => null, icon: Icon(Icons.notifications))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: _buildBody(),
          ),
          RoundedDropdown(
            icon: Icons.access_alarm,
            hint: 'From',
            dropdownValue: '7 ngày gần nhất',
            dropdownItems: ['7 ngày gần nhất', '6 tháng gần nhất'],
            onChanged: (String? value) {
              // TODO: Handle dropdown value change
            },
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 300,
              child: chartmodel.BarChart(
                _createSampleData(),
                animate: true,
              ),
            ),
          ),
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}

class BarDataModel {
  final String time;
  final int value;
  BarDataModel(this.time, this.value);
}

Widget _buildBody() {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          Text(
            "Thông tin",
            style: TextStyle(
              // color: Colors.blue, // Màu sắc chữ
              fontSize: 20, // Kích thước chữ
              fontWeight: FontWeight.bold, // Chữ in đậm
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Số điện: 15kw",
                  style: TextStyle(
                    // color: Colors.blue, // Màu sắc chữ
                    fontSize: 17, // Kích thước chữ\
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Điện áp: 1V",
                  style: TextStyle(
                    // color: Colors.blue, // Màu sắc chữ
                    fontSize: 17, // Kích thước chữ\
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Công suất: 1500kw",
                  style: TextStyle(
                    // color: Colors.blue, // Màu sắc chữ
                    fontSize: 17, // Kích thước chữ\
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Dòng: 3,09A",
                  style: TextStyle(
                    // color: Colors.blue, // Màu sắc chữ
                    fontSize: 15, // Kích thước chữ\
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8), // Bo tròn viền container
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Màu của shadow
          spreadRadius: 2, // Độ lớn của shadow
          blurRadius: 4, // Độ mờ của shadow
          offset: Offset(0, 2), // Độ dịch chuyển của shadow theo trục x và y
        ),
      ],
    ),
    margin: EdgeInsets.all(10), // Khoảng cách với các phần tử khác
    padding: EdgeInsets.all(10), // Khoảng cách bên trong container
  );
}
