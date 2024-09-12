import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/pages/areaPopuler/bidar_page.dart';

import '../../../../data/models/responses/category_response_model.dart';
import '../../bloc/category/category_bloc.dart';
import '../../pages/areaPopuler/uigm_page.dart';
import '../../pages/areaPopuler/uin_page.dart';
import '../../pages/areaPopuler/unsri_page.dart';
import '../category_button.dart';

// class MenuCategories extends StatefulWidget {
//   const MenuCategories({super.key});

//   @override
//   State<MenuCategories> createState() => _MenuCategoriesState();
// }

// class _MenuCategoriesState extends State<MenuCategories> {
//   @override
//   void initState() {
//     context.read<CategoryBloc>().add(const CategoryEvent.getCategories());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(
//         top: 18,
//       ),
//       padding: const EdgeInsets.symmetric(
//         horizontal: 14,
//         // vertical: 30,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(
//           12,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1), // shadow color with opacity
//             spreadRadius: 2, // spread radius
//             blurRadius: 10, // blur radius
//             offset: Offset(0, 4), // changes position of shadow
//           ),
//         ],
//       ),
//       child: BlocBuilder<CategoryBloc, CategoryState>(
//         builder: (context, state) {
//           return state.maybeWhen(
//             loaded: (categories) => Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ...categories.map(
//                   (Category) => Flexible(
//                     child: CategoryButton(
//                       // imagePath: Category.image!,
//                       imagePath: '',
//                       label: Category.name!,
//                       onPressed: () {},
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             orElse: () => const SizedBox.shrink(),
//           );
//           // return Row(
//           //   children: [
//           //     Flexible(
//           //       child: CategoryButton(
//           //         imagePath: Assets.images.categories.menuUin.path,
//           //         label: 'UIN',
//           //         onPressed: () {},
//           //       ),
//           //     ),
//           //     Flexible(
//           //       child: CategoryButton(
//           //         imagePath: Assets.images.categories.menuUnsri.path,
//           //         label: 'UNSRI',
//           //         onPressed: () {},
//           //       ),
//           //     ),
//           //     Flexible(
//           //       child: CategoryButton(
//           //         imagePath: Assets.images.categories.menuUigm.path,
//           //         label: 'UIGM',
//           //         onPressed: () {},
//           //       ),
//           //     ),
//           //     Flexible(
//           //       child: CategoryButton(
//           //         imagePath: Assets.images.categories.menuBidar.path,
//           //         label: 'BIDAR',
//           //         onPressed: () {},
//           //       ),
//           //     ),
//           //   ],
//           // );
//         },
//       ),
//     );
//   }
// }

class MenuCategories extends StatefulWidget {
  const MenuCategories({Key? key}) : super(key: key);

  @override
  State<MenuCategories> createState() => _MenuCategoriesState();
}

class _MenuCategoriesState extends State<MenuCategories> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(const CategoryEvent.getCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (categories) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categories.map(
                (Category category) {
                  final imageUrl = '${category.image}';
                  return Flexible(
                    child: CategoryButton(
                      imagePath: imageUrl,
                      label: category.name ?? 'Unknown',
                      onPressed: () {
                        //kondisi ke halamanan BidarPage, UigmPage, UinPage, UnsriPage sesuai dengan label
                        if (category.name == 'BIDAR') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BidarPage(),
                            ),
                          );
                        } else if (category.name == 'UIGM') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UigmPage(),
                            ),
                          );
                        } else if (category.name == 'UIN') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UinPage(),
                            ),
                          );
                        } else if (category.name == 'UNSRI') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UnsriPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Unknown category'),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ).toList(),
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
