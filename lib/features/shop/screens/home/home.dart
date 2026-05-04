import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osmart/features/shop/screens/home/widgets/water_level.dart';
import 'package:osmart/features/shop/screens/notification/notification.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("O-Smart", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Get.to(const NotificationScreen()); // Action de recherche
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
             child: Center(child: WaterLevel())),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // pousse aux bords
                          children: [
                            Text('Sources', style: TextStyle(fontSize: 16)),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle, // fait un rond parfait
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(33, 150, 243, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              "SBEE",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "220 v",
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              "PV",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "220 v",
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        "Autre",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "220 v",
                                      style: TextStyle(
                                        fontSize: 38,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // pousse aux bords
                    children: [
                      Text('Pompe AC', style: TextStyle(fontSize: 16)),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle, // fait un rond parfait
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(0),
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "700 W",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.blue,
                              thickness: 1,
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "5 A",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.blue),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // pousse aux bords
                          children: [
                            Text(
                              'Source utiliser:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'SBEE',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // pousse aux bords
                    children: [
                      Text('Pompe DC', style: TextStyle(fontSize: 16)),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle, // fait un rond parfait
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(0),
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "500 W",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.blue,
                              thickness: 1,
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "5 A",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.blue),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // pousse aux bords
                          children: [
                            Text(
                              'Source utiliser:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'PV',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
