import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:riverpod_demo/domain/Serializer.dart';
import 'package:riverpod_demo/utils/Strings.dart';

import 'Connection.dart';

enum RequestType {get, post,put,delete}

class NetworkClient{
  //Singleton
  NetworkClient._privateConstructor();
  static final NetworkClient _instance = NetworkClient._privateConstructor();
  static NetworkClient get instance => _instance;

  //check connection status
  var connectionStatus;
  final _connect = Connection.getInstance();

  //http client
  Client client = Client();

  final Map<String, String> _headers = {
    'Content-type': 'application/json;charset=UTF-8',
    'Accept': 'application/json',
    'Charset': 'utf-8'
  };

  Future<T> performWebRequest<T>(RequestType type, Uri url, {dynamic body}) async {
    //Response initialization
    Response response;

    //checks for the connection status and updates boolean
    await _connect.checkConnection().then((status) => connectionStatus=status);

    //runs only if connection exists
    if(connectionStatus){
      try{
        //Identify the request type
        switch(type){
          case RequestType.get:
            response = await client.get(url, headers: _headers);
            break;
          case RequestType.post:
            response = await client.post(url, headers: _headers, body: body != null ? json.encoder.convert(body) : "");
            break;
          case RequestType.put:
            response = await client.put(url, headers: _headers, body: json.encoder.convert(body));
            break;
          case RequestType.delete:
            response = await client.delete(url, headers: _headers);
            break;
        }
        print("Network call ${response.statusCode} $url");

        switch (response.statusCode) {
          case 200:
          // If the call to the server was successful, parse the JSON and initialize the data model.
            if (response.body == "") {
              return Serializer.fromJson<T>(true);
            }
            else {
              final a = Serializer.fromJson<T>(json.decode(response.body));
              return a;
            }
          case 204:
            return Serializer.fromJson<T>(true);
          case 400:
            if(json.decode(response.body)['title'] == null){
              throw Exception(json.decode(response.body));
            }else{
              throw Exception(json.decode(response.body)['title']);
            }
          case 401:
          case 404:
          case 422:
            throw Exception(json.decode(response.body)['title']);
          case 500:
            throw Exception("${response.statusCode} ${Strings.requestError}");
          default:
            throw Exception("Error ${response.statusCode} ${response.body}");
        }
      }
      on TimeoutException{
        throw Exception(Strings.serverTimeout);
      }
      on SocketException{
        throw Exception(Strings.serverTimeout);
      }
    }
    else{
      throw Exception(Strings.noInternet);
    }
  }
}