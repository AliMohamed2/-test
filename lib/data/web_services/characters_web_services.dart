import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testa/constant/string.dart';
class CharactersWebServices{
  late Dio dio;
  CharactersWebServices(){
    BaseOptions options= BaseOptions(
      baseUrl: baseurl,
      receiveDataWhenStatusError: true ,
      connectTimeout: 20*1000,
      receiveTimeout: 20*1000,

    ); dio=Dio(options);
}
Future<List<dynamic>>getAllCharacters()async{
    try{
      Response response=await dio.get('characters');
      print (response.data.toString());
      return response.data;
    }catch(e){
      print(e.toString());
      return[];
    }


}
}