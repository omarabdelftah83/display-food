import 'dart:async';

import 'package:mina/presention/common/state_renderer/state_renderer.dart';

import '../common/state_renderer/state_renderer_imp.dart';

abstract class BaseViewModel extends BaseViewModelInput
    with BaseViewModelOutput {
  ///stream to  state renderer//
  final StreamController _inputStreamController =
      StreamController<FlowState>.broadcast();

  @override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  // TODO: implement outputState
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInput {
  void start();

  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutput {
  Stream<FlowState> get outputState;

  /// connection to view ///

}
