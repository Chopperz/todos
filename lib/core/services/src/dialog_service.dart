import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todos_by_bloc/features/authentication/authentication.dart';
import 'package:todos_by_bloc/features/authentication/login/cubit/login_cubit.dart';

part "../../enums/src/dialog_service.dart";

part "../../extensions/src/dialog_type_extensions.dart";

class DialogService {
  static DialogService _instance = DialogService._();

  DialogService._();

  static Flushbar? _flushbar;

  static Flushbar get flushbar => _flushbar ?? Flushbar();

  factory DialogService() => _instance;

  Future<void> showMessage(
    context, {
    required DialogMessageType type,
    required String message,
    Color? backgroundColor,
  }) async {
    bool isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
    if (!isCurrent) {
      return;
    }

    _flushbar = Flushbar(
      icon: type.icon,
      messageSize: 23,
      messageText: Text(
        message,
        style: GoogleFonts.prompt(
          fontSize: 14,
          color: type.textColor,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 2,
      ),
      onTap: (f) => f.dismiss(),
      backgroundColor: backgroundColor ?? type.backgroundColor,
      flushbarPosition: FlushbarPosition.TOP,
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      positionOffset: 20,
      maxWidth: 580,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: BorderRadius.circular(12),
      borderColor: type.borderColor,
      margin: const EdgeInsets.symmetric(horizontal: 20),
    );

    Future.delayed(const Duration(milliseconds: 2000), () {
      try {
        if (flushbar.isShowing()) _flushbar!.dismiss();
      } catch (_) {
        rethrow;
      }
    });
    await _flushbar!.show(context);
  }

  static _Dialog of(BuildContext context) => _Dialog(context);
}

class _Dialog {
  const _Dialog(this.context);

  final BuildContext context;

  Future<void> showLogin() async {
    await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: false,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        );
      },
    );
  }
}
