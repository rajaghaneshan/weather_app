import 'dart:convert';

import 'package:http/http.dart';

class NetworkHelper{
  final String url;

  NetworkHelper(this.url);

  Future getData() async{
    Response response = await get(Uri.parse(url));
    print(response);
    if (response.statusCode == 200){
      String data = response.body;
      // print(data);
      var decodedData = jsonDecode(data);
      // print(decodedData);
      return decodedData;
    }else{
      print(response.statusCode);
    }
  }

}