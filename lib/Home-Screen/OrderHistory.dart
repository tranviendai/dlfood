import 'package:dlfood/Data/Api.dart';
import 'package:dlfood/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderHistoryScreen extends StatefulWidget {
  final String token;
  const OrderHistoryScreen({super.key, required this.token});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  Future<List<BillModel>> _getBills() async {
    return await APIRepository().getHistory(widget.token);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<BillModel>>(
        future: _getBills(),
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
          return ListView.builder(
            itemCount: snapshot.data!.length, // Số đơn hàng trong lịch sử
            itemBuilder: (context, index) {
              var data = snapshot.data![index];
              return ListTile(
                title: Text('Đơn hàng #${index + 1}'),
                subtitle: Text("${data.total.toDouble()} VNĐ - ${data.dateCreated}"),
                onTap: () async {
      var temp = await APIRepository().getHistoryDetail(data.id, widget.token);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetail(bill: temp)));
                 
                },
              );
            },
          );
        }
      ),
    );
  }
}


class HistoryDetail extends StatelessWidget {
  final List<BillDetailModel> bill;

  const HistoryDetail({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết hóa đơn"),
      ),
      body: ListView.builder(
        itemCount: bill.length,
        itemBuilder: (context, index) {
        var data = bill[index];
        return Container(
          margin: const EdgeInsets.all(10),
          color: Colors.black12,
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(data.imageUrl),
              Text(data.productName),
              Text("Số lượng " +data.count.toString()),
              Text("Giá gốc: "+ data.price.toString() + "VNĐ"),
              Text("Total " + data.total.toString() + "VNĐ"),
            ],
          ),
        );
      },),
    );
  }
}