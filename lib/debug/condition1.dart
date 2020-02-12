import 'package:flutter/material.dart';
import 'package:qr_code/models/product.dart';
import 'package:qr_code/widget/common_divider.dart';

class DebugCondition extends StatefulWidget {
  // どっかから持ってきたやつで、不要なのもそのまま
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
          color: Colors.blue,
          colorName: "一般名及び販売名",
        ),
        ProductColor(
          color: Colors.blue,
          colorName: "一般名のみ",
        ),
        ProductColor(
          color: Colors.blue,
          colorName: "販売名のみ",
        ),
      ],
      quantity: 0,
      sizes: ["部分一致", "前方一致"],
      totalReviews: 170);

  @override
  _ShoppingActionState createState() {
    return _ShoppingActionState();
  }
}

class _ShoppingActionState extends State<DebugCondition> {
  String _value = "一般名のみ";
  String _sizeValue = "部分一致";

  Widget colorsCard() => Column(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.start,
            children: widget.product.colors
                .map(
                  (pc) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      selectedColor: Colors.blue, //pc.color,
                      label: Text(
                        pc.colorName,
                        style: TextStyle(fontSize: 16, color: Colors.black),
//                        style: TextStyle(fontWeight: FontWeight.bold),
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

  Widget sizesCard() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: widget.product.sizes
                .map((pc) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                          selectedColor: Colors.blue,
                          label: Text(
                            pc,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          selected: _sizeValue == pc,
                          onSelected: (selected) {
                            setState(() {
                              _sizeValue = selected ? pc : null;
                            });
                          }),
                    ))
                .toList(),
          ),
        ],
      );

//  Widget quantityCard() {
//    CartBloc cartBloc = CartBloc(widget.product);
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Text(
//          "Sizes",
//          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
//        ),
//        SizedBox(
//          height: 10.0,
//        ),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            CustomFloat(
//              isMini: true,
//              icon: FontAwesomeIcons.minus,
//              qrCallback: () => cartBloc.subtractionController.add(true),
//            ),
//            StreamBuilder<int>(
//              stream: cartBloc.getCount,
//              initialData: 0,
//              builder: (context, snapshot) => Text(
//                snapshot.data.toString(),
//                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
//              ),
//            ),
//            CustomFloat(
//              isMini: true,
//              icon: FontAwesomeIcons.plus,
//              qrCallback: () => cartBloc.additionalController.add(true),
//            ),
//          ],
//        )
//      ],
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonDivider(),
        colorsCard(),
        CommonDivider(),
        SizedBox(
          height: 5.0,
        ),
        sizesCard(),
        CommonDivider(),
        SizedBox(
          height: 5.0,
        ),
//        quantityCard(),
//        SizedBox(
//          height: 20.0,
//        ),
      ],
    );
  }
}
