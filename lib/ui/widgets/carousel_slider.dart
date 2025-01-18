import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarouselPopularWidget extends StatelessWidget {
  final bool userAdmin;

  const CarouselPopularWidget({
    super.key,
    required this.userAdmin,
  });

  String timeAgoSinceDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 1) {
      return '${difference.inDays} d oldin';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} soat ${difference.inMinutes % 60} min oldin';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} min oldin';
    } else {
      return '${difference.inSeconds} s oldin';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('posts').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        }

        final data = snapshot.data!.docs;

        if (data.isEmpty) {
          return const Center(
            child: Text('No posts available', style: TextStyle(fontSize: 20)),
          );
        }

        // Ma'lumotlarni kamayish tartibida saralash
        data.sort((a, b) {
          var timeA = a['time'].toDate();
          var timeB = b['time'].toDate();
          return timeB.compareTo(timeA);
        });

        final closestPosts = data.take(3).toList();
        final remainingPosts = data.skip(3).toList();

        return SingleChildScrollView(
          child: Column(
            children: [
              if (closestPosts.isNotEmpty)
                CarouselSlider(
                  items: closestPosts.map((doc) {
                    final info = doc['info'] ?? '';
                    final time = doc['time'].toDate();

                    return Container(
                      margin: EdgeInsets.only(left: 12),
                      height: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/treade.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ListTile(
                            title: Text(
                              'Gold Signal:\n$info',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              timeAgoSinceDate(time),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            trailing: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            )),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 190,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.9,
                    initialPage: 1,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ...remainingPosts.map((doc) {
                final info = doc['info'] ?? '';
                final time = doc['time'].toDate();

                return MyListTile(
                  buysell: doc['type'],
                  time: timeAgoSinceDate(time),
                  name: info.toString(),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}

class MyListTile extends StatelessWidget {
  String time;
  String name;
  String buysell;
  MyListTile({
    super.key,
    required this.buysell,
    required this.time,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/treade.jpg',
                ),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(buysell,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(Icons.access_time_rounded),
                  SizedBox(width: 2),
                  Text(time, style: TextStyle(fontSize: 16)),
                ],
              )
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_sharp),
          )
        ],
      ),
    );
  }
}
