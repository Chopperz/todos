import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/providers/providers.dart';
import 'package:todos_by_bloc/core/widgets/widgets.dart';

import '../cubit/register_cubit.dart';

export '../cubit/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<RegisterCubit>(context);

    return Container(
      width: context.mediaQuery.size.width,
      height: context.mediaQuery.size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigoAccent.shade100,
            Colors.indigoAccent.shade200,
            Colors.indigoAccent,
            Colors.indigoAccent.shade400,
            Colors.indigoAccent.shade700,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "REGISTER",
            style: GoogleFonts.notoSans(
              fontSize: 24,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<UserBloc>().add( const FetchUserEvent());
              context.backUntil(predicate: (route) => route.isFirst);
            }
          },
          buildWhen: (prev, curr) => prev != curr,
          builder: (context, state) {
            if (state.status.isProcessing) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              );
            }

            return ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                AppTextFormFiled(
                  title: "Email",
                  hintText: "Please enter your email",
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icon(
                    Icons.person,
                    size: 20,
                    color: context.theme.colorScheme.secondary,
                  ),
                  isRequireField: true,
                  errorText: state.errorText,
                  onChanged: (String value) => provider.onEmailChanged(value),
                ),
                const Gap(20),
                AppTextFormFiled(
                  title: "Password",
                  hintText: "Please enter your password",
                  obscureText: _isObscureText,
                  isRequireField: true,
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
                  onChanged: (String value) => provider.onPasswordChanged(value),
                ),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: AppTextFormFiled(
                        title: "Firstname",
                        hintText: "Firstname",
                        textInputAction: TextInputAction.next,
                        isRequireField: true,
                        onChanged: (String value) => provider.onFirstNameChanged(value),
                      ),
                    ),
                    const Gap(20),
                    Expanded(
                      child: AppTextFormFiled(
                        title: "Lastname",
                        hintText: "Lastname",
                        textInputAction: TextInputAction.next,
                        isRequireField: true,
                        onChanged: (String value) => provider.onLastNameChanged(value),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    SizedBox(
                      width: context.mediaQuery.size.width / 2 - 30,
                      child: AppTextFormFiled(
                        title: "Nickname",
                        hintText: "Nickname (Optional)",
                        textInputAction: TextInputAction.next,
                        onChanged: (String value) {
                          provider.onNickNameChanged(value);
                        },
                      ),
                    ),
                    const Gap(20),
                    Expanded(
                      child: BlocSelector<RegisterCubit, RegisterState, String>(
                        selector: (state) => state.user.dateOfBirth ?? "",
                        builder: (context, dob) {
                          return AppTextFormFiled.datetime(
                            title: "Date of Birth",
                            hintText: "Date of Birth",
                            isRequireField: true,
                            controller: TextEditingController.fromValue(
                              TextEditingValue(text: dob),
                            ),
                            onSelectDateTime: (DateTime? dateTime) {
                              if (dateTime != null) {
                                String dob = DateFormat("yyyy-MM-dd").format(dateTime).toString();
                                provider.onDateOfBirth(dob);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(30),
                BlocSelector<RegisterCubit, RegisterState, bool>(
                  selector: (state) => state.isAvailableRegister,
                  builder: (context, isAvailableRegister) {
                    return ElevatedButton(
                      onPressed: () {
                        if (isAvailableRegister) {
                          context.read<RegisterCubit>().onSubmitRegister();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith((_) {
                          if (!isAvailableRegister) {
                            return Colors.transparent;
                          }
                          return Colors.green;
                        }),
                        fixedSize: WidgetStatePropertyAll<Size>(
                          Size(context.mediaQuery.size.width - 40 - 20, 45),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      child: Text(
                        "Confirm",
                        style: GoogleFonts.notoSans(
                          color: Colors.grey.shade200,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
