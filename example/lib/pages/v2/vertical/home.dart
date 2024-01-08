import 'package:flutter/material.dart';
import 'package:imin_printer_example/pages/v2/vertical/setting.dart';
// import 'package:logger/logger.dart';

// var logger = Logger();
class VerticalHome extends StatefulWidget {
  const VerticalHome({super.key});
  final String title = '打印测试';
  @override
  State<VerticalHome> createState() => _VerticalHomeState();
}

class _VerticalHomeState extends State<VerticalHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height,
        // alignment: Alignment.topRight,
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.contain,
                alignment: Alignment(2.6, 0.0))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              widget.title,
              style: const TextStyle(
                  color: Color(0xFF1D1D1F), fontWeight: FontWeight.w600),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: Image.asset("assets/images/setting.png"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()),
                  );
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  height: 150.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/bg-normal.png"),
                          fit: BoxFit.fill)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '打印机状态',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Wrap(
                        runSpacing: 9.0,
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '正常',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 0, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Text('功能测试',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1d1d1f))),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 5.0),
                        child: Image(
                            image: AssetImage('assets/images/dot.png'),
                            fit: BoxFit.cover,
                            width: 25),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                       ElevatedButton(
                        onPressed: null,
                      child: Text('Text fontSize'))
                      // Card(
                      //     elevation: 0.0,
                      //     color: Color(0xFFf5f5f5),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(5.0)),
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Padding(
                      //           padding: EdgeInsets.symmetric(
                      //               horizontal: 20.0, vertical: 10.0),
                      //           child: ListTile(
                      //             leading: SizedBox(
                      //               height: 50,
                      //               width: 50,
                      //               child: CircleAvatar(
                      //                 backgroundColor: Colors.transparent,
                      //                 backgroundImage: AssetImage(
                      //                     'assets/images/comprehensive-test.png'),
                      //               ),
                      //             ),
                      //             title: Text('综合测试'),
                      //           ),
                      //         )
                      //       ],
                      //     )
                      // ),
                      // Card(
                      //   elevation: 0.0,
                      //   color: Color(0xFFf5f5f5),
                      //   child: Text('3423423'),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
