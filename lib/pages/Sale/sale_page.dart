import 'package:flutter/material.dart';

class SalePage extends StatefulWidget {
  SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  int selectedCategoryIndex = 0;

  // Sample categories
  final List<String> categories = [
    'All',
    'Electronics',
    'Clothing',
    'Food',
    'Books',
    'Home',
    'Sports',
  ];

  // Sample products
  final List<Map<String, dynamic>> allProducts = [
    {
      'id': 1,
      'name': 'Wireless Headphones',
      'price': 49.99,
      'category': 'Electronics',
      'quantity': 0,
      'image': Icons.headphones,
    },
    {
      'id': 2,
      'name': 'Smart Watch',
      'price': 199.99,
      'category': 'Electronics',
      'quantity': 0,
      'image': Icons.watch,
    },
    {
      'id': 3,
      'name': 'T-Shirt',
      'price': 19.99,
      'category': 'Clothing',
      'quantity': 0,
      'image': Icons.shopping_bag,
    },
    {
      'id': 4,
      'name': 'Jeans',
      'price': 59.99,
      'category': 'Clothing',
      'quantity': 0,
      'image': Icons.shopping_bag,
    },
    {
      'id': 5,
      'name': 'Coffee Maker',
      'price': 89.99,
      'category': 'Home',
      'quantity': 0,
      'image': Icons.kitchen,
    },
    {
      'id': 6,
      'name': 'Yoga Mat',
      'price': 29.99,
      'category': 'Sports',
      'quantity': 0,
      'image': Icons.fitness_center,
    },
    {
      'id': 7,
      'name': 'Python Book',
      'price': 39.99,
      'category': 'Books',
      'quantity': 0,
      'image': Icons.book,
    },
    {
      'id': 8,
      'name': 'Rice',
      'price': 12.99,
      'category': 'Food',
      'quantity': 0,
      'image': Icons.restaurant,
    },
  ];

  late List<Map<String, dynamic>> products;

  @override
  void initState() {
    super.initState();
    products = List.from(allProducts);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.shopping_cart, color: Colors.white, size: 28),
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
                  categories.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: selectedCategoryIndex == index
                            ? Color(0xFF667eea)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: selectedCategoryIndex == index
                            ? null
                            : Border.all(
                                color: Color(0xFF667eea).withOpacity(0.3),
                              ),
                        boxShadow: selectedCategoryIndex == index
                            ? [
                                BoxShadow(
                                  color: Color(0xFF667eea).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedCategoryIndex == index
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
          // Products List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
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
                                colors: [
                                  Color(0xFF667eea),
                                  Color(0xFF764ba2),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              product['image'],
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
                                  product['name'],
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
                                    product['category'],
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
                                  '\$${product['price'].toStringAsFixed(2)}',
                                  style: TextStyle(
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
                                onTap: () {
                                  print("+ qty");
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
