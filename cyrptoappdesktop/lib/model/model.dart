// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
  Items({
    required this.data,
    required this.info,
  });

  List<Datum> data;
  Info info;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        info: Info.fromJson(json["info"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "info": info.toJson(),
      };
}

class Datum {
  Datum({
    required this.symbol,
    required this.name,
    required this.priceUsd,
    required this.percent_change_24h,
  });

  String symbol;
  String name;
  String priceUsd;
  String percent_change_24h;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        symbol: json["symbol"],
        name: json["name"],
        priceUsd: json["price_usd"],
        percent_change_24h: json["percent_change_24h"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "price_usd": priceUsd,
        "percent_change_24h": percent_change_24h,
      };
}

class Info {
  Info({
    required this.coinsNum,
    required this.time,
  });

  int coinsNum;
  int time;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        coinsNum: json["coins_num"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "coins_num": coinsNum,
        "time": time,
      };
}
