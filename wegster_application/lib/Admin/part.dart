// import 'package:feedme/Api/DjangoAuthAPI.dart';
// import 'package:feedme/CustomerPanel/search.dart';
// import 'package:feedme/packages/Packages.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// import '../Models/user_cubit.dart';
// import '../Models/user_models.dart';

// class RestaurantPage extends StatefulWidget {
//   final int Restaurant_ID;
//   final String Restaurant_Name;
//   final String Restaurant_Email;
//   final String Restaurant_Location;
//   final String Restaurant_PhoneNumber;
//   final String Restaurant_Image;
//   final String Restaurant_Cousine;
//   final String Restaurant_ProfileImage;

//   const RestaurantPage(
//       {Key,
//       key,
//       required this.Restaurant_ID,
//       required this.Restaurant_Name,
//       required this.Restaurant_Email,
//       required this.Restaurant_Location,
//       required this.Restaurant_PhoneNumber,
//       required this.Restaurant_Image,
//       required this.Restaurant_Cousine,
//       required this.Restaurant_ProfileImage});

//   @override
//   State<RestaurantPage> createState() => _RestaurantPageState();
// }

// class _RestaurantPageState extends State<RestaurantPage> {
//   final TextEditingController ReviewTextController = TextEditingController();
//   String? Rating;
//   final _formKey = GlobalKey<FormState>();

//   final style = TextStyle(
//       fontSize: 20.sp, color: Colors.grey[800], fontWeight: FontWeight.w900);

//   final style2 = TextStyle(
//       fontSize: 22.sp, color: Colors.grey[800], fontWeight: FontWeight.w800);

//   final style3 = TextStyle(
//     fontSize: 12.sp,
//     color: Colors.grey[800],
//   );

//   final style5 = TextStyle(
//     fontSize: 16.sp,
//     color: Colors.grey[800],
//     fontWeight: FontWeight.w800,
//   );

//   final style7 = TextStyle(
//     fontSize: 14.sp,
//     color: Colors.grey[600],
//     fontWeight: FontWeight.w800,
//   );

//   final style8 = TextStyle(
//     fontSize: 16.sp,
//     color: Colors.grey[600],
//     fontWeight: FontWeight.w800,
//   );

//   final style6 = TextStyle(
//     fontSize: 12.sp,
//     color: Colors.grey[500],
//   );

//   final style4 = TextStyle(
//     fontSize: 12.sp,
//     fontWeight: FontWeight.w500,
//     color: Colors.grey[600],
//   );

//   @override
//   Widget build(BuildContext context) {
//     int ID = widget.Restaurant_ID;
//     Users user = context.read<UserCubit>().state;
//     String Restaurant_Name = widget.Restaurant_Name;
//     int Restaurant_ID = widget.Restaurant_ID;
//     int userID = user.id!;
//     String Restaurant_Location = widget.Restaurant_Location;
//     String Restaurant_ProfileImage = widget.Restaurant_ProfileImage;

//     final font = TextStyle(color: Colors.grey[800], fontSize: 16.sp);

//     final TextForm = TextFormField(
//       decoration: InputDecoration(
//         labelText: 'Review',
//       ),
//       maxLines: 3,
//       keyboardType: TextInputType.multiline,
//       controller: ReviewTextController,
//       textInputAction: TextInputAction.done,
//       onSaved: (value) {
//         ReviewTextController.text = value!.toString();
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return ("Empty Field");
//         }
//         return null;
//       },
//     );

//     final RatingButton = Material(
//         elevation: 5.0,
//         borderRadius: BorderRadius.circular(5.0),
//         color: Colors.purple[700],
//         child: MaterialButton(
//           minWidth: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.all(18.h),
//           child: Text(
//             'Submit',
//             style: TextStyle(color: Colors.white, fontSize: 16.sp),
//           ),
//           onPressed: () async {
//             if (_formKey.currentState!.validate()) {
//               postReview(Rating!, ReviewTextController.text, Restaurant_Name,
//                   user.Fullname!, Restaurant_ID);
//               GetReviews(Restaurant_ID);
//               setState(() {});
//               Navigator.of(context).pop();
//             }
//           },
//         ));

