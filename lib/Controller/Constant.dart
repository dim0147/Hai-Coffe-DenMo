import 'package:get/get.dart';

enum CState {
  LOADING,
  DONE,
  ERROR,
}

class CBaseState {
  CState state;
  String? message;
  Rx<CBaseState>? getC;

  CBaseState(this.state, [this.message]);

  void setGetC(Rx<CBaseState> getC) {
    this.getC = getC;
  }

  void changeState(CState state, [String? message]) {
    this.state = state;
    this.message = message;
    refreshState();
  }

  void refreshState() {
    final getC = this.getC;
    if (getC != null) getC.refresh();
  }
}
