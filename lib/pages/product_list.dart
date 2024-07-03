import 'package:balenciaga/constants/color_scheme.dart';
import 'package:balenciaga/data/products.dart';
import 'package:balenciaga/pages/product_details.dart';
import 'package:flutter/material.dart';
import '../components/home_carousel.dart';
import '../components/product_card.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  bool isPressed = false;
  int? selectedIdx = 0;
  late ScrollController _scrollController;
  late Color _appBarColor;
  late bool _textColor;

  @override
  void initState() {
    super.initState();
    _appBarColor = Colors.white;
    _textColor = true;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        setState(() {
          _appBarColor =
              _scrollController.offset > 90 ? Colors.black : Colors.white;
          _textColor = !(_scrollController.offset > 90);
        });
      }
    });
  }

  List<String> filter = [
    "All",
    "Coats & Jackets",
    "T-Shirts",
    "Knitwear",
    "Pants",
    "Sweatshirts & Hoodies",
    "Top & Shirts"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            toolbarHeight: 80,
            floating: true,
            flexibleSpace: Container(
              color: _appBarColor,
            ),
            title: _textColor
                ? const Text(
                    "BALENCIAGA",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  )
                : const Text(
                    "BALENCIAGA",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
            actions: [
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                        overlayColor:
                            WidgetStatePropertyAll(Color.fromARGB(69, 0, 0, 0)),
                        foregroundColor: WidgetStatePropertyAll(Colors.black)),
                    child: _textColor
                        ? const Icon(
                            Icons.search_sharp,
                            size: 30,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.search_sharp,
                            size: 30,
                            color: Colors.white,
                          ),
                  ))
            ],
          ),
          SliverList.list(
            children: <Widget>[
              const HomeCarousel(),
              Container(
                width: double.infinity,
                height: 80,
                alignment: Alignment.center,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: List.generate(
                            filter.length,
                            (idx) => Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: InputChip(
                                  selectedColor: ColorTone.blackTone,
                                  selected: selectedIdx == idx,
                                  checkmarkColor: Colors.white,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      if (selectedIdx == idx) {
                                        selectedIdx = 0;
                                      } else {
                                        selectedIdx = idx;
                                      }
                                    });
                                  },
                                  label: selectedIdx == idx
                                      ? Text(
                                          filter[idx],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.white),
                                        )
                                      : Text(
                                          filter[idx],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(width: 3)),
                                ))),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: selectedIdx == 0
                ? products.length
                : products
                    .where((e) => e['category'] == selectedIdx)
                    .toList()
                    .length,
            itemBuilder: (context, idx) {
              final product = selectedIdx == 0
                  ? products
                  : products
                      .where((e) => e['category'] == selectedIdx)
                      .toList();
              return GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProductDetails(product: product[idx]);
                })),
                child: ProductCard(
                  imageURL: product[idx]['imageUrl'] as String,
                  title: product[idx]['title'] as String,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}