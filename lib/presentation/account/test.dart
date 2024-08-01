import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/models/responses/auth_response_model.dart';
import '../auth/bloc/logout/logout_bloc.dart';
import '../home/widgets/custom_button.dart';
import '../home/widgets/theme.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData != null) {
      setState(() {
        user = authData.user;
      });
    }
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
        centerTitle: true,
      ),
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Container(
                  color: bgColor,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                          vertical: 24,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 95,
                              height: 130,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/images/Profile.png'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user?.name ?? 'name',
                                    style: blackMediumTextStyle.copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    user?.phone ?? '089634134984',
                                    style: greyLightTextStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    user?.roles ?? 'Laki-laki',
                                    style: blackMediumTextStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  CustomButton(
                                    width: 120,
                                    margin: const EdgeInsets.only(
                                      top: 28,
                                      right: 29,
                                    ),
                                    title: 'Edit Profile',
                                    textStyle: TextStyle(
                                      color: whiteColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                          borderRadius: BorderRadius.circular(18),
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
                                const SizedBox(width: 12),
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
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/history_icons.png',
                                  width: 25 * 2,
                                ),
                                const SizedBox(width: 12),
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
                      const SizedBox(height: 24),
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


// return Container(
                    //   margin: EdgeInsets.symmetric(
                    //     horizontal: defaultMargin,
                    //     vertical: 24,
                    //   ),
                    //   padding: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     color: whiteColor,
                    //     borderRadius: BorderRadius.circular(
                    //       18,
                    //     ),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: 95,
                    //         height: 130,
                    //         // width: MediaQuery.of(context).size.width * 0.3,
                    //         // height: MediaQuery.of(context).size.height * 0.2,
                    //         margin: const EdgeInsets.only(right: 16),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(18),
                    //           image: const DecorationImage(
                    //             fit: BoxFit.cover,
                    //             image: AssetImage(
                    //               'assets/images/Profile.png',
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               'name',
                    //               style: blackMediumTextStyle.copyWith(
                    //                 fontSize: 18,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 4,
                    //             ),
                    //             Text(
                    //               '089634134984',
                    //               style: greyLightTextStyle.copyWith(
                    //                 fontSize: 14,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 4,
                    //             ),
                    //             Text(
                    //               'Laki-laki',
                    //               style: blackMediumTextStyle.copyWith(
                    //                 fontSize: 14,
                    //               ),
                    //             ),
                    //             Text(
                    //               'Mahasiswa',
                    //               style: blackMediumTextStyle.copyWith(
                    //                 fontSize: 14,
                    //               ),
                    //             ),
                    //             CustomButton(
                    //               width: 110,
                    //               margin: EdgeInsets.only(
                    //                 top: 28,
                    //                 // bottom: 30,
                    //                 //left: 10,
                    //                 right: 29,
                    //               ),
                    //               title: 'Edit Profile',
                    //               textStyle: TextStyle(
                    //                 color: whiteColor,
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w700,
                    //               ),
                    //               onPressed: () {
                    //                 // Navigator.push(
                    //                 //   context,
                    //                 //   MaterialPageRoute(
                    //                 //     builder: (context) => EditAccount(),
                    //                 //   ),
                    //                 // );
                    //               },
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );