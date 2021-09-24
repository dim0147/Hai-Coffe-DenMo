import 'package:hai_noob/App/Utils.dart';

class ShowSnackBarArgs {
  final String title;
  final String text;
  final Duration? duration;

  ShowSnackBarArgs({required this.title, required this.text, this.duration});
}

class DefaultScreentArgs {
  final ShowSnackBarArgs? showSnackBarArgs;

  DefaultScreentArgs(this.showSnackBarArgs);

  void runOnInit() async {
    await Future.delayed(Duration(seconds: 1));
    _showSnackBar();
  }

  void _showSnackBar() {
    final args = showSnackBarArgs;
    if (args != null) Utils.showSnackBar(args.title, args.text, args.duration);
  }
}
