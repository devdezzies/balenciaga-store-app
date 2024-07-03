import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key, required this.imageURL, required this.title,
  });

  final String imageURL;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white,),
      width: MediaQuery.of(context).size.width/2,
      height: 300,
      child: Column(children: [
        Expanded(
          flex: 5,
          child: Image(
            image: AssetImage(imageURL),
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),
          ),
        )
      ]),
    );
  }
}
