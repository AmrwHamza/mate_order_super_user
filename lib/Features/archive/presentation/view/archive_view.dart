import 'package:flutter/material.dart';
import 'package:mate_order_super_user/Features/archive/presentation/view/archive_body.dart';
import 'package:mate_order_super_user/core/widgets/app_bar_style.dart';
import 'package:mate_order_super_user/core/widgets/drawer.dart';

class ArchiveView extends StatelessWidget {
  const ArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Archive'),
      drawer: const MainDrawer(),
      body: const ArchiveBody(),
    );
  }
}
