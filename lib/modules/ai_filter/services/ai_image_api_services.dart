import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class AiImageApiServices {
  Future<Uint8List> removeBgApi(String imagePath) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.remove.bg/v1.0/removebg"),
    );
    request.files.add(
      await http.MultipartFile.fromPath("image_file", imagePath),
    );
    const apiKey = String.fromEnvironment("REMOVE_IMAGE_BG_API_KEY");
    request.headers.addAll({"X-API-Key": apiKey});

    final response = await request.send();
    log("AI Response: ${response.statusCode}");
    if (response.statusCode == 200) {
      http.Response imgRes = await http.Response.fromStream(response);
      return imgRes.bodyBytes;
    } else {
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }
}
