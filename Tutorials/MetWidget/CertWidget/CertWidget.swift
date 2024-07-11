//
//  CertWidget.swift
//  CertWidget
//
//  Created by Do Kiyong on 7/8/24.
//

import WidgetKit
import SwiftUI
import Intents

// https://rriver2.tistory.com/entry/SwiftUI-Widget-%EB%94%B1%EB%8C%80-14
// https://developer.apple.com/documentation/widgetkit/creating-a-widget-extension?language=objc

// 위젯을 업데이트 할 시기를 WidgetKit에 알리는 역할
// SimpleEntry를 포함하여, 본격적으로 위젯에 표시될 placeholder, 데이터를 가져와서 표출해주는 snapshot, 타임라인 설정 관련된 timeLine이 존재
struct Provider: TimelineProvider {
    // 데이터를 불러오기 전(snapshot)에 보여줄 placeholder
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), texts: ["empty"])
    }
    
    // 위젯 갤러리에서 위젯을 고를 때 보이는 샘플 데이터를 보여줄때 해당 메소드 호출
    // API를 통해서 데이터를 fetch하여 보여줄때 딜레이가 있는 경우 여기서 샘플 데이터를 하드코딩해서 보여주는 작업도 가능
    // context.isPreview가 true인 경우 위젯 갤러리에 위젯이 표출되는 상태
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        getTexts { texts in
            let entry = SimpleEntry(date: Date(), texts: texts)
            completion(entry)
        }
    }
    
    // 홈화면에 있는 위젯을 언제 업데이트 시킬것인지 구현하는 부분
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        getTexts { texts in
            let currentDate = Date()
            let entry = SimpleEntry(date: currentDate, texts: texts)
            let nextRefresh = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
            let timeline = Timeline(entries: [entry], policy: .after(nextRefresh))
            
            completion(timeline)
        }
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
    let texts: [String]
}

// 위젯 뷰를 표출
struct CertWidgetEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily
    
    var entry: Provider.Entry
    
    private var randomColor: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            ZStack {
                randomColor.opacity(0.7)
                
                Button(intent: ChangeText()) {
                    Text("컬러변경")
                }
            }
        case .systemMedium:
            ForEach(entry.texts, id: \.hashValue) { text in
                VStack {
                    Text(text)
                        .foregroundColor(Color.black)
                }
            }
        case .systemLarge:
            ZStack {
                ForEach(entry.texts, id: \.hashValue) { text in
                    LazyVStack { // Widget은 스크롤이 안되므로, List지원 x (대신 VStack 사용)
                        Text(text)
                            .foregroundColor(Color.black)
                        
                        Button(intent: ChangeText()) {
                            Text("텍스트 변경")
                        }
                    }
                }
            }
        default:
            Text("unknown")
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
        StaticConfiguration(kind: kind, // 위젯의 ID
                            provider: Provider() // 위젯 생성자 (타이밍 설정도 가능)
        ) { entry in
            CertWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    CertWidget()
} timeline: {
    SimpleEntry(date: .now, texts: ["Empty"])
    SimpleEntry(date: .now, texts: ["Empty"])
}
