import 'package:flutter/material.dart';
import 'package:online_pos/Repository/api_repo.dart';
import 'package:online_pos/pages/Sale/order_page.dart';

class SalePage extends StatefulWidget {
  SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  int selectedCategoryIndex = 0;

  Future<bool> addToHold({required Map<String, dynamic> body}) async {
    bool isSuccess = await ApiRepo.holdInsert(body: body);
    return isSuccess;
  }

  void getAllProduct({required int categoryId}) async {
    ApiRepo.getProduct(categoryId: categoryId).then((value) {
      allProducts = value;
      setState(() {});
    });
  }

  // category
  void getCategory() async {
    ApiRepo.getCategory().then((value) {
      allCategory = value;
      setState(() {});
    });
  }

  // Sample products
  List<Map<String, dynamic>> allProducts = [];
  // sample category
  List<Map<String, dynamic>> allCategory = [];

  @override
  void initState() {
    super.initState();
    getCategory();
    getAllProduct(categoryId: 1);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF667eea),
        title: Text(
          'Products',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  // Handle cart tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OrderPage();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories Section
          Container(
            color: Color(0xFF667eea).withOpacity(0.08),
            padding: EdgeInsets.symmetric(vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  allCategory.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        for (var item in allCategory) {
                          item['is_selected'] = 0;
                        }
                        allCategory[index]['is_selected'] = 1;
                        int categoryId = allCategory[index]['id'];
                        getAllProduct(categoryId: categoryId);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: allCategory[index]['is_selected'] == 1
                              ? Color(0xFF667eea)
                              : Colors.white,

                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFF667eea).withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          allCategory[index]['name'] ?? '',
                          style: TextStyle(
                            color: allCategory[index]['is_selected'] == 1
                                ? Colors.white
                                : Color(0xFF667eea),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Products List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                final product = allProducts[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to product details if needed
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Product Image Container
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              // product['image'],
                              Icons.headphones, // Placeholder icon for now
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          // Product Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Product Name
                                Text(
                                  product['name'] ?? 'Product Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                // Category Badge
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF667eea).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    product['category_name'].toString() ?? '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF667eea),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                // Price
                                Text(
                                  '${product['currency'] ?? '\$'}'
                                  '${(double.tryParse(product['price']?.toString() ?? '0') ?? 0.0).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF667eea),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          // Quantity Controls
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print("- qty");
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Text(
                                product['quantity'].toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  // print("Insert to hold --> ${product}");
                                  bool status = await addToHold(
                                    body: {
                                      "name": product["name"],
                                      "price": product["price"],
                                      "currency": product["currency"],
                                    },
                                  );
                                  if (status) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          "Product added to hold successfully",
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          "Failed to add product to hold!",
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF667eea),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
