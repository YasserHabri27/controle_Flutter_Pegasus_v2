import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:pegasus_app/core/app_export.dart';
import '../package:pegasus_app/core/widgets/custom_icon_widget.dart';

/// A widget displaying productivity heatmap calendar
/// Shows task activity intensity with color-coded days
class ProductivityHeatmapWidget extends StatefulWidget {
  final Map<DateTime, int> activityData;

  const ProductivityHeatmapWidget({super.key, required this.activityData});

  @override
  State<ProductivityHeatmapWidget> createState() =>
      _ProductivityHeatmapWidgetState();
}

class _ProductivityHeatmapWidgetState extends State<ProductivityHeatmapWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calendrier d\'activité',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Semantics(
            label:
                "Calendrier de productivité montrant l'intensité des tâches par jour",
            child: TableCalendar(
              firstDay: DateTime.now().subtract(const Duration(days: 365)),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                leftChevronIcon: CustomIconWidget(
                  iconName: 'chevron_left',
                  color: theme.colorScheme.onSurface,
                  size: 20,
                ),
                rightChevronIcon: CustomIconWidget(
                  iconName: 'chevron_right',
                  color: theme.colorScheme.onSurface,
                  size: 20,
                ),
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                weekendTextStyle: theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.error,
                ),
                todayDecoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: theme.textTheme.bodySmall!,
                weekendDecoration: const BoxDecoration(),
                markerDecoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: theme.textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                weekendStyle: theme.textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.error,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  return _buildDayCell(day, theme, false);
                },
                todayBuilder: (context, day, focusedDay) {
                  return _buildDayCell(day, theme, true);
                },
              ),
            ),
          ),
          SizedBox(height: 2.h),
          _buildLegend(theme),
        ],
      ),
    );
  }

  Widget _buildDayCell(DateTime day, ThemeData theme, bool isToday) {
    final intensity =
        widget.activityData[DateTime(day.year, day.month, day.day)] ?? 0;
    final color = _getIntensityColor(intensity, theme);

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isToday
            ? Border.all(color: theme.colorScheme.primary, width: 2)
            : null,
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: intensity > 0
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface,
            fontWeight: isToday ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Color _getIntensityColor(int intensity, ThemeData theme) {
    if (intensity == 0) {
      return theme.colorScheme.surface;
    } else if (intensity <= 3) {
      return theme.colorScheme.primary.withValues(alpha: 0.3);
    } else if (intensity <= 6) {
      return theme.colorScheme.primary.withValues(alpha: 0.6);
    } else {
      return theme.colorScheme.primary;
    }
  }

  Widget _buildLegend(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Moins',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(width: 2.w),
        _buildLegendBox(theme.colorScheme.surface, theme),
        SizedBox(width: 1.w),
        _buildLegendBox(
          theme.colorScheme.primary.withValues(alpha: 0.3),
          theme,
        ),
        SizedBox(width: 1.w),
        _buildLegendBox(
          theme.colorScheme.primary.withValues(alpha: 0.6),
          theme,
        ),
        SizedBox(width: 1.w),
        _buildLegendBox(theme.colorScheme.primary, theme),
        SizedBox(width: 2.w),
        Text(
          'Plus',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendBox(Color color, ThemeData theme) {
    return Container(
      width: 4.w,
      height: 4.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
    );
  }
}
