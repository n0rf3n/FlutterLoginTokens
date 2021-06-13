import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider {
  //Petición para FireBase

  String _fireBaseToken = '';
  String _url =
      'identitytoolkit.googleapis.com'; //v1/accounts:signUp?key=$_fireBaseToken'
  String _path = 'v1/accounts:signUp';

  Future newUser(String email, String password) async {
    final authData = {
      //Body codificado.
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final Uri _uriS = Uri.https(
      _url,
      _path,
      {"key": _fireBaseToken},
    );

    print(_uriS.toString());

    http.Response response =
        await http.post(_uriS, body: json.encode(authData));

    Map<String, dynamic> decodedData = json.decode(response.body);

    print(decodedData);

    if (decodedData.containsKey('idToken')) {
      //TODO Almacenar el token en el storage
      return {'ok': true, 'token': decodedData['idToken']};
    } else {
      //Error
      return {'ok': false, 'token': decodedData['error']['message     ']};
    }
  }
}
