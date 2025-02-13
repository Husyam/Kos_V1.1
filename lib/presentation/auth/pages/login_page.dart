import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/core.dart';
import '../../../core/router/app_router.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/datasources/firebase_messaging_remote_datasouce.dart';
import '../bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', userId);
  }

  void onLoginSuccess(int userId) {
    saveUserId(userId);
    context.goNamed(
      RouteConstants.root,
      pathParameters: PathParameters().toMap(),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
        children: [
          const Text(
            'Login Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Hello, welcome back to our account',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(50.0),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email ID',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.email.svg(),
              ),
            ),
          ),
          const SpaceHeight(20.0),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.password.svg(),
              ),
            ),
          ),
          const SpaceHeight(50.0),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: (data) async {
                  AuthLocalDatasource().saveAuthData(data);
                  await FirebaseMessagingRemoteDatasource().initialize();
                  int userId = data.user?.idUser ??
                      0; // Mengakses userId dari objek User
                  onLoginSuccess(userId);
                },
                error: (message) {
                  if (mounted) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     backgroundColor: AppColors.red,
                    //     content: Text(message),
                    //   ),
                    // );
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: message,
                    );
                  }
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      context.read<LoginBloc>().add(
                            LoginEvent.login(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    },
                    label: 'Login',
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          const SpaceHeight(50.0),
          const Row(
            children: [
              Flexible(child: Divider()),
              SizedBox(width: 14.0),
              Text('OR'),
              SizedBox(width: 14.0),
              Flexible(child: Divider()),
            ],
          ),
          // buttonn text lupapassword
          InkWell(
            onTap: () {
              context.goNamed(RouteConstants.forgotPassword);
            },
            child: const Text(
              'Forgot Password?',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SpaceHeight(20.0),
          InkWell(
            onTap: () {
              context.goNamed(RouteConstants.register);
            },
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Not Registered yet? ',
                    style: TextStyle(
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: 'Create an Account',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
