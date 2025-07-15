import 'package:flutter/material.dart';
import 'package:flutter_app/profile/shipper_profile_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'carrier_profile_ui.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String selectedRole = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('email') ?? '';
      nameController.text = prefs.getString('name') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      selectedRole = prefs.getString('role') ?? '';
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedRole == 'SHIPPER') {
      return ShipperProfileUI(
        emailController: emailController,
        nameController: nameController,
        phoneController: phoneController,
        selectedRole: selectedRole,
      );
    } else if (selectedRole == 'CARRIER') {
      return CarrierProfileUI(
        emailController: emailController,
        nameController: nameController,
        phoneController: phoneController,
        selectedRole: selectedRole,
      );
    } else {
      // 로딩 중이거나 role 정보가 아직 없는 경우
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
