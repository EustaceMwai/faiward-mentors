import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/A1.jpg',
    title: 'About Faiward Mentors',
    description:
        'Faiward Mentors is a mentorship organization registered under the Kenyan government in 2016. Faiward derives from two English words Faith forward, it was founded by Roz Haki a Motivational Speaker & Mentor. ',
  ),
  Slide(
    imageUrl: 'assets/images/A1.jpg',
    title: 'Mission statement',
    description:
        'To Motivate & empowers others towards positive experience in both their personal & corporate development.',
  ),
  Slide(
    imageUrl: 'assets/images/A1.jpg',
    title: 'Objective',
    description:
        '	To address issues affecting our personal & Corporate development, 	To empower others into full realization of their potential',
  ),
];
