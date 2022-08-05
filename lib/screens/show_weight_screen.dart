import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weight_app/models/weight_model.dart';
import 'package:flutter_weight_app/navigation_handler/go.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../firestore_service/firestore_service.dart';
import '../utils/app_utils.dart';
import '../utils/constants.dart';
import 'edit_weight_screen.dart';

class ShowWeightScreen extends StatefulWidget {
  final WeightModel? weightModel;

  const ShowWeightScreen({Key? key, this.weightModel}) : super(key: key);

  @override
  State<ShowWeightScreen> createState() => _ShowWeightScreenState();
}

class _ShowWeightScreenState extends State<ShowWeightScreen> {
  AppUtils utils = AppUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Your Most Recent Weight",
                style: utils.extraLargeHeadingStyle(color: darkOrangeColor),
                textAlign: TextAlign.center,
              ),


              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('weight')
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .orderBy("createdAt", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData || snapshot.data!.size == 0) {
                      return const Center(
                          child: Text('You do not have any weight history'));
                    }
                    if (snapshot.hasError) {
                      return const Text('something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading');
                    }

                    List<WeightModel> weightModel = snapshot.data!.docs
                        .map((doc) => WeightModel.mapToDuel(
                            doc.data() as Map<String, dynamic>))
                        .toList();
                    print(weightModel.length);

                    return ListView.builder(
                      itemCount: weightModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.orange.withOpacity(.3)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Your Name",
                                          style: utils.smallTitleStyle(
                                              color: darkOrangeColor),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Your Weight",
                                          style: utils.smallTitleStyle(
                                              color: darkOrangeColor),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Created Date",
                                          style: utils.smallTitleStyle(
                                              color: darkOrangeColor),
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            Go.to(
                                                context,
                                                EditWeightScreen(
                                                  weightModel: weightModel[index],
                                                ));
                                          },

                                          icon: const Icon(
                                            Icons.edit,
                                            color: redColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          weightModel[index].name.toString(),
                                          style: utils.smallTitleStyle(
                                              color: darkOrangeColor),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          weightModel[index].weight.toString(),
                                          style: utils.smallTitleStyle(
                                              color: darkOrangeColor),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          DateFormat.jm().format(weightModel[index]
                                              .createdAt!
                                              .toDate()),
                                          style: utils.smallTitleStyle(
                                              color: darkOrangeColor),
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          onPressed: () async {
                                            await FirestoreService()
                                                .deleteWeight(weightModel[index]);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: redColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
