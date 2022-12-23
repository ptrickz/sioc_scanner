class AssetFields {
  static const String item = 'Item';
  static const String assetNumber = 'Asset Number';
  static const String description = 'Description';
  static const String status = 'Status';
  static const String relationships = 'Relationships';
  static const String locationOrUser = 'Location/User';
  static const String type = 'Type';
  static const String manufacturer = 'Manufacturer';
  static const String serialNumber = 'Serial Number';
  static const String modelNumber = 'Model Number';
  static const String supplyDate = 'Supply Date';
  static const String supplier = 'Supplier';
  static const String remark = 'Remark';

  static List<String> getFields() => [
        item,
        assetNumber,
        description,
        status,
        relationships,
        locationOrUser,
        type,
        manufacturer,
        serialNumber,
        modelNumber,
        supplyDate,
        supplier,
        remark,
      ];
}

class Assets {
  Assets({
    this.item,
    this.assetNumber,
    this.description,
    this.status,
    this.relationships,
    this.locationOrUser,
    this.type,
    this.manufacturer,
    this.serialNumber,
    this.modelNumber,
    this.supplyDate,
    this.supplier,
    this.remark,
  });

  Assets copy({
    String? item,
    String? assetNumber,
    String? description,
    String? status,
    String? relationships,
    String? locationOrUser,
    String? type,
    String? manufacturer,
    String? serialNumber,
    String? modelNumber,
    String? supplyDate,
    String? supplier,
    String? remark,
  }) {
    return Assets(
        item: item ?? this.item,
        assetNumber: assetNumber ?? this.assetNumber,
        description: description ?? this.description,
        status: status ?? this.status,
        relationships: relationships ?? this.relationships,
        locationOrUser: locationOrUser ?? this.locationOrUser,
        type: type ?? this.type,
        manufacturer: manufacturer ?? this.manufacturer,
        serialNumber: serialNumber ?? this.serialNumber,
        modelNumber: modelNumber ?? this.modelNumber,
        supplyDate: supplyDate ?? this.supplyDate,
        supplier: supplier ?? this.supplier,
        remark: remark ?? this.remark);
  }

  String? item;
  String? assetNumber;
  String? description;
  String? status;
  String? relationships;
  String? locationOrUser;
  String? type;
  String? manufacturer;
  String? serialNumber;
  String? modelNumber;
  String? supplyDate;
  String? supplier;
  String? remark;

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
        item: json[AssetFields.item],
        assetNumber: json[AssetFields.assetNumber],
        description: json[AssetFields.description],
        status: json[AssetFields.status],
        relationships: json[AssetFields.relationships],
        locationOrUser: json[AssetFields.locationOrUser],
        type: json[AssetFields.type],
        manufacturer: json[AssetFields.manufacturer],
        serialNumber: json[AssetFields.serialNumber],
        modelNumber: json[AssetFields.modelNumber],
        supplyDate: json[AssetFields.supplyDate],
        supplier: json[AssetFields.supplier],
        remark: json[AssetFields.remark],
      );

  Map<String, dynamic> toJson() => {
        "Item": item,
        "Asset Number": assetNumber,
        "Description": description,
        "Status": status,
        "Relationships": relationships,
        "LocationOrUser": locationOrUser,
        "Type": type,
        "Manufacturer": manufacturer,
        "Serial Number": serialNumber,
        "Model Number": modelNumber,
        "Supply Date": supplyDate,
        "Supplier": supplier,
        "Remark": remark,
      };
}
