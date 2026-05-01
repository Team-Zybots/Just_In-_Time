import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = 'http://10.0.2.2:8080/api'; 

  // --- Auth & OTP Functions ---
  static Future<http.Response> sendOtp(String email) async {
    return await http.post(
      Uri.parse('$baseUrl/auth/send-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
  }

  static Future<http.Response> verifyOtp(String email, String otp) async {
    return await http.post(
      Uri.parse('$baseUrl/auth/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );
  }

  
  static Future<http.Response> registerUser(Map<String, String> data, File? photo) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/auth/register'));
    
    request.fields.addAll(data);
    
    if (photo != null) {
      request.files.add(await http.MultipartFile.fromPath('idPhoto', photo.path));
    }

    // Convert the stream internally so the UI can still call .body
    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  // --- Doctor & Booking Functions ---
  static Future<List<dynamic>> getAllDoctors() async {
    final res = await http.get(Uri.parse('$baseUrl/doctors'));
    return res.statusCode == 200 ? json.decode(res.body) : [];
  }

  static Future<Map<String, dynamic>?> getDoctorById(String docId) async {
    final res = await http.get(Uri.parse('$baseUrl/doctors/$docId'));
    return res.statusCode == 200 ? json.decode(res.body) : null;
  }

  static Future<List<dynamic>> getQueueForDoctor(String docId) async {
    final res = await http.get(Uri.parse('$baseUrl/doctors/$docId/queue'));
    return res.statusCode == 200 ? json.decode(res.body) : [];
  }

  static Future<http.Response> bookAppointment(Map<String, dynamic> bookingData) async {
    return await http.post(
      Uri.parse('$baseUrl/appointments/book'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bookingData),
    );
  }

  static Future<List<dynamic>> getAppointmentsForPatient(dynamic patientId) async {
    final res = await http.get(Uri.parse('$baseUrl/appointments/patient/$patientId'));
    return res.statusCode == 200 ? json.decode(res.body) : [];
  }
}