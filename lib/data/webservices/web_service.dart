import 'package:http/http.dart'as http;
import 'package:valorantgame/constant/constant.dart';

class WebServices
{
  //get data api

  Future<dynamic> getAgent()async{
    final response= await http.get(Uri.parse(QueryApi));
    return response;
  }





}