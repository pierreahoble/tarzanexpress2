import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trevashop_v2/helper/enum.dart';
import 'package:trevashop_v2/state/authState.dart';



onSaved(BuildContext context,
    {@required OnSaved onSaved, @required String val}) {
  AuthState state = Provider.of<AuthState>(context, listen: false);
  switch (onSaved) {
    case OnSaved.Email:
      state.email = val;
      break;
    case OnSaved.Nom:
      state.nom = val;
      break;
    case OnSaved.Prenoms:
      state.prenoms = val;
      break;
    case OnSaved.Telephone:
      state.telephone = val;
      break;
    case OnSaved.Password:
      state.password = val;
      break;
    case OnSaved.ConfirmPassword:
      state.confirmPassword = val;
      break;
    case OnSaved.CodeParrainage:
      state.codeParrainage = val;
      break;
    default:
  }
}
