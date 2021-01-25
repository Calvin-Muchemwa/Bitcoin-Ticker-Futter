import 'dart:convert';

import 'package:http/http.dart'as http;
import 'price_screen.dart';

class NetworkHelper{

final String url;
NetworkHelper({this.url});


  Future getRequest()async{
    http.Response response= await http.get(url);//When we http.get we recieve a response of type response
try {
  if (response.statusCode == 200) {
    String data = response
        .body; //we are interested in whats in the body of the response
    var decodeddata = jsonDecode(data);
    return decodeddata;
  }

}catch(e){
      print(e);
    }

  }


}