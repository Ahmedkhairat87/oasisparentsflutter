import 'package:http/http.dart' as http;

class APIServices {

  apiRequest(String path , Map<String,dynamic> params) async {
    Uri uri = Uri.https("api1.oasisdemaadi.com/api/",path,params);

    var response = await http.post(uri);

    if (response.statusCode == 200){

    }


  }




}