import '../../apiControl/apiManager.dart';
import '../../apiControl/apiServiceProvider.dart';
import '../../model/RegStResponse.dart';

class Getregstd {
  static Future<RegStdResponse> getRegStd({
    required String token,
    required String deviceId,
    required int DeviceType,
  }) async {
    final params = {
      "token": token,
      "deviceID": deviceId,
      "DeviceType": DeviceType,
    };

    print("🔹 API Params: $params");

    final response = await APIServices().apiRequest(APIManager.regStd, params);

    print("🔹 API Response: $response");

    return RegStdResponse.fromJson(response);
  }
}