import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../services/api_service.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = "jwt_token";
  static const _pickupIdKey = "pickup_id";

  // 📝 REGISTER USER
  static Future<Map<String, dynamic>> registerUser({
    required String userName,
    required String password,
    required String phoneNumber,
    required String address,
    required String role,
  }) async {
    final response = await ApiService.post(
      "/public/register",
      body: jsonEncode({
        "userName": userName,
        "password": password,
        "phoneNumber": phoneNumber,
        "address": address,
        "role": role,
      }),
    );

    // Handle response
    if (response.statusCode == 200) {
      return {"success": true, "message": "User registered successfully"};
    } else if (response.statusCode == 403) {
      return {"success": false, "message": "Registration failed (Forbidden)"};
    } else {
      return {"success": false, "message": "Something went wrong"};
    }
  }

  //User Login
  static Future<Map<String, dynamic>> loginUser({
    required String userName,
    required String password,
  }) async {
    final response = await ApiService.post(
      "/users/login",
      body: jsonEncode({"userName": userName, "password": password}),
    );

    if (response.statusCode == 200) {
      final token = response.body; // JWT string
      
      // Save token
      await _storage.write(key: _tokenKey, value: token);

      return {"success": true, "token": token};
    } else {
      return {"success": false, "message": "Invalid credentials"};
    }
  }

  // ✅ CHECK SESSION STATUS
  static Future<bool> isSessionValid() async {
    final token = await _storage.read(key: _tokenKey);
    
    if (token == null || token.isEmpty) return false;

    try {
      // Check if token is expired
      bool isExpired = JwtDecoder.isExpired(token);
      if (isExpired) {
        await logout(); // Clear expired token
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // ✅ GET STORED TOKEN
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // ✅ GET USERNAME FROM TOKEN
  static Future<String?> getUsernameFromToken() async {
    final token = await _storage.read(key: _tokenKey);
    if (token == null) return null;
    
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken['sub']; // 'sub' is standard for username/subject
    } catch (e) {
      return null;
    }
  }

  // ✅ MANAGE PICKUP ID
  static Future<void> savePickupId(String id) async {
    await _storage.write(key: _pickupIdKey, value: id);
  }

  static Future<String?> getPickupId() async {
    return await _storage.read(key: _pickupIdKey);
  }

  static Future<void> clearPickupId() async {
    await _storage.delete(key: _pickupIdKey);
  }

  // ✅ LOGOUT
  static Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _pickupIdKey);
  }

  // ✅ GET PROFILE
  static Future<Map<String, dynamic>> getUserProfile(String token) async {
    final response = await ApiService.getWithAuth("/users/profile", token);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return {"success": true, "data": data};
    } else {
      return {"success": false};
    }
  }

  // ✅ CHECK ACTIVE PICKUP
  static Future<Map<String, dynamic>> getActivePickup(String token) async {
    final response = await ApiService.getWithAuth("/pickups/active", token);

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return {"success": true, "isActive": true, "pickupId": response.body};
      } else {
        return {"success": true, "isActive": false};
      }
    } else {
      return {"success": false};
    }
  }

  // 🚛 CREATE PICKUP
  static Future<Map<String, dynamic>> createPickup({
    required String token,
    required String requestDate,
    required double latitude,
    required double longitude,
  }) async {
    final response = await ApiService.postWithAuth(
      "/pickups",
      token,
      body: jsonEncode({
        "requestDate": requestDate,
        "latitude": latitude,
        "longitude": longitude,
      }),
    );

    // ✅ SUCCESS (NEW PICKUP)
    if (response.statusCode == 200) {
      return {"success": true, "pickupId": response.body};
    }

    // ⚠️ ACTIVE PICKUP EXISTS → FETCH IT
    if (response.statusCode == 403) {
      final activeRes = await ApiService.getWithAuth("/pickups/active", token);

      if (activeRes.statusCode == 200 && activeRes.body.isNotEmpty) {
        return {"success": true, "pickupId": activeRes.body};
      }
    }

    return {"success": false};
  }

  // 🔄 UPDATE PICKUP STATUS
  static Future<bool> updatePickupStatus({
    required String token,
    required String pickupId,
    required String status,
    int? points,
  }) async {
    final Map<String, dynamic> body = {"pickupId": pickupId, "status": status};

    if (points != null) {
      body["points"] = points;
    }

    final response = await ApiService.putWithAuth(
      "/pickups/status",
      token,
      body: jsonEncode(body),
    );

    return response.statusCode == 200;
  }
}
