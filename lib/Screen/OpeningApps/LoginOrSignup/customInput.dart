import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/onSaved.dart';
import 'package:trevashop_v2/constants/appColors.dart';
import 'package:trevashop_v2/helper/enum.dart';
import 'package:trevashop_v2/helper/inputValidator.dart';
import 'package:trevashop_v2/state/authState.dart';



class CustomInput extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final String hintText;
  final Inputs input;
  final TextInputAction textInputAction;
  final OnSaved onSavedType;
  final int maxLine;
  final int maxLength;
  final bool passwordShowable;
  CustomInput({
    @required this.label,
    @required this.keyboardType,
    @required this.input,
    @required this.hintText,
    @required this.textInputAction,
    @required this.onSavedType,
    @required this.maxLine,
    @required this.maxLength,
    this.passwordShowable,
  });
  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    Size dSize = MediaQuery.of(context).size;
    AuthState authState = Provider.of<AuthState>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: dSize.height * 0.007),
        Text(
          widget.label,
          style: TextStyle(color: AppColors.indigo),
        ),
        Theme(
          data: new ThemeData(
            primaryColor: AppColors.indigo,
          ),
          child: TextFormField(
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLine,
            textInputAction: widget.textInputAction,
            maxLength: widget.maxLength,
            initialValue: (widget.onSavedType == OnSaved.Nom)
                ? authState.nom
                : ((widget.onSavedType == OnSaved.Prenoms)
                    ? authState.prenoms
                    : ((widget.onSavedType == OnSaved.Email)
                        ? authState.email
                        : ((widget.onSavedType == OnSaved.CodeParrainage)
                            ? authState.codeParrainage
                            : ((widget.onSavedType == OnSaved.Password)
                                ? authState.password
                                : ((widget.onSavedType ==
                                        OnSaved.ConfirmPassword)
                                    ? authState.confirmPassword
                                    : (authState.telephone)))))),
            obscureText: (widget.passwordShowable == null
                ? (widget.keyboardType == TextInputType.visiblePassword)
                : (!showPassword)),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                //fontWeight: FontWeight.w600,
              ),
              suffixIcon: (widget.passwordShowable != null)
                  ? IconButton(
                      icon: (showPassword)
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      })
                  : null,
            ),
            validator: (val) => inputValidator(
                val: val, inputType: widget.input, context: context),
            onSaved: (val) =>
                onSaved(context, onSaved: widget.onSavedType, val: val),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
