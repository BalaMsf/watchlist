import 'package:http/http.dart' as http;
import 'package:watchlist/constants/constants.dart';
import 'package:watchlist/models/contactlistmodel.dart';

class NetworkService {
  Future<List<Contactlistmodel>?> getContactlist() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.endUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Contactlistmodel> model = contactlistmodelFromJson(response.body);
        return model;
      } else {
        return [];
      }
    } catch (_) {
      return [];
    }
  }
}
