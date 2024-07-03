import 'package:flutter/material.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Image.network('https://images.unsplash.com/photo-1677680127713-f23a55c96955?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', fit: BoxFit.cover,),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Image.network('https://balenciaga.dam.kering.com/m/6e6c09ddb1b44574/Large-HP_DK_INSTITUTIONAL_BAG_CAMPAIGN_HOURGLASS_01_2600x1300_2x1.jpg', fit:BoxFit.cover,),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Image.network('https://couture.balenciaga.com/static/5aa4dcca8d49fa0a739b74de6d9e341a/c2094/HP_DK_COUTURE_LOOKS_2600x1300_2x1.webp', fit: BoxFit.cover,),
          ),
        ],
      ),
    );
  }
}
