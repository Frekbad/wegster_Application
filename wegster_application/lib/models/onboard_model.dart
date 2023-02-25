// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wegster_application/exports/exports.dart';

class OnboardModel {
  final String img;
  final String title;
  final String desc;

  OnboardModel({
    required this.img,
    required this.title,
    required this.desc,
  });
}

List<OnboardModel> screens = [
  OnboardModel(
    img: "assets/image/lopi.svg",
    title: 'Book with us',
    desc:
        'Buy bus ticket or book a Hotel. You choose the destination, we make the rest',
  ),
  OnboardModel(
    img: "assets/image/pay.svg",
    title: 'Pay with a tap',
    desc:
        'Sign up to Book your desirable tickets. You\'ll get Special Options and offers to use right away! ',
  ),
  OnboardModel(
    img: "assets/image/explore.svg",
    title: 'Explore Yourself',
    desc:
        'Extremely convinent and easy app for bus booking and Hotel across the country.',
  ),
];
