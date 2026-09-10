import WidgetKit
import SwiftUI

// Xcode의 "Widget Extension" 템플릿이 자동 생성하는 ExtensionNameBundle.swift를
// 이 파일로 대체(또는 아래 내용을 병합)한다. @main은 익스텐션 당 하나만 있어야 한다.
@main
struct JuiceWidgetBundle: WidgetBundle {
    var body: some Widget {
        JuiceGaugeWidget()
        JuiceQuickAddWidget()
    }
}
