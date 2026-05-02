import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = 'http://10.0.2.2:8082/api'; // FIXED: was 8080
  static const Duration _timeout = Duration(seconds: 10);   // ADDED: timeouts

  static Future<http.Response> sendOtp(String email) async {
    return await http.post(
      Uri.parse('$baseUrl/auth/send-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    ).timeout(_timeout);
  }

  static Future<http.Response> verifyOtp(String email, String otp) async {
    return await http.post(
      Uri.parse('$baseUrl/auth/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    ).timeout(_timeout);
  }

  static Future<http.Response> registerUser(Map<String, String> data, File? photo) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/auth/register'));
    request.fields.addAll(data);
    if (photo != null) {
      request.files.add(await http.MultipartFile.fromPath('idPhoto', photo.path));
    }
    final streamedResponse = await request.send().timeout(_timeout);
    return await http.Response.fromStream(streamedResponse);
  }

  // FIXED: was /doctors (wrong) → correct is /doctors/all
  static Future<List<dynamic>> getAllDoctors() async {
    final res = await http.get(Uri.parse('$baseUrl/doctors/all')).timeout(_timeout);
    return res.statusCode == 200 ? json.decode(res.body) : [];
  }

  static Future<Map<String, dynamic>?> getDoctorById(String docId) async {
    final res = await http.get(Uri.parse('$baseUrl/doctors/$docId')).timeout(_timeout);
    return res.statusCode == 200 ? json.decode(res.body) : null;
  }

  // FIXED: was /doctors/$docId/queue (wrong) → correct is /appointments/queue/$docId
  static Future<List<dynamic>> getQueueForDoctor(String docId) async {
    final res = await http.get(Uri.parse('$baseUrl/appointments/queue/$docId')).timeout(_timeout);
    return res.statusCode == 200 ? json.decode(res.body) : [];
  }

  static Future<http.Response> bookAppointment(Map<String, dynamic> bookingData) async {
    return await http.post(
      Uri.parse('$baseUrl/appointments/book'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bookingData),
    ).timeout(_timeout);
  }

  static Future<List<dynamic>> getAppointmentsForPatient(dynamic patientId) async {
    final res = await http.get(Uri.parse('$baseUrl/appointments/patient/$patientId')).timeout(_timeout);
    return res.statusCode == 200 ? json.decode(res.body) : [];
  }
}