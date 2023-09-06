import 'package:flutter/material.dart';
import 'package:responsive_property/responsive_property.dart';

class MediaQueryEx extends StatefulWidget {

  @override
  State<MediaQueryEx> createState() => _MediaQueryState();
}

class _MediaQueryState extends State<MediaQueryEx> {
  var media;
  @override
  Widget build(BuildContext context) {

    media = MediaQuery.of(context).size;

   return Scaffold(
     body: GridView.count(
       crossAxisSpacing: 10,
       mainAxisSpacing: 10,
       crossAxisCount: Responsive({
         mobileScreenScope: 2,
         tabletScreenScope: 4,
         desktopScreenScope: 6
       }).resolve(context)!,
       children: List.generate(
           30,
               (index) =>
               Container(color: Colors.green, child: Text("SOME TEXT"))),
     ),
   );

  }

}
