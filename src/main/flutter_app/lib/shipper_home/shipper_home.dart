import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../app_theme.dart';

class ShipperHomePage extends StatefulWidget {
  const ShipperHomePage({super.key});

  @override
  State<ShipperHomePage> createState() => _ShipperHomePageState();
}

class _ShipperHomePageState extends State<ShipperHomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // 상단 로고 영역
          Container(
            width: double.infinity,
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              children: [
                Image.asset(
                  'assets/image/logo1.png',
                  width: 40,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Fastruck',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 달력 헤더
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<String>(
                value: "${_focusedDay.month}월",
                items: List.generate(12, (index) {
                  return DropdownMenuItem(
                    value: '${index + 1}월',
                    child: Text('${index + 1}월'),
                  );
                }),
                onChanged: (value) {
                  if (value != null) {
                    int selectedMonth = int.parse(value.replaceAll('월', ''));
                    setState(() {
                      _focusedDay = DateTime(_focusedDay.year, selectedMonth, 1);
                    });
                  }
                },
              ),
            ),
          ),

          // 캘린더
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            headerVisible: false,
            calendarFormat: CalendarFormat.month,
          ),

          const SizedBox(height: 20),

          // 입찰 상태 설명
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.circle, color: Colors.red, size: 12),
                SizedBox(width: 6),
                Text('입찰 진행중'),
                SizedBox(width: 20),
                Icon(Icons.circle, color: Colors.green, size: 12),
                SizedBox(width: 6),
                Text('입찰 완료'),
              ],
            ),
          ),
        ],
      ),

      // 바텀 네비게이션
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: '요청목록'),
          BottomNavigationBarItem(icon: Icon(Icons.reviews), label: '리뷰'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: '공지'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
        ],
      ),
    );
  }
}
