import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triyleapp/screens/eventpage.dart';
import 'package:triyleapp/widgets/custom_actionbar.dart';
class HomeTab extends StatelessWidget {
  final CollectionReference _eventReference =
      FirebaseFirestore.instance.collection("Events");

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<QuerySnapshot>(
            future: _eventReference.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              //collection data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                //display the data in a list view
                return Scaffold(
                  backgroundColor: Colors.black12,
                  body :SafeArea(
                    child: ListView(
                      padding: EdgeInsets.only(
                        top: 100.0,
                        bottom: 24.0,
                      ),
                      children: snapshot.data!.docs.map((document) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>EventPage(eventid: document.id)));
                          },
                          child: Container(

                            height: 250,
                            margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12.0),
                            child: Stack(
                              children: [
                                Container(

                                  height: 220,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.network(
                                      "${document['Image'][0]}",
                                      width: 400,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                Positioned(

                                  bottom: 0,
                                  left: 10,
                                  right: 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${document['EventName']}",
                                        style: GoogleFonts.alegreya(
                                          color: Colors.orange.shade700,
                                          textStyle: Theme.of(context).textTheme.titleLarge,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,

                                        ),),
                                      Text("₹${document["price"]}/-",
                                        style: GoogleFonts.getFont('Lato',fontSize: 20,fontWeight: FontWeight.w800,color: Colors.white),),
                                    ],
                                  ),
                                )

                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),);
              }
              //loading state
              return Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            }),
        CustomActionBar(
          hasregsiterno: true,
          title: 'TRIYLE',
          hasbackarrow: false,
          hastitle: true,
        ),
      ],
    );
  }
}
