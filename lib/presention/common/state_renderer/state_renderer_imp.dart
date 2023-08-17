import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mina/app/constant.dart';
import 'package:mina/presention/common/state_renderer/state_renderer.dart';
import 'package:mina/presention/resources/string_manager.dart';

///connect between view & state renderer//

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

///loading state ==> pop & fulScreen  //
class LoadingState extends FlowState {
  StateRendererType stateRendererType;

  ///ful or pop
  String? message;

  LoadingState(
      {required this.stateRendererType, String message = AppString.loading});

  @override
  String getMessage() => message ?? AppString.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

///error state==> pop & ful Screen //
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

//to do
  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

///content state//
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constant.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

///empty state
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

///extension//==> connect between flowSate StateRenderer//
extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            ///show popup loading
            showPopup(context, getMessage(), getStateRendererType());

            ///show content of the screen
            return contentScreenWidget;
          } else {
            ///full screen
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction,
                message: getMessage());
          }
        }
      case ErrorState:
        {
          //dismissDialog(context);

          if (getStateRendererType() == StateRendererType.popupErrorState) {
            ///show popup error
            showPopup(context, getMessage(), getStateRendererType());

            ///show content of the screen
            return contentScreenWidget;
          } else {
            ///full screen
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction,
                message: getMessage());
          }
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionFunction: () {},
            message: getMessage(),
          );
        }
      case ContentState:
        {
         // dismissDialog(context);

          return contentScreenWidget;
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  ///show dialog///
  showPopup(BuildContext context, String message,
      StateRendererType stateRendererType) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
        context: context,
        //builder==> need ui
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {})));
  }

  ///close dialog if in it
  _isCurrentDialogShowing(BuildContext context) {
    ModalRoute.of(context)?.isCurrent != true;
  }

  ///close old dialog
  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}
