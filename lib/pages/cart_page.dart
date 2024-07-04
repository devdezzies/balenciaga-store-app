import 'package:balenciaga/constants/color_scheme.dart';
import 'package:balenciaga/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeItemFromCart(Map<String, dynamic> itemRemoved) {
    // Provider.of<CartProvider>(context, listen: false)
    //     .removeProduct(itemRemoved);
    context.read<CartProvider>().removeProduct(itemRemoved);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${itemRemoved['title']} has been removed")));
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> product = context
        .watch<CartProvider>()
        .cartStorage; // shorter way to initialize from provider
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: product.length,
          itemBuilder: (context, idx) {
            return Dismissible(
              onDismissed: (direction) {
                _removeItemFromCart(product[idx]);
              },
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(width: 3, color: Colors.black),
                          borderRadius: BorderRadius.zero),
                      title: const Text("Confirm",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 30)),
                      content: const Text(
                          "Are you sure you wish to delete this item?",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 20)),
                      actions: <Widget>[
                        TextButton(
                            style: TextButton.styleFrom(
                                overlayColor:
                                    const Color.fromARGB(44, 244, 67, 54),
                                foregroundColor: Colors.red),
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("DELETE")),
                        TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: ColorTone.greenTone,
                              overlayColor:
                                  const Color.fromARGB(44, 182, 234, 24)),
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("CANCEL"),
                        ),
                      ],
                    );
                  },
                );
              },
              key: Key(product[idx]['id'].toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                padding: const EdgeInsets.only(right: 30),
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete),
              ),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.zero),
                title: Text(product[idx]['title'] as String,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 25)),
                subtitle: Text(
                  "size: ${product[idx]['size'].toString()}",
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
                leading: SizedBox(
                    width: 100,
                    child: Image(
                      image: AssetImage(product[idx]['imageUrl'] as String),
                      fit: BoxFit.cover,
                    )),
              ),
            );
          },
        ));
  }
}
