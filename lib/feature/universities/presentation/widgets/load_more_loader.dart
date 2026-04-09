import 'package:flutter/material.dart';
import 'package:universities/core/constants/app_spacing.dart';

class LoadMoreLoader extends StatelessWidget {
  const LoadMoreLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
