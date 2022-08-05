import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Widget? child;
  final bool isLoading;

  const LoadingIndicator({Key? key, this.child, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child!,
        Visibility(
          visible: isLoading,
          child: const ColoredBox(
            color: Colors.black26,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
