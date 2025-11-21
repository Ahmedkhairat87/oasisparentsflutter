import 'dart:convert';
import 'package:http/http.dart' as http;

class APIServices {
  Future<dynamic> apiRequest(String path, Map<String, dynamic> params) async {
    try {
      Uri uri = Uri.parse(path);

      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
          body: jsonEncode(params),
      );

      print("🔹 Status code: ${response.statusCode}");
      print("🔹 Response body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 204) {
        // No Content = غالبًا يوزر أو باسورد غلط
        return {
          "success": false,
          "message": "Invalid username or password",
          "token": null,
        };
      } else {
        return {
          "success": false,
          "message": "Request failed",
          "statusCode": response.statusCode
        };
      }

    } catch (e) {
      print("❌ Exception: $e");
      throw Exception("Network or server error: $e");
    }
  }

  // Future<dynamic> apiRequest(String path, Map<String, dynamic> params) async  {
  //     try {
  //       Uri uri = Uri.parse(path);
  //
  //       var response = await http.post(
  //         uri,
  //         headers: {'Content-Type': 'application/json',},
  //         body: jsonEncode(params),
  //       );
  //
  //       print("🔹 Status code: ${response.statusCode}");
  //       print("🔹 Response body: ${response.body}");
  //       if (response.statusCode == 200) {
  //         //json to map
  //         return jsonDecode(response.body);
  //       } else {
  //         return {
  //           "success": false,
  //           "message": "Request failed",
  //           "statusCode": response.statusCode
  //         };
  //       }
  //     } catch (e) {
  //       print("❌ Exception: $e");
  //       return {
  //         "success": false,
  //         "message": "Exception occurred",
  //         "error": e.toString()
  //       };
  //     }
  // }
  }
