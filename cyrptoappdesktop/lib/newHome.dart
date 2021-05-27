import 'dart:math';
import 'package:cyrptoappmobil/sizes_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'model/model.dart';

class ItemsController extends GetxController{
  var counter = 0.obs;
  var itemsResult = [].obs;

  final url = Uri.parse("https://api.coinlore.net/api/tickers/");
  Future callitems() async{
    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        var result = itemsFromJson(response.body);
        counter.value = result.data.length;


        for(var i=0;i<result.data.length;i++){
          itemsResult.add(result.data[i]);
        }

        return result;
      }else{
        print(response.statusCode);
      }
    } catch(e){
      print(e.toString());
    }
  }
  @override
  void onInit() {
    callitems();
    super.onInit();
  }
}


class newHomePage extends StatelessWidget{
  ItemsController itemsCtrl = Get.put(ItemsController());

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("COINS"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: (){
            itemsCtrl.callitems();
          },
        ),
        body: Center(
          child: GridView.count(
            crossAxisSpacing: 50,
            mainAxisSpacing: 50,
            crossAxisCount: 2,
            children: [
              Obx(()=>ListView.builder(
                  itemCount: itemsCtrl.counter.value,
                  itemBuilder:(context,index){
                    if( index%2 == 0) {
                      return Container(
                        child:Center(
                          child:Column(
                            children: [
                              Text("${itemsCtrl.itemsResult[index]
                                  .symbol}",style: TextStyle(color:Colors.white,fontSize: 40),) ,
                              Text("Fiyat: ${itemsCtrl.itemsResult[index]
                                  .priceUsd}",style: TextStyle(color:Colors.white,fontSize: 40),) ,

                              Text("24 Saatlik Değişim: ${itemsCtrl.itemsResult[index]
                                  .percent_change_24h}",style: TextStyle(color:Colors.white,fontSize: 40),) ,
                            ],
                          )
                        ) ,
                        decoration: BoxDecoration(
                          color: Colors.primaries[Random().nextInt(Colors
                              .primaries.length)],

                        ),
                        height: displayHeight(context)*(1/3),
                        width: displayWidth(context) * 0.5,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(15),
                      );
                    }else{
                      return SizedBox(height: 0.1,);
                    }
                  }
              ),

              ),

              Obx(()=>ListView.builder(
                  itemCount: itemsCtrl.counter.value,
                  itemBuilder:(context,index){
                    if( index%2 != 0) {
                      return Container(
                        child:Center(
                            child:Column(
                              children: [
                                Text("${itemsCtrl.itemsResult[index]
                                    .symbol}",style: TextStyle(color:Colors.white,fontSize: 40),) ,

                                Text("Fiyat: ${itemsCtrl.itemsResult[index]
                                    .priceUsd}",style: TextStyle(color:Colors.white,fontSize: 40),) ,

                                Text("24 Saatlik Değişim: ${itemsCtrl.itemsResult[index]
                                    .percent_change_24h}",style: TextStyle(color:Colors.white,fontSize: 40),) ,
                              ],
                            )
                        ) ,
                        decoration: BoxDecoration(
                          color: Colors.primaries[Random().nextInt(Colors
                              .primaries.length)],

                        ),
                        height: displayHeight(context)*(1/3),
                        width: displayWidth(context) * 0.5,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(15),
                      );
                    }else{
                          return SizedBox(height: 0.1,);
                        }
                  }
              ),

              ),
            ],

          ),
        ),
      );
  }

}