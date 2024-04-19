import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/providers/user_bloc/user_bloc.dart';
import 'package:todos_by_bloc/core/services/services.dart';
import 'package:todos_by_bloc/core/widgets/src/text_field/text_form_field.dart';
import 'package:todos_by_bloc/features/authentication/login/cubit/login_cubit.dart';

export 'package:todos_by_bloc/features/authentication/login/cubit/login_cubit.dart';

part '../widgets/socials_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  bool _isObscureText = true;
  bool _disabledButton = true;

  void usernameListener() {
    if (usernameCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty && _disabledButton) {
      setState(() {
        _disabledButton = false;
      });
    }

    if (usernameCtrl.text.isEmpty && !_disabledButton) {
      setState(() {
        _disabledButton = true;
      });
    }
  }

  void passwordListener() {
    if (passwordCtrl.text.isNotEmpty && usernameCtrl.text.isNotEmpty && _disabledButton) {
      setState(() {
        _disabledButton = false;
      });
    }

    if (passwordCtrl.text.isEmpty && !_disabledButton) {
      setState(() {
        _disabledButton = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    usernameCtrl.addListener(usernameListener);
    passwordCtrl.addListener(passwordListener);
  }

  @override
  void dispose() {
    usernameCtrl.removeListener(usernameListener);
    passwordCtrl.removeListener(passwordListener);
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          width: context.mediaQuery.size.width,
          height: context.mediaQuery.size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/app-bg.jpeg"),
              fit: BoxFit.fill,
              opacity: 0.9,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
            top: kToolbarHeight,
          ),
          child: BlocConsumer<LoginCubit, LoginState>(
            bloc: context.read<LoginCubit>(),
            buildWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              if (state.status.isSuccess) {
                context
                  ..read<UserBloc>().add(const FetchUserEvent())
                  ..back();
              }

              if (state.status.isError) {
                DialogService().showMessage(
                  context,
                  type: DialogMessageType.ERROR,
                  message: "Your username or password is incorrect.",
                );
              }
            },
            builder: (context, state) {
              if (state.status.isProcessing) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LOGIN",
                    style: GoogleFonts.sixtyfour(
                      color: Colors.white,
                      fontSize: 42,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Divider(
                    indent: 150,
                    endIndent: 150,
                    color: Colors.grey.shade100,
                    height: 20,
                    thickness: 1.5,
                  ),
                  const Gap(10),
                  SocialsLoginWidget(),
                  const Gap(30),
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        AppTextFormFiled(
                          title: "Username",
                          hintText: "Please enter your username",
                          controller: usernameCtrl,
                          textInputAction: TextInputAction.next,
                          prefixIcon: Icon(
                            Icons.person,
                            size: 20,
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                        Gap(15),
                        AppTextFormFiled(
                          title: "Password",
                          hintText: "Please enter your password",
                          controller: passwordCtrl,
                          obscureText: _isObscureText,
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 20,
                            color: context.theme.colorScheme.secondary,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() => _isObscureText = !_isObscureText);
                            },
                            color: Colors.grey.shade500,
                            icon: Icon(_isObscureText ? Icons.visibility : Icons.visibility_off),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding:
                                    MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
                              ),
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(30),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_disabledButton) return;

                          context
                              .read<LoginCubit>()
                              .onLogin(username: usernameCtrl.text, password: passwordCtrl.text);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((_) {
                            if (_disabledButton) {
                              return Colors.transparent;
                            }
                            return Colors.green;
                          }),
                          fixedSize: MaterialStatePropertyAll<Size>(
                            const Size.fromHeight(45),
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: GoogleFonts.notoSans(
                            color: Colors.grey.shade200,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
