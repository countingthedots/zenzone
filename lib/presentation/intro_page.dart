import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:zenzone/application/locator.dart';

class IntroPage extends StatelessWidget {
  //const IntroPage({super.key});

  static const List<String> imageList = [
    'lib/assets/images/m1.png',
    'lib/assets/images/m2.png',
    'lib/assets/images/m3.png',
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Hey! I am your personal assistant\n\nI will help you overcome anxiety and panic attacks.\n\nFirst, choose my appearance\n',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'BraahOne',
                      color: Colors.black54,
                      // Set text color
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  CarouselSlider(
                    items: imageList.map((imageUrl) {
                      return Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 350.0,
                      autoPlay: false,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        current = index;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: const Color.fromRGBO(222, 184, 117, 1),
                      ),
                      onPressed: () {
                            locator.get<GetStorage>().write('monsterNumber', current);
                            locator.get<GetStorage>().write('isIntroDone', 'true');
                            context.go('/home');
                          },
                      child: const Text(
                        'Select',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
