library cool_stepper;

export './src/models/cool_step.dart';
export './src/models/cool_stepper_config.dart';

import './src/models/cool_step.dart';
import './src/models/cool_stepper_config.dart';
import './src/widgets/cool_stepper_view.dart';
import 'package:flutter/material.dart';

/// CoolStepper
class CoolStepper extends StatefulWidget {
  /// The steps of the stepper whose titles, subtitles, content always get shown.
  ///
  /// The length of [steps] must not change.
  final List<CoolStep> steps;

  /// Actions to take when the final stepper is passed
  final VoidCallback onCompleted;

  /// Padding for the content inside the stepper
  final EdgeInsetsGeometry contentPadding;

  /// CoolStepper config
  final CoolStepperConfig config;

  /// This determines if or not a snackbar displays your error message if validation fails
  ///
  /// default is false
  final bool showErrorSnackbar;

  const CoolStepper({
    Key key,
    @required this.steps,
    @required this.onCompleted,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20.0),
    this.config = const CoolStepperConfig(
      backText: "PREV",
      nextText: "NEXT",
      stepText: "STEP",
      ofText: "OF",
      finalText: "FINISH",
      backTextList: null,
      nextTextList: null,
    ),
    this.showErrorSnackbar = false,
  }) : super(key: key);

  @override
  _CoolStepperState createState() => _CoolStepperState();
}

class _CoolStepperState extends State<CoolStepper> {
  PageController _controller = PageController();

  int currentStep = 0;

  /* @override
  void dispose() {
    /* if (widget.steps.length - 1 == currentStep) {
      _controller.dispose();
      _controller = null;
    } */

    super.dispose();
  } */

  switchToPage(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  onStepNext() {
    String validation = widget.steps[currentStep].validation();
    if (validation == null) {
      if (!_isLast(currentStep)) {
        setState(() {
          currentStep++;
        });
        //FocusScope.of(context).unfocus();
        switchToPage(currentStep);
      } else {
        widget.onCompleted();
      }
    } else {
      // Show Error Snakbar
      if (widget.showErrorSnackbar) {
        final snackBar = SnackBar(content: Text(validation ?? "Error!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  onStepBack() {
    if (!_isFirst(currentStep)) {
      setState(() {
        currentStep--;
      });
      switchToPage(currentStep);
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Expanded(
      child: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: widget.steps.map((step) {
          return CoolStepperView(
            step: step,
            contentPadding: widget.contentPadding,
            config: widget.config,
          );
        }).toList(),
      ),
    );

    final counter = Container(
      child: Text(
        "${widget.config.stepText ?? 'STEP'} ${currentStep + 1} ${widget.config.ofText ?? 'OF'} ${widget.steps.length}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
        ),
      ),
    );

    String getNextLabel() {
      String nextLabel;
      if (_isLast(currentStep)) {
        nextLabel = widget.config.finalText ?? 'FINISH';
      } else {
        if (widget.config.nextTextList != null) {
          nextLabel = widget.config.nextTextList[currentStep];
        } else {
          nextLabel = widget.config.nextText ?? 'NEXT';
        }
      }
      return nextLabel;
    }

    String getPrevLabel() {
      String backLabel;
      if (_isFirst(currentStep)) {
        backLabel = '';
      } else {
        if (widget.config.backTextList != null) {
          backLabel = widget.config.backTextList[currentStep - 1];
        } else {
          backLabel = widget.config.backText ?? 'PREV';
        }
      }
      return backLabel;
    }

    final buttons = Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            onPressed: onStepBack,
            child: Text(
              getPrevLabel(),
              style: TextStyle(
                color: Colors.blue,
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          counter,
          TextButton(
            onPressed: onStepNext,
            child: Text(
              getNextLabel(),
              style: TextStyle(
                color: Colors.green,
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      child: Column(
        children: [content, buttons],
      ),
    );
  }
}
