import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../bloc/forgot/forgot_bloc.dart';
import 'package:gif/gif.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRemoteDatasource(),
      child: BlocProvider(
        create: (context) => ForgotBloc(
          context.read<AuthRemoteDatasource>(),
        ),
        child: Builder(
          builder: (context) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Gif(
                        // fps: 20,
                        // duration: const Duration(seconds: 10),
                        autostart: Autostart.loop,
                        placeholder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        image: const AssetImage(
                            'assets/icons/Animation - 1728871619714.gif'),
                      ),
                    ],
                  ),
                  const Text(
                    'Please enter your email address to reset your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<ForgotBloc, ForgotState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        error: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message)),
                          );
                        },
                        loaded: () {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title:
                                'Silahkan cek email anda untuk melakukkan reset password',
                          );
                        },
                        orElse: () {},
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        orElse: () => ElevatedButton(
                          onPressed: () {
                            context.read<ForgotBloc>().add(
                                  ForgotEvent.forgotPassword(
                                    email: emailController.text,
                                  ),
                                );
                          },
                          child: const Text('Send Email'),
                        ),
                      );
                    },
                  ),

                  //kondisi jika email sudah dikirim ada tombol untuk kembali ke login
                  BlocBuilder<ForgotBloc, ForgotState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loaded: () => ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Back to Login'),
                        ),
                        orElse: () => const SizedBox(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
