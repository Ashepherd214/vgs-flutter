import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../BackgroundComponents/app_state.dart';
import '../src/authentication.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedAircraftIndex = 0;
  int selectedRunwayIndex = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final List<String> aircraftEntries = <String>['A320', 'B787', 'C172'];
    final List<String> runwayEntries = <String>[
      'KJFK 31L',
      'EGLL 21R',
      'KDFW 32R'
    ];

    return MaterialApp(
      title: 'RSi Visual Ground Segment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Items Select'),
        ),
        body: Row(
          children: [
            Consumer<ApplicationState>(
              builder: (context, appState, _) => AuthFunc(
                  loggedIn: appState.loggedIn,
                  signOut: () {
                    FirebaseAuth.instance.signOut();
                  }),
            ),
            Flexible(
              child: Column(
                children: <Widget>[
                  const Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'Select Aircraft',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: aircraftEntries.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              color: selectedAircraftIndex == index
                                  ? Colors.blue
                                  : null,
                              child: ListTile(
                                title: Text(aircraftEntries[index]),
                                onTap: () {
                                  setState(() {
                                    selectedAircraftIndex = index;
                                  });
                                },
                              ),
                            );
                            // return Container(
                            //   height: 50,
                            //   color: Colors.blue[aircraftCodes[index]],
                            //   child: Center(
                            //       child:
                            //           Text('Entry ${aircraftEntries[index]}')),
                            // );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: <Widget>[
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'Select Runway',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Flexible(
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: runwayEntries.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              color: selectedRunwayIndex == index
                                  ? Colors.blue
                                  : null,
                              child: ListTile(
                                title: Text(runwayEntries[index]),
                                onTap: () {
                                  setState(() {
                                    selectedRunwayIndex = index;
                                  });
                                },
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
