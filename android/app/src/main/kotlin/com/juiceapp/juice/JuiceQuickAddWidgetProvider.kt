package com.juiceapp.juice

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent

/**
 * 탭 한 번으로 앱을 열고 지출 입력 바텀시트를 바로 띄우는 빠른 입력 위젯.
 * juice://addExpense 딥링크로 열리며, Flutter 쪽 HomeWidgetLauncher가 이를 감지해
 * showAddExpenseSheet()를 호출한다.
 */
class JuiceQuickAddWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.juice_quick_add_widget)

            val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                context,
                MainActivity::class.java,
                Uri.parse("juice://addExpense")
            )
            views.setOnClickPendingIntent(R.id.widget_quick_add_root, pendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
