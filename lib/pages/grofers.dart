import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GroferWebview extends StatefulWidget {
  @override
  _GroferWebviewState createState() => _GroferWebviewState();
}

class _GroferWebviewState extends State<GroferWebview> {
  InAppWebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InAppWebView Example'),
      ),
      body: Container(
          child: Column(children: <Widget>[
        Expanded(
            child: InAppWebView(
          initialUrl: "grofers://referral/?referral_amount=4000",
          initialHeaders: {},
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              debuggingEnabled: true,
            ),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url) {},
          onLoadStop: (InAppWebViewController controller, String url) async {
            var str = {
              "count": 2,
              "total": 77,
              "chargeableDeliveryCost": 49,
              "amtRequiredForFreeDelivery": 723,
              "items": {
                "28762": {
                  "id": 28762,
                  "deliveryCharge": {
                    "title": null,
                    "freeDeliveryValue": null,
                    "charge": 49
                  },
                  "count": 2,
                  "subTotal": 77,
                  "minOrder": 800,
                  "chargeableDeliveryCost": 49,
                  "outOfStockProducts": {},
                  "totalMRP": 112,
                  "totalSavings": 35,
                  "amtRequiredForFreeDelivery": 723,
                  "products": {
                    "24001772": {
                      "updateTs": 1602487245085,
                      "count": 1,
                      "subTotal": 25,
                      "details": {
                        "imgSrc":
                            "https://cdn.grofers.com/app/images/products/normal/pro_389727.jpg?ts=1599210622",
                        "inventory": 10,
                        "mappingId": "24001772",
                        "sbcEnabled": true,
                        "id": 389727,
                        "name": "Grofers Mother's Choice Maida",
                        "newPrice": 25,
                        "oldPrice": 42,
                        "sbcPrice": 24,
                        "sbcOffer": "42% OFF",
                        "offer": "40% OFF",
                        "unit": "500g",
                        "typeId": 7199,
                        "isGroupBuyingProduct": false,
                        "grofersPoints": 0,
                        "raw": {
                          "rating": 4,
                          "message_length": 0,
                          "subscription_price": null,
                          "type_id": 7199,
                          "sbc_offer": "42% OFF",
                          "is_subscribable": null,
                          "mapping_id": "24001772",
                          "partnership_offers": null,
                          "sbc_price": 24,
                          "unit": "500g",
                          "grofers_points": 0,
                          "level1_category": [
                            {
                              "parent_id": 16,
                              "id": 916,
                              "name": "Atta & Other Flours"
                            }
                          ],
                          "monthly_cost": null,
                          "inventory": 10,
                          "line_1": "Grofers Mother's Choice Maida",
                          "line_2": "",
                          "type": "Maida",
                          "price": 25,
                          "offer": "40% OFF",
                          "brand": "Grofers Mother's Choice",
                          "incentives": [
                            {
                              "incentive_value": 2,
                              "incentive_type": "winwin_points"
                            }
                          ],
                          "level0_category": [
                            {
                              "parent_id": 16,
                              "id": 16,
                              "name": "Grocery & Staples"
                            }
                          ],
                          "rating_star_color": "#459220",
                          "pl_flag": true,
                          "product_id": 389727,
                          "sbc_enabled": true,
                          "name": "Grofers Mother's Choice Maida",
                          "rating_flag": false,
                          "mrp": 42,
                          "expected_renewal_date": null,
                          "leaf_category": {
                            "parent_id": 916,
                            "id": 48,
                            "name": "Other Flours",
                            "level": "l2"
                          },
                          "image_url":
                              "https://cdn.grofers.com/app/images/products/normal/pro_389727.jpg?ts=1599210622",
                          "lightning_enabled": false,
                          "action":
                              "grofers://product?expr=%7B%22and%22:%5B%22p389727%22,%22ch497%22%5D%7D&restricted=true",
                          "pl_badge": null
                        }
                      }
                    },
                    "24001779": {
                      "updateTs": 1602487244305,
                      "count": 1,
                      "subTotal": 52,
                      "details": {
                        "imgSrc":
                            "https://cdn.grofers.com/app/images/products/normal/pro_389729.jpg?ts=1599206934",
                        "inventory": 10,
                        "mappingId": "24001779",
                        "sbcEnabled": true,
                        "id": 389729,
                        "name": "Grofers Mother's Choice Besan",
                        "newPrice": 52,
                        "oldPrice": 70,
                        "sbcPrice": 50,
                        "sbcOffer": "28% OFF",
                        "offer": "25% OFF",
                        "unit": "500 g",
                        "typeId": 1365,
                        "isGroupBuyingProduct": false,
                        "grofersPoints": 0,
                        "raw": {
                          "rating": 4.1,
                          "message_length": 0,
                          "subscription_price": null,
                          "type_id": 1365,
                          "sbc_offer": "28% OFF",
                          "is_subscribable": null,
                          "mapping_id": "24001779",
                          "partnership_offers": null,
                          "sbc_price": 50,
                          "unit": "500 g",
                          "grofers_points": 0,
                          "level1_category": [
                            {
                              "parent_id": 16,
                              "id": 916,
                              "name": "Atta & Other Flours"
                            }
                          ],
                          "monthly_cost": null,
                          "inventory": 10,
                          "line_1": "Grofers Mother's Choice Besan",
                          "line_2": "",
                          "type": "Besan",
                          "price": 52,
                          "offer": "25% OFF",
                          "brand": "Grofers Mother's Choice",
                          "incentives": [
                            {
                              "incentive_value": 5,
                              "incentive_type": "winwin_points"
                            }
                          ],
                          "level0_category": [
                            {
                              "parent_id": 16,
                              "id": 16,
                              "name": "Grocery & Staples"
                            }
                          ],
                          "rating_star_color": "#459220",
                          "pl_flag": true,
                          "product_id": 389729,
                          "sbc_enabled": true,
                          "name": "Grofers Mother's Choice Besan",
                          "rating_flag": false,
                          "mrp": 70,
                          "expected_renewal_date": null,
                          "leaf_category": {
                            "parent_id": 916,
                            "id": 1166,
                            "name": "Besan & Sooji/Rava",
                            "level": "l2"
                          },
                          "image_url":
                              "https://cdn.grofers.com/app/images/products/normal/pro_389729.jpg?ts=1599206934",
                          "lightning_enabled": false,
                          "action":
                              "grofers://product?expr=%7B%22and%22:%5B%22p389729%22,%22ch497%22%5D%7D&restricted=true",
                          "pl_badge": null
                        }
                      }
                    }
                  }
                }
              },
              "promoInfo": [],
              "paymentMode": null,
              "uniqueSkuInCart": 2
            };
            // var d = jsonEncode(str);
            print(str.toString());
            await controller.evaluateJavascript(
                source: "window.localStorage.setItem('cart', '" +
                    '{count : 2}' +
                    "' )");
            await controller.evaluateJavascript(
                source: "alert(window.localStorage.getItem('cart'))");
          },
        ))
      ])),
    );
  }
}
