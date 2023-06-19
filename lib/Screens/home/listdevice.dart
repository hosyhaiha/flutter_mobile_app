import 'dart:ffi';

class Device {
  final String deviceId;
  final int type;
  final String aeId;
  final int status;
  final String serialNumber;
  final String name;
  final int id;
  final int tenantId;
  final bool active;
  final String updatedBy;
  final String createdBy;
  final int updated;
  final int created;

  Device(this.deviceId, this.type, this.aeId, this.status, this.serialNumber, this.id, this.tenantId, this.active, this.updatedBy, this.createdBy, this.updated, this.created, {required this.name});
  Device.fromJson(Map<String, dynamic> json):
        deviceId= json['deviceId'],
        type = json['type'],
        aeId = json['aeId'],
        status = json['status'],
        serialNumber = json['serialNumber'],
        name = json['name'],
        id = json['id'],
        tenantId = json['tenantId'],
        active = json['active'],
        updatedBy = json['updatedBy'].toString(),
        createdBy= json['createdBy'],
        updated= json['updated'],
        created= json['created'];

}