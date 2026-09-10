import SwiftUI
import WidgetKit

// MARK: - App Group / 데이터 키
//
// Flutter 쪽(lib/core/widget/home_widget_service.dart, home_widget_keys.dart)이
// 저장하는 값과 반드시 동일한 App Group ID / 키를 사용해야 한다.
// - App Group: group.com.juiceapp.juice
// - Widget kind: "JuiceGaugeWidget" (HomeWidgetNames.iosGaugeWidget)
private let appGroupId = "group.com.juiceapp.juice"

private enum WidgetDataKey {
    static let remainingText = "remaining_text"
    static let budgetText = "budget_text"
    static let percent = "percent"
    static let weekLabel = "week_label"
}

// MARK: - Timeline Entry

struct JuiceGaugeEntry: TimelineEntry {
    let date: Date
    let remainingText: String
    let budgetText: String
    let percent: Int
    let weekLabel: String
}

// MARK: - Timeline Provider

struct JuiceGaugeProvider: TimelineProvider {
    func placeholder(in context: Context) -> JuiceGaugeEntry {
        JuiceGaugeEntry(date: Date(), remainingText: "160,000원", budgetText: "160,000원", percent: 100, weekLabel: "9.7 - 9.13")
    }

    func getSnapshot(in context: Context, completion: @escaping (JuiceGaugeEntry) -> Void) {
        completion(loadEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<JuiceGaugeEntry>) -> Void) {
        let entry = loadEntry()
        // 앱이 지출 추가 시마다 WidgetCenter.reloadTimelines를 직접 호출하므로
        // 여기서는 짧은 주기로만 갱신하면 충분하다.
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date()) ?? Date()
        completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
    }

    private func loadEntry() -> JuiceGaugeEntry {
        let defaults = UserDefaults(suiteName: appGroupId)
        return JuiceGaugeEntry(
            date: Date(),
            remainingText: defaults?.string(forKey: WidgetDataKey.remainingText) ?? "-",
            budgetText: defaults?.string(forKey: WidgetDataKey.budgetText) ?? "-",
            percent: defaults?.integer(forKey: WidgetDataKey.percent) ?? 0,
            weekLabel: defaults?.string(forKey: WidgetDataKey.weekLabel) ?? ""
        )
    }
}

// MARK: - View

struct JuiceGaugeWidgetView: View {
    var entry: JuiceGaugeEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(entry.weekLabel)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.8))

            Text(entry.remainingText)
                .font(.title2.bold())
                .foregroundColor(.white)

            Text("/ \(entry.budgetText)")
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))

            ProgressView(value: Double(entry.percent), total: 100)
                .tint(.white)
                .padding(.top, 4)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            LinearGradient(
                colors: [Color(red: 1, green: 0.72, blue: 0), Color(red: 1, green: 0.48, blue: 0)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        // 탭하면 앱이 열리도록. 딥링크가 필요하면 .widgetURL(URL(string: "juice://home")) 사용.
        .widgetURL(URL(string: "juice://home"))
    }
}

// MARK: - Widget

struct JuiceGaugeWidget: Widget {
    // Flutter의 HomeWidgetNames.iosGaugeWidget과 동일해야 한다.
    let kind: String = "JuiceGaugeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: JuiceGaugeProvider()) { entry in
            JuiceGaugeWidgetView(entry: entry)
        }
        .configurationDisplayName("주스 게이지")
        .description("이번 주 남은 주스(예산) 수위를 보여줘요")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
