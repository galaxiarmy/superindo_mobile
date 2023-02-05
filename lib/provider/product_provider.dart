import 'package:flutter/foundation.dart';

class DataProductProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _dataProducts = '[]';
  String _dataProductsDetails = '{}';

  String get getDataProducts => _dataProducts;
  String get getDataProductsDetails => _dataProductsDetails;

  void setDataProducts(data) {
    _dataProducts = data;
    notifyListeners();
  }

  void setDataProductsDetails(data) {
    _dataProductsDetails = data;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_dataProducts', _dataProducts));
  }
}
