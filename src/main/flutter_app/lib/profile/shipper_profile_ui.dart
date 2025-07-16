import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_theme.dart';

class ShipperProfileUI extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final String selectedRole;

  const ShipperProfileUI({
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 상단 프로필
          Container(
            width: double.infinity,
            color: AppColors.base,
            padding: const EdgeInsets.only(top: 35, bottom: 70),
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
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0), // 아래쪽 padding 0
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
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          content: const Text("로그아웃 하시겠습니까?", style: TextStyle(fontSize: 16)),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.grey,
                              ),
                              child: const Text("아니오"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: AppColors.primary,
                              ),
                              child: const Text("예"),
                            ),
                          ],
                        );
                      },
                    );

                    if (shouldLogout == true) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Center(
                    child: Text(
                      '로그아웃',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
