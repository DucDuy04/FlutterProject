import 'package:flutter/material.dart';

class BookHotelRoom extends StatelessWidget {
  const BookHotelRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(child: _myBody()),
    );
  }

  Widget _myBody() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            _background(),
            Positioned(top: 30, left: 16, right: 16, child: _appHeader()),
          ],
        ),
        const SizedBox(height: 15),
        _filterBar(),
        const SizedBox(height: 15),
        _hotelCount(),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: [
              _hotelItem(
                hotelName: "Khách sạn Sunshine",
                imageUrl: "assets/images/a1.jpg",
                rating: 4.5,
                reviewCount: 120,
                location: "Hà Nội",
                distance: "500m",
                roomType: "Phòng Deluxe",
                price: 150.0,
                hasBreakfast: true,
              ),
              _hotelItem(
                hotelName: "Khách sạn Moonlight",
                imageUrl: "assets/images/a2.jpg",
                rating: 4.0,
                reviewCount: 85,
                location: "Hồ Chí Minh",
                distance: "1km",
                roomType: "Phòng Superior",
                price: 120.0,
                hasBreakfast: false,
              ),
              _hotelItem(
                hotelName: "Khách sạn Ocean View",
                imageUrl: "assets/images/a3.jpg",
                rating: 4.8,
                reviewCount: 200,
                location: "Đà Nẵng",
                distance: "800m",
                roomType: "Phòng Premium",
                price: 180.0,
                hasBreakfast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _background() {
    return Container(height: 60, color: Colors.blue[900]);
  }

  Widget _appHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.orange, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back, color: Colors.black),
              SizedBox(width: 8),
              Text(
                'Xung quanh vị trí hiện tại  23 thg 10 - 24 thg 10',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterBar() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Row(
            children: [
              Icon(Icons.sort, color: Colors.black),
              SizedBox(width: 6),
              Text('Sắp xếp', style: TextStyle(fontSize: 16)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.filter_list, color: Colors.black),
              SizedBox(width: 6),
              Text('Lọc', style: TextStyle(fontSize: 16)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.map, color: Colors.black),
              SizedBox(width: 6),
              Text('Bản đồ', style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _hotelCount() {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "759 Chỗ nghỉ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Hotel Item Widget
  Widget _hotelItem({
    required String hotelName,
    required String imageUrl,
    required double rating,
    required int reviewCount,
    required String location,
    required String distance,
    required String roomType,
    required double price,
    required bool hasBreakfast,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT SIDE: IMAGE + TAG
          _buildHotelImage(imageUrl, hasBreakfast),
          const SizedBox(width: 12),
          // RIGHT SIDE: ALL INFO
          Expanded(
            child: _buildHotelInfo(
              hotelName: hotelName,
              rating: rating,
              reviewCount: reviewCount,
              location: location,
              distance: distance,
              roomType: roomType,
              price: price,
            ),
          ),
          // FAVORITE ICON
          _buildFavoriteIcon(),
        ],
      ),
    );
  }

  Widget _buildHotelImage(String imageUrl, bool hasBreakfast) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imageUrl,
            width: 140,
            height: 140,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 140,
                height: 140,
                color: Colors.grey[300],
                child: const Icon(Icons.hotel, size: 40, color: Colors.grey),
              );
            },
          ),
        ),
        if (hasBreakfast)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0D8A4C),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                "Bao bữa sáng",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHotelInfo({
    required String hotelName,
    required double rating,
    required int reviewCount,
    required String location,
    required String distance,
    required String roomType,
    required double price,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          hotelName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        _buildRatingStars(rating),
        const SizedBox(height: 6),
        _buildRatingScore(rating, reviewCount),
        const SizedBox(height: 6),
        _buildLocation(location, distance),
        const SizedBox(height: 6),
        Text(
          roomType,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        _buildPriceSection(price),
      ],
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          size: 14,
          color: const Color(0xFFFFA500),
        ),
      ),
    );
  }

  Widget _buildRatingScore(double rating, int reviewCount) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFF0066CC),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            "Xuất sắc · $reviewCount đánh giá",
            style: const TextStyle(fontSize: 11, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildLocation(String location, String distance) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 13, color: Colors.grey[600]),
        const SizedBox(width: 2),
        Expanded(
          child: Text(
            "$location · Cách bạn $distance",
            style: const TextStyle(fontSize: 11, color: Colors.black54),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection(double price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "US\$${price.toStringAsFixed(0)}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        Text(
          "Đã bao gồm thuế và phí",
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildFavoriteIcon() {
    return const Padding(
      padding: EdgeInsets.only(left: 4),
      child: Icon(Icons.favorite_border, color: Colors.black87, size: 22),
    );
  }
}