//     final ReviewButton = Material(
//         elevation: 5.0,
//         borderRadius: BorderRadius.circular(5.0),
//         color: Colors.purple[700],
//         child: MaterialButton(
//           minWidth: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.all(18.h),
//           child: Text(
//             'Write a Review',
//             style: TextStyle(color: Colors.white, fontSize: 16.sp),
//           ),
//           onPressed: () async {
//             showModalBottomSheet(
//                 shape: RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(15.h.w))),
//                 context: context,
//                 builder: (context) {
//                   return SingleChildScrollView(
//                     child: Container(
//                       height: 450.h,
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                             right: 20.w, left: 20.w, top: 15.h, bottom: 15.h),
//                         child: Form(
//                           key: _formKey,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text(
//                                         "Cancel",
//                                         style:
//                                             GoogleFonts.lato(textStyle: font),
//                                       ),
//                                     ),
//                                   ]),
//                               SizedBox(
//                                 height: 30.h,
//                               ),
//                               TextForm,
//                               SizedBox(
//                                 height: 20.h,
//                               ),
//                               RatingBar.builder(
//                                 initialRating: 0,
//                                 minRating: 1,
//                                 direction: Axis.horizontal,
//                                 allowHalfRating: true,
//                                 itemCount: 5,
//                                 itemPadding:
//                                     EdgeInsets.symmetric(horizontal: 5.0.w),
//                                 itemBuilder: (context, _) => Icon(
//                                   Icons.star,
//                                   color: Colors.amber,
//                                 ),
//                                 onRatingUpdate: (rating) {
//                                   Rating = rating.toString();
//                                   print(rating);
//                                 },
//                               ),
//                               SizedBox(
//                                 height: 30.h,
//                               ),
//                               RatingButton
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 });
//           },
//         ));

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(80.h), // Set this height
//         child: SafeArea(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 4,
//                   offset: Offset(5, 0), // changes position of shadow
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding:
//                       EdgeInsets.only(left: 15.0.w, right: 20.0.w, top: 15.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Icon(
//                           Icons.arrow_back,
//                           size: 25.h,
//                         ),
//                       ),
//                       Text(
//                         "Feed Me",
//                         style: GoogleFonts.lato(
//                           textStyle: style2,
//                         ),
//                       ),
//                       GestureDetector(
//                         child: Container(
//                           padding: EdgeInsets.all(5.0.h),
//                           decoration: BoxDecoration(
//                               color: Colors.blueGrey[50],
//                               border: Border.all(
//                                 color: Colors.transparent,
//                               ),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20.h.w))),
//                           child: LineIcon(
//                             LineIcons.search,
//                             size: 24.h,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                         onTap: () {
//                           showSearch(context: context, delegate: SearchUser());
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 15.0.w, top: 5.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "${user.Address}",
//                         style: GoogleFonts.poppins(
//                           textStyle: style4,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//           child: Column(
//         children: [
//           Container(
//             height: 240.h,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 1,
//                   blurRadius: 1,
//                   offset: Offset(5, 0), // changes position of shadow
//                 ),
//               ],
//               image: DecorationImage(
//                   image: NetworkImage(widget.Restaurant_Image),
//                   fit: BoxFit.fill),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(
//                 left: 20.w, top: 10.h, bottom: 10.h, right: 20.w),
//             decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 1,
//                     blurRadius: 1,
//                     offset: Offset(5, 0), // changes position of shadow
//                   ),
//                 ],
//                 color: Colors.white,
//                 borderRadius:
//                     BorderRadius.vertical(bottom: Radius.circular(5.h.w))),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 40.h,
//                   backgroundImage: NetworkImage(widget.Restaurant_ProfileImage),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Text(widget.Restaurant_Name,
//                     style: GoogleFonts.lato(
//                       textStyle: style,
//                     )),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Text("${widget.Restaurant_Cousine}",
//                     style: GoogleFonts.lato(
//                       textStyle: style7,
//                     )),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.pin_drop_outlined,
//                       size: 18.h.w,
//                       color: Colors.grey,
//                     ),
//                     SizedBox(
//                       width: 10.w,
//                     ),
//                     Text("${widget.Restaurant_Location}",
//                         style: GoogleFonts.lato(
//                           textStyle: style3,
//                         )),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5.h,
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       LineIcons.phone,
//                       size: 18.h.w,
//                       color: Colors.grey,
//                     ),
//                     SizedBox(
//                       width: 10.w,
//                     ),
//                     Text("${widget.Restaurant_PhoneNumber}",
//                         style: GoogleFonts.lato(
//                           textStyle: style3,
//                         )),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5.h,
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.email_outlined,
//                       size: 18.h.w,
//                       color: Colors.grey,
//                     ),
//                     SizedBox(
//                       width: 10.w,
//                     ),
//                     Text("${widget.Restaurant_Email}",
//                         style: GoogleFonts.lato(
//                           textStyle: style3,
//                         )),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 40.h,
//                 ),
//                 Align(
//                   child: Text("Delivery Hours",
//                       style: GoogleFonts.lato(
//                         textStyle: style5,
//                       )),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Align(
//                   child: Text("09:00 AM - 09:00 PM",
//                       style: GoogleFonts.lato(
//                         textStyle: style6,
//                       )),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 40.h,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               DefaultTabController(
//                   length: 2, // length of tabs
//                   initialIndex: 0,
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: <Widget>[
//                         TabBar(
//                           labelStyle: TextStyle(
//                               fontSize: 17.sp, fontWeight: FontWeight.w500),
//                           labelColor: Colors.grey[900],
//                           unselectedLabelColor: Colors.grey[700],
//                           tabs: const [
//                             Tab(text: 'Menu'),
//                             Tab(text: 'Ratings & Reviews'),
//                           ],
//                         ),
//                         Container(
//                             height: 400.h,
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                                 border: Border(
//                                     top: BorderSide(
//                                         color: Colors.grey, width: 0.5.w))),
//                             child: TabBarView(children: <Widget>[
//                               SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     FutureBuilder(
//                                       future: GetProducts(ID),
//                                       builder: (BuildContext context,
//                                           AsyncSnapshot snapshot) {
//                                         Widget widget = Text("");
//                                         if (snapshot.hasData) {
//                                           if (snapshot.hasData &&
//                                               snapshot.data.isEmpty) {
//                                             widget = Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 SizedBox(
//                                                   height: 50.h,
//                                                 ),
//                                                 Center(
//                                                   child: Lottie.asset(
//                                                       'Assets/LottieAnimations/No_Data_Found_Lottie.json',
//                                                       height: 220.h,
//                                                       width: 250.w),
//                                                 ),
//                                               ],
//                                             );
//                                           } else {
//                                             widget = Column(
//                                               children: [
//                                                 Center(
//                                                   child: Column(
//                                                       children: snapshot.data
//                                                           .map<Widget>((e) {
//                                                     int Product_ID =
//                                                         e.Product_ID;
//                                                     String Product_Name =
//                                                         "${e.Product_Name}";
//                                                     int Product_Price =
//                                                         e.Product_Price;
//                                                     int Restaurant =
//                                                         e.Restaurant;

//                                                     return GestureDetector(
//                                                       onTap: () {
//                                                         showDialog(
//                                                             context: context,
//                                                             builder: (BuildContext
//                                                                     context) =>
//                                                                 AlertDialog(
//                                                                   title: const Text(
//                                                                       'Add to Cart'),
//                                                                   content:
//                                                                       const Text(
//                                                                           'Do you want this Item to add in your Cart?'),
//                                                                   actions: [
//                                                                     TextButton(
//                                                                         onPressed:
//                                                                             () async {
//                                                                           setState(
//                                                                               () {});
//                                                                           postCart(
//                                                                               Product_Name,
//                                                                               Product_Price,
//                                                                               Restaurant_Name,
//                                                                               Restaurant_Location,
//                                                                               Restaurant_ID,
//                                                                               userID,
//                                                                               Restaurant_ProfileImage);
//                                                                           Navigator.pop(
//                                                                               context);
//                                                                         },
//                                                                         child: const Text(
//                                                                             'YES')),
//                                                                     TextButton(
//                                                                         onPressed:
//                                                                             () {
//                                                                           Navigator.pop(
//                                                                               context);
//                                                                         },
//                                                                         child: const Text(
//                                                                             'NO'))
//                                                                   ],
//                                                                 ));
//                                                       },
//                                                       child: Container(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(16.0),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           border: Border(
//                                                             bottom: BorderSide(
//                                                                 color: Colors
//                                                                     .black12,
//                                                                 width: 1.w),
//                                                           ),
//                                                         ),
//                                                         child: Column(
//                                                           children: [
//                                                             Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .spaceBetween,
//                                                                 children: [
//                                                                   Text(
//                                                                     "${Product_Name}",
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .grey[900]),
//                                                                   ),
//                                                                   Text(
//                                                                     "Rs. ${Product_Price}",
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .grey[700]),
//                                                                   ),
//                                                                 ]),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     );
//                                                   }).toList()),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 50.h,
//                                                 ),
//                                               ],
//                                             );
//                                           }
//                                         } else if (snapshot.hasError) {
//                                           widget = Center(
//                                             child: Text("Something went wrong"),
//                                           );
//                                         } else {
//                                           widget = const Center(
//                                             child: CircularProgressIndicator(),
//                                           );
//                                         }
//                                         return widget;
//                                       },
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                   child: SingleChildScrollView(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height: 20.h,
//                                     ),
//                                     SingleChildScrollView(
//                                       child: Column(
//                                         children: [
//                                           FutureBuilder(
//                                             future: GetReviews(Restaurant_ID),
//                                             builder: (BuildContext context,
//                                                 AsyncSnapshot snapshot) {
//                                               Widget widget = Text("");
//                                               if (snapshot.connectionState ==
//                                                   ConnectionState.waiting) {
//                                                 return const Center(
//                                                     child:
//                                                         CircularProgressIndicator());
//                                               } else if (snapshot.hasError) {
//                                                 return const Center(
//                                                   child: Text(
//                                                       "Something went wrong"),
//                                                 );
//                                               } else {
//                                                 if (snapshot.hasData) {
//                                                   if (snapshot.hasData &&
//                                                       snapshot.data.isEmpty) {
//                                                     widget = Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Center(
//                                                           child: Lottie.asset(
//                                                               'Assets/LottieAnimations/No_Data_Found_Lottie.json',
//                                                               height: 220.h,
//                                                               width: 250.w),
//                                                         ),
//                                                       ],
//                                                     );
//                                                   } else {
//                                                     widget = Column(
//                                                       children: [
//                                                         Center(
//                                                           child: Column(
//                                                               children: snapshot
//                                                                   .data
//                                                                   .map<Widget>(
//                                                                       (e) {
//                                                             int Review_ID =
//                                                                 e.Review_ID;
//                                                             String Review =
//                                                                 "${e.Review}";
//                                                             double Rating =
//                                                                 e.Rating;
//                                                             String
//                                                                 Customer_Name =
//                                                                 "${e.Customer_Name}";

//                                                             String
//                                                                 Restaurant_Name =
//                                                                 "${e.Restaurant_Name}";

//                                                             return Container(
//                                                               padding: EdgeInsets
//                                                                   .only(
//                                                                       left:
//                                                                           16.w,
//                                                                       right:
//                                                                           16.w,
//                                                                       bottom:
//                                                                           10.h,
//                                                                       top:
//                                                                           10.h),
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 border: Border(
//                                                                   bottom: BorderSide(
//                                                                       color: Colors
//                                                                           .black12,
//                                                                       width:
//                                                                           1.w),
//                                                                 ),
//                                                               ),
//                                                               child: Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Row(
//                                                                     children: [
//                                                                       CircleAvatar(
//                                                                         radius:
//                                                                             30.h,
//                                                                         backgroundImage:
//                                                                             AssetImage('Assets/images/Icon.png'),
//                                                                       ),
//                                                                       SizedBox(
//                                                                         width:
//                                                                             15.w,
//                                                                       ),
//                                                                       Column(
//                                                                         crossAxisAlignment:
//                                                                             CrossAxisAlignment.start,
//                                                                         children: [
//                                                                           SizedBox(
//                                                                             height:
//                                                                                 5.h,
//                                                                           ),
//                                                                           Text(
//                                                                             "${Customer_Name}",
//                                                                             style:
//                                                                                 GoogleFonts.lato(
//                                                                               textStyle: style5,
//                                                                             ),
//                                                                           ),
//                                                                           SizedBox(
//                                                                             height:
//                                                                                 5.h,
//                                                                           ),
//                                                                           RatingBar
//                                                                               .builder(
//                                                                             initialRating:
//                                                                                 Rating,
//                                                                             minRating:
//                                                                                 1,
//                                                                             direction:
//                                                                                 Axis.horizontal,
//                                                                             allowHalfRating:
//                                                                                 true,
//                                                                             itemCount:
//                                                                                 5,
//                                                                             itemPadding:
//                                                                                 EdgeInsets.symmetric(horizontal: 0.0.w),
//                                                                             itemBuilder: (context, _) =>
//                                                                                 Icon(
//                                                                               Icons.star,
//                                                                               color: Colors.amber,
//                                                                               size: 5.h,
//                                                                             ),
//                                                                             tapOnlyMode:
//                                                                                 true,
//                                                                             ignoreGestures:
//                                                                                 true,
//                                                                             onRatingUpdate:
//                                                                                 (rating) {
//                                                                               print(rating);
//                                                                             },
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                   SizedBox(
//                                                                     height:
//                                                                         10.h,
//                                                                   ),
//                                                                   Padding(
//                                                                     padding: EdgeInsets.only(
//                                                                         left: 10
//                                                                             .w,
//                                                                         right: 20
//                                                                             .w),
//                                                                     child: Text(
//                                                                       "${Review}",
//                                                                       style: GoogleFonts
//                                                                           .lato(
//                                                                         textStyle:
//                                                                             style8,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             );
//                                                           }).toList()),
//                                                         ),
//                                                       ],
//                                                     );
//                                                   }
//                                                 } else {
//                                                   widget = const Center(
//                                                       child: Text("NO DATA"));
//                                                 }
//                                               }

//                                               return widget;
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 20.h,
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.all(20.0.h.w),
//                                       child: ReviewButton,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               ),
//                             ]))
//                       ])),
//             ],
//           ),
//         ],
//       )),
//     );
//   }

//   @override
//   void dispose() {
//     ReviewTextController.dispose();
//     super.dispose();
//   }
// }
