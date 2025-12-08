import 'package:flutter/material.dart';

class MyPlace extends StatelessWidget {
  const MyPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: myBody());
  }

  // Widget myBody() {
  //   return Column(children: [block1(), block2(), block3(), block4()]);
  // }
  Widget myBody() {
    return SingleChildScrollView(
      child: Column(children: [block1(), block2(), block3(), block4()]),
    );
  }

  Widget block2() {
    var title = "Hoang Mạc Sahara";
    var subTitle = "Châu Phi";
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(subTitle, style: TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star, color: const Color.fromARGB(255, 253, 207, 2)),
              Text("41"),
            ],
          ),
        ],
      ),
    );
  }

  Widget block3() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(Icons.call, color: Colors.blue),
              Text("Call", style: TextStyle(color: Colors.blue)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.route, color: Colors.blue),
              Text("Route", style: TextStyle(color: Colors.blue)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.share, color: Colors.blue),
              Text("Share", style: TextStyle(color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget block4() {
    var context =
        "Được bao bọc bởi biển Đại Tây Dương ở phía Tây, dãy núi Atlas và Địa Trung Hải ở phía Bắc, Biển Đỏ (Hồng Hải) và Ai Cập ở phía Đông; Sudan và thung lũng sông Niger ở phía Nam. Điểm cao nhất trong sa mạc là đỉnh núi Emi Koussi với độ cao 3415 m so với mực nước biển, thuộc dãy núi Tibesti phía Bắc nước Tchad.Trong suốt kỷ nguyên băng hà, vùng Sahara đã từng ẩm ướt hơn ngày nay rất nhiều. Và cũng đã từng có rất nhiều loài động, thực vật sinh sống nơi đây. Tuy nhiên ngày nay,ngoại trừ vùng thung lũng sông Nin là có thể trồng được nhiều rau và một số ít nơi khác như vùng cao nguyên phía Bắc, gần Địa Trung Hải là có thể trồng cây ôliu còn phần lớn vùng này không thể canh tác được.";
    return Padding(padding: const EdgeInsets.all(20.0), child: Text(context));
  }

  Widget block1() {
    var src =
        "https://images.unsplash.com/photo-1559586616-361e18714958?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2FoYXJhfGVufDB8fDB8fHww";
    return Image.network(src);
  }
}
