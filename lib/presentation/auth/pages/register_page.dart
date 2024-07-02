import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kos_mobile_v2_testing/presentation/home/widgets/theme.dart';

import '../../../core/router/app_router.dart';
import '../../home/pages/homepage.dart';
import '../../home/widgets/custom_button.dart';
import '../widgets/custom_field_password.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController contactController =
      TextEditingController(text: '');
  final TextEditingController jenKelController =
      TextEditingController(text: '');
  final TextEditingController profesiController =
      TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget logo() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 50,
            ),
            SizedBox(
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
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign in To  FindKos',
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
          keyboardType: 'number',
        );
      }

      Widget jenKelInput() {
        return CustomTextFormField(
          title: 'Jenis Kelamin',
          hintText: 'Jenis Kelamin',
          controller: jenKelController,
        );
      }

      Widget profesiInput() {
        return CustomTextFormField(
          title: 'Profesi',
          hintText: 'Input your profesi',
          controller: profesiController,
        );
      }

      Widget passwordInput() {
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Input Your Password'),
            SizedBox(
              height: 14,
            ),
            PasswordField(),
          ],
        );
      }

      return Container(
        margin: EdgeInsets.only(
          top: 18,
          bottom: 18,
        ),
        padding: EdgeInsets.symmetric(
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
            jenKelInput(),
            profesiInput(),
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
      return Container(
        margin: EdgeInsets.only(
          top: 24,
        ),
        child: CustomButton(
          title: 'Login',
          width: 312,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      );
    }

    Widget pageToRegister() {
      return Container(
        margin: EdgeInsets.only(
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
