//
//  CertWidget.swift
//  CertWidget
//
//  Created by Do Kiyong on 7/8/24.
//

import WidgetKit
import SwiftUI
import Intents

// https://ios-development.tistory.com/1131

// 위젯을 업데이트 할 시기를 WidgetKit에 알리는 역할
// SimpleEntry를 포함하여, 본격적으로 위젯에 표시될 placeholder, 데이터를 가져와서 표출해주는 snapshot, 타임라인 설정 관련된 timeLine이 존재
struct Provider: AppIntentTimelineProvider {
    // 데이터를 불러오기 전(snapshot)에 보여줄 placeholder
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), texts: ["empty"])
    }

    // 위젯 갤러리에서 위젯을 고를 때 보이는 샘플 데이터를 보여줄때 해당 메소드 호출
    // API를 통해서 데이터를 fetch하여 보여줄때 딜레이가 있는 경우 여기서 샘플 데이터를 하드코딩해서 보여주는 작업도 가능
    // context.isPreview가 true인 경우 위젯 갤러리에 위젯이 표출되는 상태
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        var entry = SimpleEntry(date: Date(), configuration: configuration, texts: ["empty"])
        
        getTexts { texts in
            var entry = SimpleEntry(date: Date(), configuration: configuration, texts: texts)
        }
        
        return entry
    }
    
    // 홈화면에 있는 위젯을 언제 업데이트 시킬것인지 구현하는 부분
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let currentDate = Date()
        let nextRefresh = Calendar.current.date(byAdding: .minute, value: 3, to: currentDate)!
        
        var entry = SimpleEntry(date: currentDate, configuration: configuration, texts: ["empty"])
        
        getTexts { texts in
            entry = SimpleEntry(date: currentDate, configuration: configuration, texts: texts)
        }
        
        // (4시간뒤에 다시 타임라인을 새로 다시 불러옴)
        // .atEnd: 마지막 date가 끝난 후 타임라인 reloading
        // .after: 다음 data가 지난 후 타임라인 reloading
        // .never: 즉시 타임라인 reloading
        return Timeline(entries: [entry], policy: .after(nextRefresh))
    }
    
    private func getTexts(completion: @escaping ([String]) -> ()) {
        guard let url = URL(string: "https://meowfacts.herokuapp.com/?count=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let textModel = try? JSONDecoder().decode(TextModel.self, from: data) else { return }
            
            completion(textModel.datas)
        }.resume()
    }
}

// TimelineEntry를 준수하는 구조체
// TimelineEntry: 위젯을 표시할 Date를 정하고, 그 Data에 표시할 데이터를 나타냄
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let texts: [String]
}

// 위젯 뷰를 표출
struct CertWidgetEntryView: View {
    var entry: Provider.Entry
    
    private var randomColor: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }

    var body: some View {
        ZStack {
            randomColor.opacity(0.7)
            
            ForEach(entry.texts, id: \.hashValue) { text in
                LazyVStack { // Widget은 스크롤이 안되므로, List지원 x (대신 VStack 사용)
                    Text(text)
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                    
                    Divider()
                }
            }
        }
    }
}

struct CertWidget: Widget {
    // 위젯에서 타임라인을 리로드할때 사용
    let kind: String = "CertWidget"

    // body 안에 사용하는 Configuration
    // IntentConfiguration: 사용자가 위젯에서 Edit을 통해 위젯에 보여지는 내용 변경이 가능
    // StaticConfiguration: 사용자가 변경 불가능한 정적 데이터 표출
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, // 위젯의 ID
                               intent: ConfigurationAppIntent.self, // 사용자가 설정하는 컨피그
                               provider: Provider() // 위젯 생성자 (타이밍 설정도 가능)
        ) { entry in
            CertWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    CertWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, texts: ["Empty"])
    SimpleEntry(date: .now, configuration: .starEyes, texts: ["Empty"])
}
