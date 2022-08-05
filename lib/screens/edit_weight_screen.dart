import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weight_app/navigation_handler/go.dart';
import 'package:flutter_weight_app/screens/show_weight_screen.dart';
import 'package:flutter_weight_app/utils/app_utils.dart';

import '../firestore_service/firestore_service.dart';
import '../models/weight_model.dart';
import '../utils/constants.dart';
import '../widgets/loading_indecator.dart';

class EditWeightScreen extends StatefulWidget {
  final WeightModel? weightModel;

  const EditWeightScreen({Key? key, this.weightModel}) : super(key: key);

  @override
  State<EditWeightScreen> createState() => _EditWeightScreenState();
}

class _EditWeightScreenState extends State<EditWeightScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController nameController = TextEditingController();


  AppUtils utils = AppUtils();
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _initData();
    super.initState();
  }

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
                    onChange: (value) => widget.weightModel!.name = value,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  utils.textField(
                    controller: weightController,
                    width: MediaQuery.of(context).size.width,
                    borderColor: darkOrangeColor,
                    hintText: "Weight",
                    prefixIconImage: Icons.monitor_weight,
                    prefixIconColor: redColor,
                    validator: (pas) {
                      if (pas!.isEmpty) {
                        return 'Please Enter Your Weight !';
                      }

                      return null;
                    },
                    onChange: (value) => widget.weightModel!.weight = int.parse(value),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .10,
                  ),
                  utils.gradientButton(
                    onTap: () {
                      _onSave();
                    },
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: "Edit",
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

  void _initData() {
    nameController.text = widget.weightModel?.name ?? '';
    weightController.text = widget.weightModel?.weight.toString() ?? '';
  }

  void _onSave() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState?.save();
    setState(() => _isLoading = true);
    WeightModel weightModel = WeightModel(
        name: nameController.text, weight: int.parse(weightController.text));
    await FirestoreService().updateWeight(weightModel);
    // if (!mounted) return;
    //
    // Go.back(context);
    setState(() => _isLoading = false);
  }
}
