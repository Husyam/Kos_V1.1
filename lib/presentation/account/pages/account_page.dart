import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kos_mobile_v2_testing/core/router/app_router.dart';
import 'package:kos_mobile_v2_testing/data/models/responses/auth_response_model.dart';
import 'package:kos_mobile_v2_testing/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/widgets/theme.dart';

import '../../auth/bloc/login/login_bloc.dart';
import '../../home/widgets/custom_button.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Akun',
          style: primaryMediumTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        backgroundColor: bgColor,
        // elevation: 1,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            color: bgColor,
            child: Column(
              children: [
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    final User user = state.maybeWhen(
                      orElse: () => User(
                        name: 'name',
                        email: 'email',
                        phone: 'phone',
                        roles: 'roles',
                      ),
                    );
                    return state.maybeWhen(
                      orElse: () {
                        return const SizedBox();
                      },
                      loaded: (authResponseModel) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: defaultMargin,
                            vertical: 24,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(
                              18,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 95,
                                height: 130,
                                // width: MediaQuery.of(context).size.width * 0.3,
                                // height: MediaQuery.of(context).size.height * 0.2,
                                margin: const EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  image: const DecorationImage(
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
                                      user.name!,
                                      style: blackMediumTextStyle.copyWith(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      user.phone!,
                                      style: greyLightTextStyle.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Laki-laki',
                                      style: blackMediumTextStyle.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Mahasiswa',
                                      style: blackMediumTextStyle.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    CustomButton(
                                      width: 110,
                                      margin: EdgeInsets.only(
                                        top: 28,
                                        // bottom: 30,
                                        //left: 10,
                                        right: 29,
                                      ),
                                      title: 'Edit Profile',
                                      textStyle: TextStyle(
                                        color: whiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      onPressed: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => EditAccount(),
                                        //   ),
                                        // );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
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
                            onPressed: () {},
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: redColor,
                                content: Text(message),
                              ),
                            );
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
                          // error: (message) {
                          //   return CustomButton(
                          //     title: 'Logout',
                          //     textStyle: TextStyle(
                          //       color: whiteColor,
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.w700,
                          //     ),
                          //     onPressed: () {
                          //       context
                          //           .read<LogoutBloc>()
                          //           .add(const LogoutEvent.logout());
                          //     },
                          //   );
                          // },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
