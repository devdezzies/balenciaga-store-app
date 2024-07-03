import 'package:balenciaga/constants/color_scheme.dart';
import 'package:balenciaga/pages/home_screen.dart';
import 'package:balenciaga/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int? selectedSize;

  void _onTap() {
    if (selectedSize != null) {
      Provider.of<CartProvider>(context, listen: false).addProductToCart(
        {
          "id": widget.product['id'],
          "title": widget.product['title'],
          "price": widget.product['price'],
          "size": widget.product['sizes'][selectedSize],
          "category": widget.product['category'],
          "imageUrl": widget.product['imageUrl'],
          "description": widget.product['description']
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The product has been added to your cart"))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add the size first!"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Product Details",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: TextButton(
              onPressed: () => Navigator.of(context).pop(
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
              style: const ButtonStyle(
                  overlayColor:
                      WidgetStatePropertyAll(Color.fromARGB(32, 0, 0, 0)),
                  shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                  foregroundColor: WidgetStatePropertyAll(Colors.black)),
              child: const Icon(Icons.arrow_back_sharp, size: 25)),
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: TextButton(
                onPressed: () {},
                style: const ButtonStyle(
                    overlayColor:
                        WidgetStatePropertyAll(Color.fromARGB(32, 0, 0, 0)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                    foregroundColor: WidgetStatePropertyAll(Colors.black)),
                child: const Icon(Icons.location_on_rounded, size: 25)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Image(
              image: AssetImage(widget.product['imageUrl']),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: ColorTone.greenTone),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.product['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.product['description'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 15),
                    ))
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(color: Colors.black),
            child: Text(
              "\$${widget.product['price']}",
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: List.generate(
                        widget.product['sizes'].length,
                        (idx) => Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: InputChip(
                              onSelected: (isSelected) {
                                setState(() {
                                  if (selectedSize == idx) {
                                    selectedSize = null;
                                  } else {
                                    selectedSize = idx;
                                  }
                                });
                              },
                              label: selectedSize == idx
                                  ? Text(
                                      widget.product['sizes'][idx].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.white),
                                    )
                                  : Text(
                                      widget.product['sizes'][idx].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                              selected: selectedSize == idx,
                              selectedColor: Colors.black,
                              showCheckmark: true,
                              checkmarkColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(width: 3)),
                            ))),
                  ),
                ),
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: ColorTone.greenTone,
                  side: const BorderSide(width: 3),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
              onPressed: _onTap,
              child: const Text(
                "ADD TO CART",
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
