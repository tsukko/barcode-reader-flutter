import 'package:flutter/material.dart';
import 'package:qr_code/models/product.dart';

class DebugCondition extends StatefulWidget {
  final Product product = Product(
      brand: "Levis",
      description: "Print T-shirt",
      image:
          "https://mosaic02.ztat.net/vgs/media/pdp-zoom/LE/22/1D/02/2A/12/LE221D022-A12@16.1.jpg",
      name: "THE PERFECT",
      price: "£19.99",
      rating: 4.0,
      colors: [
        ProductColor(
          color: Colors.green,
          colorName: "一般名及び販売名",
        ),
        ProductColor(
          color: Colors.green,
          colorName: "一般名のみ",
        ),
        ProductColor(
          color: Colors.green,
          colorName: "販売名のみ",
        ),
      ],
      quantity: 0,
      sizes: ["S", "M", "L", "XL"],
      totalReviews: 170);

  @override
  _ShoppingActionState createState() {
    return _ShoppingActionState();
  }
}

class _ShoppingActionState extends State<DebugCondition> {
  String _value = "一般名のみ";

  Widget colorsCard() => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
//          SizedBox(
//            height: 26.0,
//          ),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            children: widget.product.colors
                .map(
                  (pc) => Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ChoiceChip(
                      selectedColor: pc.color,
                      label: Text(
                        pc.colorName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      selected: _value == pc.colorName,
                      onSelected: (selected) {
                        setState(
                          () {
                            _value = selected ? pc.colorName : null;
                          },
                        );
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return colorsCard();
  }
}
