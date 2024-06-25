import 'package:flutter/material.dart';

import '../../../core/components/custom_dropdown.dart';
import '../../../core/components/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/date_picker.dart';
import '../widgets/theme.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({Key? key}) : super(key: key);

  final firstNameController = TextEditingController();
  final numberContactController = TextEditingController();

  Widget durasi(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double indentValue = screenWidth * 0.0; // 10% dari lebar layar
    double endIndentValue = screenWidth * 0.0; // 10% dari lebar layar

    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Durasi Ngekos',
            style: blackBoldTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          //create btn add and minus here for duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '-',
                    style: whiteMediumTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '1',
                      style: blackMediumTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const TextSpan(
                      text: '-',
                    ),
                    TextSpan(
                      text: 'Bulan',
                      style: blackMediumTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '+',
                    style: whiteMediumTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Divider(
            color: Colors.grey, // Warna garis
            thickness: 1, // Ketebalan garis
            indent: indentValue,
            endIndent: endIndentValue,
          ),
        ],
      ),
    );
  }

  Widget total(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Total',
          //   style: blackBoldTextStyle.copyWith(
          //     fontSize: 14,
          //   ),
          // ),
          // Text(
          //   'Total',
          //   style: blackBoldTextStyle.copyWith(
          //     fontSize: 14,
          //   ),
          // ),
          // const SizedBox(
          //   height: 12.0,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: blackMediumTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              Text(
                'Rp 1.500.000',
                style: blackMediumTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: blackMediumTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              Text(
                'Rp 1.500.000',
                style: blackMediumTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18.0,
          ),
          CustomButton(
            title: 'Selanjutnya',
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => PaymentPage(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Text(
            'Detail Pesanan',
            style: primaryMediumTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
          backgroundColor: whiteColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: primaryColor,
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 24,
          ),
          children: [
            CustomTextField(
              controller: firstNameController,
              label: 'Nama',
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomDropdown<String>(
              value: '-',
              items: const ['-', 'Laki-laki', 'Perempuan'],
              label: 'Jenis Kelamin',
              onChanged: (value) {
                print('Selected value: $value');
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomDropdown(
              value: '-',
              items: const ['-', 'Mahasiswa', 'Pekerja', 'Lainnya'],
              label: 'Profesi',
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomTextField(
              controller: numberContactController,
              label: 'No hp/WhatsApp',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 24.0,
            ),
            const PagePicker(),
            const SizedBox(
              height: 24.0,
            ),
            durasi(
              context,
            ),
            total(
              context,
            ),
          ],
        ));
  }
}
