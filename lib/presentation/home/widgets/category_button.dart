import 'package:flutter/material.dart';

// class CategoryButton extends StatelessWidget {
//   final String imagePath;
//   // final String imageUrl;
//   final String label;
//   final VoidCallback onPressed;

//   const CategoryButton({
//     super.key,
//     required this.imagePath,
//     // required this.imageUrl,
//     required this.label,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//       onTap: onPressed,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.network(
//               imagePath,
//               width: 80.0,
//               height: 80.0,
//               fit: BoxFit.contain,
//             ),
//             SizedBox(
//               width: 70.0,
//               child: Text(
//                 label,
//                 style: const TextStyle(),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CategoryButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              imagePath,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.contain,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Icon(
                    Icons.error); // Tangani kesalahan pemuatan gambar
              },
            ),
            SizedBox(
              width: 70.0,
              child: Text(
                label,
                style: const TextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
