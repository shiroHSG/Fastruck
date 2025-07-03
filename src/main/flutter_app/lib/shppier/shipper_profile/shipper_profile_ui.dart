import 'package:flutter/material.dart';
import '../../../app_theme.dart';

class ProfilePageUI extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final String selectedRole;

  const ProfilePageUI({
    super.key,
    required this.emailController,
    required this.nameController,
    required this.phoneController,
    required this.selectedRole,
  });

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.point, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.base.withOpacity(0.2),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRoleButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: selectedRole == 'SHIPPER'
                  ? AppColors.primary
                  : AppColors.base.withOpacity(0.3),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('화주', style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: selectedRole == 'CARRIER'
                  ? AppColors.point
                  : AppColors.base.withOpacity(0.3),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('차주', style: TextStyle(color: AppColors.point)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // 상단 프로필
          Container(
            width: double.infinity,
            color: AppColors.base,
            padding: const EdgeInsets.only(top: 40, bottom: 80),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50, color: AppColors.point),
                    ),
                    Positioned(
                      right: 1,
                      bottom: 4,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(Icons.camera_alt, size: 23, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          // 입력 영역
          Container(
            transform: Matrix4.translationValues(0, -40, 0),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('이메일', emailController),
                _buildTextField('이름', nameController),
                _buildTextField('전화번호', phoneController),
                const Text('가입 유형', style: TextStyle(color: AppColors.point, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                _buildRoleButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
