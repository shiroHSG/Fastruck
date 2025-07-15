import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../app_theme.dart';

class ShipperHomeUI extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime) onMonthChanged;
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;

  const ShipperHomeUI({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onMonthChanged,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 달력 헤더 (월 선택 드롭다운)
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.base,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  width: 80, // 드롭다운 너비 조정
                  child: DropdownButton<String>(
                    value: "${focusedDay.month}월",
                    dropdownColor: AppColors.base,
                    underline: const SizedBox(),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black),
                    items: List.generate(12, (index) {
                      return DropdownMenuItem(
                        value: '${index + 1}월',
                        child: Center( // 가운데 정렬
                          child: Text(
                            '${index + 1}월',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        int selectedMonth = int.parse(value.replaceAll('월', ''));
                        final newDate = DateTime(focusedDay.year, selectedMonth, 1);
                        onMonthChanged(newDate);
                      }
                    },
                  ),

                ),
              ),
            ],
          ),
        ),

        // 캘린더
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: onDaySelected,
          calendarFormat: CalendarFormat.month,
          headerVisible: false,
          rowHeight: 80, // 날짜 간격(셀 높이) 늘리기
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: AppColors.base,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: const TextStyle(color: Colors.black),
          ),
        ),

        const SizedBox(height: 30),

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
    );
  }
}
