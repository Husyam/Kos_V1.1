import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/auth/widgets/custom_field_password.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:kos_mobile_v2_testing/data/models/responses/edit_profile_response_model.dart';

import '../bloc/edit_profile/edit_profile_bloc.dart';
import '../bloc/get_profile/get_profile_bloc.dart';
import '../widget/custom_input_decoration.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final user = context.read<GetProfileBloc>().state.maybeWhen(
          loaded: (user) => user,
          orElse: () => null,
        );
    if (user != null) {
      // Set the initial text of the text fields
      _nameController.text = user.name ?? '';
      _emailController.text = user.email ?? '';
      _phoneController.text = user.phone ?? '';
      // You can also set the password field, but be careful with password security
      // _passwordController.text = user.password ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TextFormField(
              //   controller: _nameController,
              //   decoration: const InputDecoration(labelText: 'Name'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your name';
              //     }
              //     return null;
              //   },
              // ),
              // TextFormField(
              //   controller: _nameController,
              //   decoration: const InputDecoration(labelText: 'Name'),
              //   validator: (value) {
              //     return null;
              //   },
              // ),
              TextFormField(
                controller: _nameController,
                decoration: CustomInputDecoration(
                  // labelText: 'Name',
                  // labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: CustomInputDecoration(
                  // labelText: 'Email',
                  // labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                decoration: CustomInputDecoration(
                  // labelText: 'Phone',
                  // labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // TextFormField(
              //   controller: _passwordController,
              //   decoration: const InputDecoration(labelText: 'Password'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your password';
              //     }
              //     return null;
              //   },
              // ),
              PasswordField(
                controller: _passwordController,
              ),
              const SizedBox(height: 16),
              BlocConsumer<EditProfileBloc, EditProfileState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {
                      //loading
                      // return Center(
                      //   child: LoadingAnimationWidget.discreteCircle(
                      //       color: Colors.white,
                      //       size: 45,
                      //       secondRingColor: Colors.black,
                      //       thirdRingColor: Colors.purple),
                      // );
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    },
                    loaded: (User user) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Profile updated successfully'),
                        ),
                      );
                      Navigator.pop(context);
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //add duration
                            await Future.delayed(const Duration(seconds: 1));
                            context.read<EditProfileBloc>().add(
                                  EditProfileEvent.updateProfile(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    phone: _phoneController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          }
                        },
                        child: const Text('Update Profile'),
                      );
                    },
                    loading: () {
                      return Center(
                        child: LoadingAnimationWidget.discreteCircle(
                            color: Colors.white,
                            size: 45,
                            secondRingColor: Colors.black,
                            thirdRingColor: Colors.purple),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
