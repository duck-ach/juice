package com.juiceapp.juice

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * 홈 화면에 남은 주스(예산) 수위를 보여주는 위젯.
 * 탭하면 앱이 대시보드로 열린다. 데이터는 [HomeWidgetKeys](Flutter)가 저장한
 * SharedPreferences 값을 그대로 읽는다.
 */
class JuiceGaugeWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        val prefs = HomeWidgetPlugin.getData(context)

        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.juice_gauge_widget)

            val remaining = prefs.getString("remaining_text", null) ?: "-"
            val budget = prefs.getString("budget_text", null) ?: "-"
            val week = prefs.getString("week_label", null) ?: ""
            val percent = prefs.getInt("percent", 0)

            views.setTextViewText(R.id.widget_remaining, remaining)
            views.setTextViewText(R.id.widget_budget_label, "/ $budget")
            views.setTextViewText(R.id.widget_week_label, week)
            views.setProgressBar(R.id.widget_progress, 100, percent, false)

            val pendingIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
            views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
