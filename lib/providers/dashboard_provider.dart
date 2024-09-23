// import 'dart:convert';
// import 'package:crew_app/models/Survey.dart';
// import 'package:crew_app/providers/base_provider.dart';
// import 'package:crew_app/shared/constants/constants.dart';
// import 'package:http/http.dart' as http;

// class SurveyProvider extends BaseProvider {
//   SurveyProvider(http.Client httpClient) : super();

//   Future<List<Survey>?> fetchSurveys({
//     int page = 1,
//     int limit = 10,
//     String? searchKeyword,
//   }) async {
//     final query = {
//       'page': page.toString(),
//       'limit': limit.toString(),
//     };

//     if (searchKeyword != null && searchKeyword.isNotEmpty) {
//       query['searchKeyword'] = searchKeyword;
//     }

//     final response = await get('/app-surveys', query: query);
//     if (response.statusCode == 200) {
//       final decodedJson = json.decode(response.body);

//       if (decodedJson is Map<String, dynamic> &&
//           decodedJson.containsKey('data') &&
//           decodedJson['data'].containsKey('docs')) {
//         final surveysList = <Survey>[];
//         for (var surveyJson in decodedJson['data']['docs']) {
//           surveysList.add(Survey.fromJson(surveyJson));
//         }
//         return surveysList;
//       } else {
//         return [];
//       }
//     } else {
//       return null;
//     }
//   }

//   Future<Map<String, List<Map<String, String>>>> filterOptions() async {
//     final employeeId = Constants.user!.employeeId;
//     final query = {'employeeId': employeeId};

//     final response = await get('/app-surveys/filter-options', query: query);

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> body = json.decode(response.body);
//       return {
//         'surveyTypes': (body['surveyTypes'] as List<dynamic>?)
//                 ?.map((e) => Map<String, String>.from(e))
//                 .toList() ??
//             [],
//       };
//     } else {
//       return {'surveyTypes': []};
//     }
//   }
// }
