import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'model.dart';
import 'package:http/http.dart' as http;

const url = 'http://10.0.2.2/dbpm_api/';

Future<List<stok>> fetchLaptop(http.Client client) async {
  final response = await client.get(Uri.parse('${url}list.php'));
  //debugPrint(response.body);
  return compute(parseLaptop, response.body);
}

List<stok> parseLaptop(String responseBody){
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<stok>((json)=>stok.fromJson(json)).toList();
}