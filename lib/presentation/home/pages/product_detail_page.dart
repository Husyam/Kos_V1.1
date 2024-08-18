import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kos_mobile_v2_testing/core/extensions/int_ext.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/router/app_router.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/models/responses/product_response_mode.dart';
import '../models/facility_item.dart';
import '../widgets/carousel.dart';
import '../widgets/custom_button.dart';
import '../widgets/theme.dart';

class ProductDetailPage extends StatefulWidget {
  // final ProductModel data;
  final Product data;

  const ProductDetailPage({super.key, required this.data});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final fasilitas = {
    // ['AC', 'Wifi', 'Kulkas', 'TV', 'Kamar Mandi', smoking area]
    'AC': 'assets/images/fasilitas/icons8-ac-96.png',
    'Wifi': 'assets/images/fasilitas/icons8-wifi-96.png',
    'Kulkas': 'assets/images/fasilitas/icons8-refrigerator-96.png',
    'TV': 'assets/images/fasilitas/icons8-television-100.png',
    'Kamar Mandi': 'assets/images/fasilitas/icons8-toilet-96.png',
    'Smoking Area': 'assets/images/fasilitas/icons8-smoking-64.png',

    //get Aset Gen Image
  };

  // final List<String> fasilitas = [
  //   Assets.images.iconAc.path,
  //   Assets.images.wifi.path,
  //   Assets.images.refrigerator.path,
  //   Assets.images.bedroom.path,
  //   Assets.images.smokingArea.path,
  //   Assets.images.tv.path,
  //   Assets.images.toilet.path,
  // ];

  bool isFavorite = false;

  Future<void> _checkFavoriteStatus() async {
    AuthLocalDatasource localDatasource = AuthLocalDatasource();
    List<Product> favorites = await localDatasource.getFavorites();
    setState(() {
      isFavorite = favorites
          .any((product) => product.idProduct == widget.data.idProduct);
    });
  }

  Future<void> _toggleFavorite() async {
    AuthLocalDatasource localDatasource = AuthLocalDatasource();
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      await localDatasource.saveFavorite(widget.data);
    } else {
      await localDatasource.removeFavorite(widget.data);
    }

    // Return the updated favorite status
    Navigator.pop(context, isFavorite);
  }

  @override
  void initState() {
    _checkFavoriteStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    launchUrl(String url) async {
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        launch(url);
      } else {
        // throw (url);
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => Text('Errorr'),
          ),
        );
      }
    }

    final String phoneNumber = "+62${widget.data.noKontak}";
    const String message = "Saya ingin konfirmasi kamar kos ini";

    void launchWhatsApp() async {
      var whatsappUrl =
          "whatsapp://send?phone=$phoneNumber&text=${Uri.parse(message)}";

      try {
        await launch(whatsappUrl);
      } catch (e) {
        print("Error launching WhatsApp: $e");
        // Handle or show error message as needed
      }
    }

    return Scaffold(
      backgroundColor:
          bgColor, // ubah bgColor ke Colors.white atau warna yang diinginkan
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            NestedScrollView(
              headerSliverBuilder: (
                BuildContext context,
                bool innerBoxIsScrolled,
              ) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: widget.data.multiImage != null &&
                            widget.data.multiImage!.isNotEmpty
                        ? CarouselSliderWithDots(
                            items: widget.data.multiImage ?? [],
                          )
                        : const Center(
                            child: Text('No images available'),
                          ),
                  ),
                ];
              },
              body: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      color: whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 33,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.data.name!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight
                                          .w600, // ubah primaryMediumTextStyle
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: widget.data.price!.currencyFormatRp,
                                      style: primaryRegularTextStyle.copyWith(
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' /Bulan',
                                          style: greyLightTextStyle.copyWith(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 2),
                                height: 38,
                                width: 108,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Sisa ${widget.data.stock} Kamar',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight
                                          .w600, // ubah redMediumTextStyle
                                      color:
                                          Colors.red, // ubah redMediumTextStyle
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 24), // ubah defaultMargin
                          child: Text(
                            'Main Facilities',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold, // ubah blackBoldTextStyle
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24, // ubah defaultMargin
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.data.fasilitas!.isEmpty
                                  ? const Text('Tidak Ada Fasilitas')
                                  : Row(
                                      children: widget.data.fasilitas!
                                          .map(
                                            (facility) => FacilityItem(
                                              name: facility,
                                              imageUrl: fasilitas[facility] ??
                                                  'assets/images/fasilitas/icons8-error-80.png',
                                              //total: 0,
                                            ),
                                          )
                                          .toList(),
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 24), // ubah defaultMargin
                          child: Text(
                            'Deskripsi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold, // ubah blackBoldTextStyle
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24, // ubah defaultMargin
                          ),
                          child: Text(
                            widget.data.description!,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey, // ubah greyRegularTextStyle
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 24), // ubah defaultMargin
                          child: Text(
                            'Lokasi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold, // ubah blackBoldTextStyle
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24, // ubah defaultMargin
                          ),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  double.parse(widget.data
                                      .latitude!), // latitude from API data
                                  double.parse(widget.data
                                      .longitude!), // longitude from API data
                                ),
                                zoom: 15,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId('product_location'),
                                  position: LatLng(
                                    double.parse(widget.data
                                        .latitude!), // latitude from API data
                                    double.parse(widget.data
                                        .longitude!), // longitude from API data
                                  ),
                                ),
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24, // ubah defaultMargin
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 24,
                                  horizontal: 13,
                                ),
                                decoration: BoxDecoration(
                                  color: bgColor, // ubah bgColor
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/images/Profile.png',
                                        width: 55,
                                        height: 55,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.data.name!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight
                                                .w600, // ubah primaryMediumTextStyle
                                          ),
                                        ),
                                        Text(
                                          widget.data.nameOwner!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors
                                                .grey, // ubah greyRegularTextStyle
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        launchUrl(
                                          'tel:${widget.data.noKontak}',
                                        );
                                      },
                                      child: Image.asset(
                                        'assets/images/call_icons.png',
                                        width: 30,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        launchWhatsApp();
                                      },
                                      child: Image.asset(
                                        'assets/images/whatsapp_icons.png',
                                        width: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: CustomButton(
                            title: 'Ajukan Sewa',
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/btn_back.png',
                      width: 40,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _toggleFavorite();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: isFavorite
                          ? const Icon(
                              Icons.favorite,
                              size: 30,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              size: 30,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
