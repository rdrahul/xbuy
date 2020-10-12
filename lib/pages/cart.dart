import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xbuy/pages/grofers.dart';
import 'package:xbuy/repository/product.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/extra.dart' as android_extra;
import 'package:intent/typedExtra.dart' as android_typedExtra;
import 'package:intent/action.dart' as android_action;

class CartScreen extends StatefulWidget {
  List<String> items = [];

  CartScreen({Key key, this.items}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState(items);
}

class _CartScreenState extends State<CartScreen> {
  List<String> items = [];
  List<dynamic> products = [];
  Future<dynamic> listOfResults;
  _CartScreenState(this.items);
  int total = 0;

  @override
  void initState() {
    total = 0;
    super.initState();
    var futures = <Future>[];
    for (var item = 0; item < items.length; item++) {
      futures.add(getProduct(items[item]));
    }
    listOfResults = Future.wait(futures);
    listOfResults.then((value) {
      for (var i = 0; i < value.length; i++) {
        print(value[i]);
        total += value[i]['price'];
      }
      setState(() {
        total = total;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(30, 60, 30, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[header(), futureBuilderforItems(), checkout()],
            )));
  }

  getItems() {
    return this.items;
  }

  textStyleCustom() {
    return TextStyle(
        fontFamily: "Poppins",
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: Colors.black87);
  }

  header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "My Cart ",
          style: textStyleCustom(),
        ),
        Text(
          "${items.length} Items ",
          style: textStyleCustom(),
        )
      ],
    );
  }

  futureBuilderforItems() {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        height: 700,
        padding: EdgeInsets.all(2),
        child: FutureBuilder<dynamic>(
          future: listOfResults,
          builder: displayCartItems,
        ));
  }

  Widget displayCartItems(context, AsyncSnapshot snapshot) {
    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
      if (snapshot.data.length == 0) {
        return Container(
          width: 300,
        );
      }
      List<dynamic> products = snapshot.data;

      print(products);
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          total += products[index]['price'];

          print(" INDEX ");
          print(products[index]);
          var item = products[index];
          return cartItem(item);
        },
      );
    } else if (snapshot.hasError) {
      return Container();
    }

    return Center(
      heightFactor: 1,
      widthFactor: 1,
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
        ),
      ),
    );
  }

  Widget cartItemBuilder() {
    List<Widget> cartCards = [];
    for (var i = 0; i < products.length; i++) {
      cartCards.add(cartItem(products[i]));
    }
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        height: 700,
        child: SingleChildScrollView(
          child: Column(
            children: cartCards,
          ),
        ));
  }

  Widget checkout() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          " ₹ " + total.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            fontFamily: "Poppins",
            color: Colors.blueGrey,
          ),
        ),
        RaisedButton(
          color: Colors.deepOrange,
          child: Text(
            "Buy Now",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red)),
          onPressed: () {
            android_intent.Intent()
              ..setAction(android_action.Action.ACTION_VIEW)
              ..setData(Uri(scheme: "grofers", host: "cart"))
              ..startActivity().catchError((e) => print(e));
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => GroferWebview()),
            // );
          },
        )
      ],
    ));
  }

  Widget cartItem(dynamic product) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
      width: double.infinity,
      // height: 100,
      decoration: BoxDecoration(
          border: Border.all(width: 2),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 8,
                spreadRadius: -4,
                color: Colors.black12,
                offset: Offset(0, 1))
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          product["image_url"] != null
              ? Image.network(product["image_url"],
                  width: 80, height: 80, fit: BoxFit.contain)
              : Container(),
          // Image.asset(image, width: 100, height: 100, fit: BoxFit.contain),
          Container(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Flexible(
                      child: Text(
                        product["brand_type"],
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff0f2e81),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Row(children: [
                      Text("₹ " + product["mrp"].toString() + "  ",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough)),
                      Text(
                        " ₹ " + product["price"].toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff0f2e81),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700),
                      )
                    ])),
              ],
            ),
          )

          // Text("headache ajks skjfs ajdasd fsfsafdsf sd the creafas.")
        ],
      ),
    );
  }
}
