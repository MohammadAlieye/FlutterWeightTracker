import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weight_app/navigation_handler/go.dart';
import 'package:flutter_weight_app/screens/show_weight_screen.dart';

import '../firestore_service/firestore_service.dart';
import '../models/weight_model.dart';
import '../utils/app_utils.dart';
import '../utils/constants.dart';
import '../widgets/loading_indecator.dart';
import '../widgets/toast.dart';
import 'edit_weight_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final WeightModel _weightModel = WeightModel();
  AppUtils utils = AppUtils();
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    weightController.dispose();
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingIndicator(
        isLoading: _isLoading,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .16),
                  Text(
                    "Weight Tracker",
                    style: utils.largeBoldStyle(color: darkOrangeColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please enter your Weight here",
                    style: utils.mediumTitleStyle(color: orangeColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  utils.textField(
                    controller: nameController,
                    width: MediaQuery.of(context).size.width,
                    borderColor: darkOrangeColor,
                    hintText: "Name",
                    prefixIconImage: Icons.person,
                    prefixIconColor: redColor,
                    validator: (pas) {
                      if (pas!.isEmpty) {
                        return 'Please Enter Your Name!';
                      }

                      return null;
                    },
                    onChange: (value) => _weightModel.name = value,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  utils.textField(
                    controller: weightController,
                    width: MediaQuery.of(context).size.width,
                    borderColor: darkOrangeColor,
                    hintText: "Weight in kg",
                    prefixIconImage: Icons.monitor_weight,
                    prefixIconColor: redColor,
                    validator: (pas) {
                      if (pas!.isEmpty) {
                        return 'Please Enter Your Weight !';
                      }

                      return null;
                    },
                    onChange: (value) => _weightModel.weight = int.parse(value),
                  ),

                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .10,
                  ),
                  utils.gradientButton(
                    onTap: () {
                      _onCreate();
                      // Go.to(context, EditWeightScreen());
                    },
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: "submit",
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? kEmailValidator(String? emailValue) {
    if (emailValue!.isEmpty) {
      return 'Email is required !';
    }
    String p =
        "[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(emailValue)) {
      return null;
    } else {
      return 'Email Syntax is not Correct';
    }
  }

  Future<void> _onCreate() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    _weightModel.name = nameController.text;
    _weightModel.weight = int.parse(weightController.text);
    _weightModel.createdAt = Timestamp.now();
    print(Timestamp.now());
    setState(() => _isLoading = true);
    await FirestoreService().addItem(_weightModel);
    ToastOverlay().showToast('Weight Added');
    if (!mounted) return;
    Go.to(context, ShowWeightScreen(
      weightModel: _weightModel,
    ));
    setState(() => _isLoading = false);

  }
}
