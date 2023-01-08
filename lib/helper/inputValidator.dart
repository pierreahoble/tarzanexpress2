import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/authState.dart';

import 'enum.dart';

bool _containNumeric(String s) {
  for (int i = 0; i < s.length; i++) {
    if (double.tryParse(s[i]) != null) {
      return true;
    }
  }
  return false;
}

String validatePassword(String s, AuthState authState) {
  if (s == null || s.isEmpty) {
    return "Entrer un mot de passe!";
  }
  if (s.length < 8) {
    return "Au moins 8 caractères requis";
  }
  authState.password = s;
  return null;
}

String validateConfirmPassword(String s, AuthState authState) {
  if (s != authState.password) {
    return "Les mots de passe ne correspondent pas";
  }
  return null;
}

String validateNom(String s) {
  if (s == null || s.isEmpty) {
    return "N'oubliez pas votre nom!";
  }
  if (_containNumeric(s)) {
    return 'Nom Invalide!';
  }
  /* if (s.contains(" ")) {
    return "Entrez un nom sans espace";
  } */
  return null;
}

String validatePrenoms(String s) {
  if (s == null || s.isEmpty) {
    return "N'oubliez pas votre prénom!";
  }
  if (_containNumeric(s)) {
    return 'Prénom Invalide!';
  }
  return null;
}

String validateCodeParrainage(String s) {
  if (s == null || s.isEmpty) {
    return "N'oubliez pas le code!";
  }
  return null;
}

String validateEmail(String s) {
  if (s != null && s.isNotEmpty) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(s)) {
      return "Veuillez entrer un email valide! (L'email est facultatif)";
    }
  }
  /* if (s == null || s.isEmpty) {
    return "N'oubliez pas votre email!";
  } */
  return null;
}

String inputValidator(
    {@required String val,
    @required Inputs inputType,
    @required BuildContext context}) {
  AuthState authState = Provider.of<AuthState>(context, listen: false);
  String reponse;
  switch (inputType) {
    case Inputs.Email:
      reponse = validateEmail(val);
      break;
    case Inputs.Nom:
      reponse = validateNom(val);
      break;
    case Inputs.Prenoms:
      reponse = validatePrenoms(val);
      break;
    case Inputs.Password:
      reponse = validatePassword(val, authState);
      break;
    case Inputs.ConfirmPassword:
      reponse = validateConfirmPassword(val, authState);
      break;
    case Inputs.CodeParrainage:
      reponse = validateCodeParrainage(val);
      break;
    case Inputs.Telephone:
      break;
    default:
  }
  return reponse;
}
