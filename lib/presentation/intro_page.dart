import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:zenzone/application/getter.dart';

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
            padding: const EdgeInsets.only(top: 70.0),
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
                      aspectRatio: 1 / 1,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        current = index;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 	207, 177, 125),
                                  minimumSize: Size(double.infinity, 50), // Set the minimum width and height
                                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Set the border radius
                                  ),
                                ),
                                onPressed: () {
                                   getter.get<GetStorage>().write('monsterNumber', current);
                              getter.get<GetStorage>().write('isIntroDone', 'true');
                              String? isIntroDone = getter.get<GetStorage>().read('isIntroDone');
                              context.go('/home');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text('Select', style: TextStyle(color: Colors.white60, fontSize: 24, fontFamily: 'BraahOne')),
                                ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
