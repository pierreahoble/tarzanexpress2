import 'package:flutter/material.dart';

import '../../cool_stepper.dart';
import '../../src/models/cool_step.dart';

class CoolStepperView extends StatelessWidget {
  final CoolStep step;
  final VoidCallback onStepNext;
  final VoidCallback onStepBack;
  final EdgeInsetsGeometry contentPadding;
  final CoolStepperConfig config;

  const CoolStepperView({
    Key key,
    @required this.step,
    this.onStepNext,
    this.onStepBack,
    this.contentPadding,
    this.config,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final Size dSize = MediaQuery.of(context).size;
    final title = Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 3.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: config.headerColor ??
            Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              step.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black38,
              ),
            ),
          ),
          /* Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 8),
                //width: dSize.width * 0.8,
                child: Text(
                  step.title, //.toUpperCase(),
                  style: config.titleTextStyle ??
                      TextStyle(
                        fontSize: dSize.width * 0.01,
                        //fontWeight: FontWeight.w600,
                        color: Colors.black38,
                      ),
                  //maxLines: 2,
                ),
              ),
              //SizedBox(width: 5.0),
              Visibility(
                visible: config.icon != null,
                child: Icon(
                  Icons.help_outline,
                  size: 18,
                  color: config.iconColor ?? Colors.black38,
                ),
                replacement: config.icon ?? Container(),
              )
            ],
          ), */
          Visibility(
            visible: ![null, ""].contains(step.subtitle),
            child: SizedBox(height: 5.0),
          ),
          Visibility(
            visible: ![null, ""].contains(step.subtitle),
            child: Text(
              step.subtitle ?? "",
              style: config.subtitleTextStyle ??
                  TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
            ),
          )
        ],
      ),
    );

    final content = Padding(
      padding: contentPadding,
      child: step.content,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [title, content],
      ),
    );
  }
}
