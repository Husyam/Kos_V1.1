import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kos_mobile_v2_testing/presentation/home/widgets/theme.dart';
import 'package:quickalert/quickalert.dart';

import '../../../core/router/app_router.dart';
import '../../home/widgets/custom_button.dart';
import '../bloc/register/register_bloc.dart';
import '../widgets/custom_field_password.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _onSignUpPressed(BuildContext context) {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = contactController.text.trim();
    final password = passwordController.text.trim();

    print('Name: $name');
    print('Email: $email');
    print('Phone: $phone');
    print('Password: $password');

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    context.read<RegisterBloc>().add(
          RegisterEvent.register(
            name: name,
            email: email,
            phone: phone,
            password: password,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    Widget logo() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 50,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'Find Kostan',
              style: blackBoldTextStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    Widget title() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register Account',
              style: blackBoldTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Welcome back, Please enter your detail.',
              style: greyMediumTextStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    }

    Widget inputSection() {
      Widget nameInput() {
        return CustomTextFormField(
          title: 'Full Name',
          hintText: 'Input your name',
          controller: nameController,
        );
      }

      Widget emailInput() {
        return CustomTextFormField(
          title: 'Email Address',
          hintText: 'Input your email',
          controller: emailController,
        );
      }

      Widget contactInput() {
        return CustomTextFormField(
          title: 'No HP',
          hintText: 'Input your No.telpon',
          controller: contactController,
          // keyboardType: TextI,
        );
      }

      Widget passwordInput() {
        return PasswordField(controller: passwordController);
      }

      return Container(
        margin: const EdgeInsets.only(
          top: 18,
          bottom: 18,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nameInput(),
            emailInput(),
            contactInput(),
            passwordInput(),
          ],
        ),
      );
    }

    Widget registerToPage() {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                'Forgot Password?',
                style: primaryMediumTextStyle.copyWith(
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  decorationColor: primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget submitButton() {
      return BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (response) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(content: Text('Registrasi berhasil!')),
              // );

              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'Success',
                text: 'Registrasi berhasil! Silahkan login',
              );

              context.goNamed(
                RouteConstants.login,
                pathParameters: PathParameters().toMap(),
              );
            },
            error: (message) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text(message)),
              // );

              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: message,
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return CustomButton(
            title: 'Sign up',
            width: 312,
            onPressed: () => _onSignUpPressed(context),
          );
        },
      );
    }

    Widget pageToRegister() {
      return Container(
        margin: const EdgeInsets.only(
          top: 24,
          bottom: 50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an account? ',
              style: greyMediumTextStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.goNamed(RouteConstants.login);
              },
              child: Text(
                'Sign in',
                style: primaryMediumTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            logo(),
            title(),
            inputSection(),
            registerToPage(),
            submitButton(),
            pageToRegister(),
          ],
        ),
      ),
    );
  }
}
