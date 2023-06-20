import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:triyleapp/widgets/custom_actionbar.dart';
import 'package:url_launcher/url_launcher.dart';
bool haspayed= false;
class EventPage extends StatefulWidget {
  final String eventid;

  const EventPage({required this.eventid});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final CollectionReference _eventReference =
      FirebaseFirestore.instance.collection("Events");
  late Razorpay _razorpay;


  @override
  void initState() {
    super.initState();
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentsucces);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void oppencheckout(int amount) {
    var options = {
      'key': 'rzp_test_WM9mlaIxa1oemc',
      'amount': amount * 100,
      'name': 'TRIYLE',
      "external": {
        "Wallets": ["paytm"]
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentsucces() {
    setState(() {
      haspayed = true;
    });
  }

  void handlerPaymentError() {
    print('error');
  }

  void handlerExternalWallet() {
    print("exterenal");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder(
              future: _eventReference.doc(widget.eventid).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  int amount = data['price'];
                  return Scaffold(
                    backgroundColor: Colors.black,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomActionBar(
                          hasregsiterno: false,
                          title: '${data['EventName']}',
                          hasbackarrow: true,
                          hastitle: true,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20,
                          horizontal: 20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade700,
                                offset: const Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                               //BoxShadow
                            ],),
                          child: Image.network(
                            "${data['Image'][0]}",
                            width: 600,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          "${data['descr']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.0,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Event Entry Fee : ₹${data['price']}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                              fontSize: 18,
                              color: Colors.blueAccent),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(

                          decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(24)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 48, vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),

                                        color: Colors.black),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if(haspayed==false)
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: GestureDetector(
                                  onTap: () {
                                    oppencheckout(amount);
                                    if(haspayed==true){_launchURL();}
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 48, vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),

                                        color: Colors.black),
                                    child: Center(
                                      child:
                                      Text(
                                        "Register",
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              }
              ),
        ],
      ),
    );
  }
}

_launchURL() async {
  var url = 'https://discord.gg/qQpdnrrSfV';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}