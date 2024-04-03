import 'package:flutter/material.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';
import 'package:front_have_a_meal/widget_tools/text_divider.dart';

class StudentQrScreenArgs {
  StudentQrScreenArgs({required this.ticketList});

  final List<TicketModel> ticketList;
}

class StudentQrScreen extends StatefulWidget {
  static const routeName = "student_ticket_qr";
  static const routeURL = "student_ticket_qr";
  const StudentQrScreen({
    super.key,
    required this.ticketList,
  });

  final List<TicketModel> ticketList;

  @override
  State<StudentQrScreen> createState() => _StudentQrScreenState();
}

class _StudentQrScreenState extends State<StudentQrScreen> {
  String _selectedTicket = "";

  @override
  void initState() {
    super.initState();

    _selectedTicket = widget.ticketList[0].menuId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            surfaceTintColor: Colors.orange.shade100,
            title: const Text("식권 사용"),
            backgroundColor: Colors.orange.shade100,
          ),
          const SliverToBoxAdapter(
            child: Center(
              child: Icon(
                Icons.qr_code_2,
                size: 200,
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: TextDivider(
                text: "식권 선택",
                fontSize: 24,
              ),
            ),
          ),
          SliverList.builder(
            itemCount: widget.ticketList.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.1,
                  ),
                ),
                child: RadioListTile.adaptive(
                  value: widget.ticketList[index].menuId,
                  groupValue: _selectedTicket,
                  onChanged: (value) {
                    setState(() {
                      _selectedTicket = value ?? "";
                    });
                  },
                  title: Text(" $index일 경과"),
                ),
              );
            },
          ),
        ],
      ),
      // body: NestedScrollView(
      //   headerSliverBuilder: (context, innerBoxIsScrolled) => [
      //     SliverAppBar(
      //       pinned: true,
      //       centerTitle: true,
      //       surfaceTintColor: Colors.orange.shade100,
      //       title: const Text("식권 사용"),
      //       backgroundColor: Colors.orange.shade100,
      //     ),
      //     const SliverToBoxAdapter(
      //       child: Column(
      //         children: [
      //           Center(
      //             child: Icon(
      //               Icons.qr_code_2,
      //               size: 200,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      //   body: ListView.builder(
      //     itemCount: widget.ticketList.length,
      //     itemBuilder: (context, index) {
      //       return RadioListTile.adaptive(
      //         value: widget.ticketList[index].menuId,
      //         groupValue: _selectedTicket,
      //         onChanged: (value) {
      //           setState(() {
      //             _selectedTicket = value ?? "";
      //           });
      //         },
      //         title: Text("지난 날짜 : $index일 지남"),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
