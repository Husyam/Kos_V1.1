import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/router/app_router.dart';
import '../../../data/models/responses/auth_response_model.dart';
import '../../auth/bloc/logout/logout_bloc.dart';
import '../../home/pages/favorite_page.dart';
import '../../home/widgets/custom_button.dart';
import '../../home/widgets/theme.dart';
import '../bloc/get_profile/get_profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;
  const ProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<GetProfileBloc>().add(
          GetProfileEvent.getProfile(widget.userId),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Akun',
        ),
        backgroundColor: bgColor,
        centerTitle: true,
      ),
      backgroundColor: bgColor,
      body: BlocBuilder<GetProfileBloc, GetProfileState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: primaryColor,
                size: 50,
              ),
            ),
            loaded: (user) => buildProfileUI(user),
            error: (message) => Center(
              child: Text(message),
            ),
            orElse: () => const Center(
              child: Text('Something went wrong'),
            ),
          );
        },
      ),
    );
  }

  Widget buildProfileUI(User user) {
    return ListView(
      children: [
        Container(
          color: bgColor,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
                padding: const EdgeInsets.only(
                  left: 12,
                  top: 18,
                  bottom: 18,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 95,
                          height: 130,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/Profile.png',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name ?? 'Name not available',
                                style: blackMediumTextStyle.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                user.phone ?? 'Phone not available',
                                style: greyLightTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                user.roles ?? 'Role not available',
                                style: blackMediumTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              CustomButton(
                                width: 110,
                                margin: EdgeInsets.only(
                                  top: 28,
                                  right: 29,
                                ),
                                title: 'Edit Profile',
                                textStyle: TextStyle(
                                  color: whiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                onPressed: () {
                                  context.goNamed(
                                    RouteConstants.editProfile,
                                    pathParameters: PathParameters().toMap(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/Love_icons.png',
                          width: 25 * 2,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FavoritePage(),
                              ),
                            );
                          },
                          child: Text(
                            'Kos Favorit',
                            style: blackMediumTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/history_icons.png',
                          width: 25 * 2,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        //text button riwayat sewa kos
                        TextButton(
                          onPressed: () {
                            context.pushNamed(
                              RouteConstants.orderList,
                              pathParameters: PathParameters().toMap(),
                            );
                          },
                          child: Text(
                            'Riwayat Sewa Kos',
                            style: blackMediumTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 38,
                width: 110,
                child: Center(
                  child: BlocConsumer<LogoutBloc, LogoutState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        loaded: () {
                          context.goNamed(
                            RouteConstants.root,
                            pathParameters: PathParameters().toMap(),
                          );
                        },
                        error: (message) {
                          context.goNamed(
                            RouteConstants.login,
                            // pathParameters: PathParameters().toMap(),
                          );
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     backgroundColor: redColor,
                          //     content: Text(message),
                          //   ),
                          // );
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return CustomButton(
                            title: 'Logout',
                            textStyle: TextStyle(
                              color: whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            onPressed: () {
                              context.read<LogoutBloc>().add(
                                    const LogoutEvent.logout(),
                                  );
                            },
                          );
                        },
                        loading: () {
                          return const CircularProgressIndicator();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
