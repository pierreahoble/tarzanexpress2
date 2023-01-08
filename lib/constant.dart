import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trevashop_v2/Model/api_response.dart';

const String serverUrl = 'http://api.esuguserver.com/api/';
const String baseUrl = 'http://api.esuguserver.com/api/';

const resgisterUrl = baseUrl + 'register';
const loginUrl = baseUrl + 'login';
const paysUrl = baseUrl + 'pays';
const userCommandsLink = baseUrl + 'commande';
const leftToPayLink = baseUrl + "commande/checkout/lefttopay"; //reste a payer
const detailsLeftLink = baseUrl + "commande/checkout/lefttopay/details"; //

const SomethingWentWrong = "quelque chose s'est mal passé , Vueillez réssayer plus tard ";

const serverError = 'erreur serveur';
const UnAuthorized = 'Identifinat ou mot de passe incorrecte';
const FectDataError =
    'Error occured while Communication with Server with StatusCode:';

const Map<String, String> headers = {'accept': 'application/json'};

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

Future<dynamic> responseResult(Response response, ApiResponse apiResponse) {
  switch (response.statusCode) {
    case 200:
      apiResponse.data = apiResponse.data as List<dynamic>;
      print(apiResponse.data);
      break;

    case 422:
      apiResponse.data = apiResponse.data as List<dynamic>;
      return apiResponse.data;
      break;

    default:
      apiResponse.message = FectDataError;
      print("Rien ne marche");
      return null;
  }
}
