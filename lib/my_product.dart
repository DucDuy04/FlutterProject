import 'package:flutter/material.dart';
import 'package:flutter_nhom6/api.dart';
import 'package:flutter_nhom6/model/product.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  @override
  void initState() {
    super.initState();
    test_api.getAllProduct();
  }

  String _selectCat = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách sản phẩm"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 17, 113, 192),
      ),
      body: FutureBuilder<List<Product>>(
        future: test_api.getAllProduct(),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text('Lỗi: ${snap.error}'));
          }

          if (snap.hasData) {
            return myListView(snap.data!);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget myListView(List<Product> lsProduct) {
    var filteredList = _selectCat == "All"
        ? lsProduct
        : lsProduct.where((p) {
            String productCat = p.category
                .toLowerCase()
                .replaceAll(' ', '_')
                .replaceAll("'", "_");
            String selectedCat = _selectCat.toLowerCase();
            return productCat == selectedCat;
          }).toList();
    //Lọc ra các sản phẩm theo cat đã chọn

    return Column(
      children: [
        // Filter chips
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            children:
                [
                  'All',
                  'ELECTRONICS',
                  'JEWELERY',
                  'MEN_S_CLOTHING',
                  'WOMEN_S_CLOTHING',
                ].map((cat) {
                  String displayName = cat == 'All' ? cat : cat;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Text(displayName, style: TextStyle(fontSize: 12)),
                      selected: _selectCat.toLowerCase() == cat.toLowerCase(),
                      selectedColor: Colors.blue[100],
                      onSelected: (isSelected) {
                        setState(() {
                          _selectCat = isSelected ? cat : "All";
                        });
                      },
                    ),
                  );
                }).toList(),
          ),
        ),

        // Product count
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${filteredList.length} sản phẩm',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
        ),

        // Product list
        Expanded(
          child: ListView(
            children: filteredList.map((p) => myItem(p)).toList(),
          ),
        ),
      ],
    );
  }

  Widget myItem(Product p) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/detail', arguments: p);
        },
        // borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ảnh sản phẩm
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  p.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
              SizedBox(width: 12),
              // Thông tin sản phẩm
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      p.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    // Category
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        p.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    // Description
                    Text(
                      p.description,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    // Price và Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                        Text(
                          '\$${p.price}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                        // Rating
                        if (p.rating != null)
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(
                                '${p.rating!.rate}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '(${p.rating!.count})',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //State

  //UI
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! Product) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết sản phẩm"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 17, 113, 192),
        ),
        body: Center(child: Text("Không tìm thấy sản phẩm")),
      );
    }

    final product = args;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 17, 113, 192),
      ),
      body: _detailWidgetProduct(product),
    );
  }
}

Widget _detailWidgetProduct(Product p) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(p.image, height: 200),
        SizedBox(height: 10),
        Text(
          p.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Giá: \$${p.price}",
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(width: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                p.category.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 150),
            if (p.rating != null)
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '${p.rating!.rate}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '(${p.rating!.count})',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
          ],
        ),

        SizedBox(height: 10),
        Text(
          "Mô tả:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Expanded(
          child: SingleChildScrollView(
            child: Text(p.description, style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    ),
  );
}
