import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://ecotrack-rm92.onrender.com";

  // Common headers
  static Map<String, String> get headers => {
    "Content-Type": "application/json",
  };

  // POST request
  static Future<http.Response> post(String endpoint, {Object? body}) async {
    final url = Uri.parse("$baseUrl$endpoint");

    return await http.post(url, headers: headers, body: body);
  }

  static Future<http.Response> getWithAuth(
    String endpoint,
    String token,
  ) async {
    final url = Uri.parse("$baseUrl$endpoint");

    return await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  static Future<http.Response> postWithAuth(
    String endpoint,
    String token, {
    Object? body,
  }) async {
    final url = Uri.parse("$baseUrl$endpoint");

    return await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );
  }

  static Future<http.Response> postStatusUpdate(
    String token,
    Object body,
  ) async {
    final url = Uri.parse("$baseUrl/pickups/status");

    return await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );
  }

  // ✅ PUT update pickup status
  static Future<http.Response> updatePickupStatus(
    String token,
    Object body,
  ) async {
    final url = Uri.parse("$baseUrl/pickups/status");

    return await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );
  }

  static Future<http.Response> putWithAuth(
    String endpoint,
    String token, {
    Object? body,
  }) async {
    final url = Uri.parse("$baseUrl$endpoint");

    return await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );
  }
}
