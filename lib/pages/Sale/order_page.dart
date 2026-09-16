import 'package:flutter/material.dart';
import 'package:online_pos/Repository/api_repo.dart';

class OrderPage extends StatefulWidget {
  OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Map<String, dynamic>> listOrder = [];
  double totalPrice = 0.0;

  void getHoldProduct() async {
    totalPrice = 0;
    ApiRepo.getHoldProduct()
        .then((value) {
          setState(() {
            listOrder = value;
            for(var item in listOrder){
              print("item = ${item}");
             totalPrice += item['price'] * item["order_qt"];
            }
          });
        })
        .catchError((error) {
          print("Error fetching hold products: $error");
        });
  }

  void updateQty({required int holdID, required String status}) async {
    Map<String, dynamic> body = {"hold_id": holdID, "status": status};
    await ApiRepo.updateQty(body: body).then((value) {
      if (value) {
        getHoldProduct();
      }
    });
  }

  @override
  void initState() {
    getHoldProduct(); // Fetch hold products when the page initializes
    // updateQty();
    // TODO: implement initState
    super.initState();
  }

  @override
  // void inistate
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF667eea),
        title: Text(
          'Order Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: listOrder.isEmpty
          ? Center(
              child: Text(
                "No Item in the cart",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: listOrder.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8ECF8),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const Icon(
                                Icons.fastfood_rounded,
                                color: Color(0xFF5B67CA),
                                size: 26,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listOrder[index]['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E2D),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    listOrder[index]['price'].toString() +
                                        listOrder[index]['currency'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () async {
                                    updateQty(
                                      holdID: listOrder[index]["id"],
                                      status: "-"
                                    );
                                  },
                                ),
                                Text('${listOrder[index]['order_qt'] ?? 1}'),

                               IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () async {
                                    updateQty(
                                      holdID: listOrder[index]["id"],
                                      status: "+"
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

      // 2. YOUR CHECKOUT BUTTON GOES IN bottomNavigationBar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E2D),
                    ),
                  ),
                  Text(
                   totalPrice.toString() +  '\$',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E2D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    // ApiRepo.confirmSale(body: body)
                    for(var item in listOrder){
                      ApiRepo.confirmSale(body: {
                        "hold_id":item['id'],
                        "name":item['name'],
                        "price":item["price"],
                        "currency":item["currency"],
                        "order_qt":item["order_qt"]
                      });
                      print("item ${item}");
                    }

                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B67CA),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                  child: const Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
