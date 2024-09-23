// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// abstract class BaseProvider {
//   final http.Client httpClient;

//   BaseProvider(this.httpClient);

//   Future<http.Response> get(String endpoint,
//       {Map<String, dynamic>? query}) async {
//     final uri = Uri.parse('https://yourapi.com$endpoint')
//         .replace(queryParameters: query);
//     return await httpClient.get(uri);
//   }
// }
