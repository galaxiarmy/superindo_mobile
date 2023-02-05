import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Future getAllProducts() async {
  var baseUrl = 'https://61ea514a7bc0550017bc66b4.mockapi.io/api/v1/products';
  var response = await http.get(
    Uri.parse(baseUrl),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    var responseJson = convert.jsonDecode(response.body);

    return (responseJson["products"]);
  } else {
    return [];
  }
}

Future getDetailProducts(baseUrl) async {
  var response = await http.get(
    Uri.parse(baseUrl),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    var responseJson = convert.jsonDecode(response.body);
    return (responseJson["data"]);
  } else {
    return {};
  }
}
