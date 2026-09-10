import SwiftUI
import WidgetKit

// 탭 한 번으로 앱을 열고 지출 입력 바텀시트를 바로 띄우는 위젯.
// juice://addExpense 로 열리며, Flutter의 HomeWidgetLauncher가 이를 감지해
// showAddExpenseSheet()를 호출한다.

struct JuiceQuickAddEntry: TimelineEntry {
    let date: Date
}

struct JuiceQuickAddProvider: TimelineProvider {
    func placeholder(in context: Context) -> JuiceQuickAddEntry {
        JuiceQuickAddEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (JuiceQuickAddEntry) -> Void) {
        completion(JuiceQuickAddEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<JuiceQuickAddEntry>) -> Void) {
        completion(Timeline(entries: [JuiceQuickAddEntry(date: Date())], policy: .never))
    }
}

struct JuiceQuickAddWidgetView: View {
    var entry: JuiceQuickAddEntry

    var body: some View {
        VStack(spacing: 6) {
            Text("+")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
            Text("지출 입력")
                .font(.caption)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 1, green: 0.48, blue: 0))
        .widgetURL(URL(string: "juice://addExpense"))
    }
}

struct JuiceQuickAddWidget: Widget {
    // Flutter 쪽에서 iOS는 딥링크(widgetURL)로만 동작하므로 별도 이름 매칭이 필요 없다.
    let kind: String = "JuiceQuickAddWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: JuiceQuickAddProvider()) { entry in
            JuiceQuickAddWidgetView(entry: entry)
        }
        .configurationDisplayName("빠른 지출 입력")
        .description("탭 한 번으로 바로 지출을 기록해요")
        .supportedFamilies([.systemSmall])
    }
}
