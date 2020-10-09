import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getProduct(name) async {
  try {
    final String url =
        'https://grofers.com/v5/search/merchants/28730/products/?lat=28.504595&lon=77.302707&q=$name&suggestion_type=0&t=1&start=0&size=48';
    final response = await http.get(url, headers: {
      "auth_key":
          "e1982a4fd4952fa34e241e8e28d040b87e337413e4da45b9cff7032edf4d695b"
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);

      var items = responseBody["products"];

      var product = items[0];
      print(product);
      return {
        "brand_type": product["line_1"],
        "image_url": product["image_url"],
        "discount": product["disc_amt"],
        "mrp": product["mrp"],
        "price": product["price"],
      };
    } else {
      throw Exception('Failed to load Data');
    }
  } catch (err) {
    log(err.toString());
    return {
      "brand_type": name,
      "image_url": null,
      "discount": 0,
      "mrp": 0,
      "price": 0,
    };
  }
}
