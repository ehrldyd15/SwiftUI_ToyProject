////
////  RandomTextWidgetLiveActivity.swift
////  RandomTextWidget
////
////  Created by Do Kiyong on 8/5/24.
////
//
//import ActivityKit
//import WidgetKit
//import SwiftUI
//
//struct RandomTextWidgetAttributes: ActivityAttributes {
//    public struct ContentState: Codable, Hashable {
//        // Dynamic stateful properties about your activity go here!
//        var emoji: String
//    }
//
//    // Fixed non-changing properties about your activity go here!
//    var name: String
//}
//
//struct RandomTextWidgetLiveActivity: Widget {
//    var body: some WidgetConfiguration {
//        ActivityConfiguration(for: RandomTextWidgetAttributes.self) { context in
//            // Lock screen/banner UI goes here
//            VStack {
//                Text("Hello \(context.state.emoji)")
//            }
//            .activityBackgroundTint(Color.cyan)
//            .activitySystemActionForegroundColor(Color.black)
//
//        } dynamicIsland: { context in
//            DynamicIsland {
//                // Expanded UI goes here.  Compose the expanded UI through
//                // various regions, like leading/trailing/center/bottom
//                DynamicIslandExpandedRegion(.leading) {
//                    Text("Leading")
//                }
//                DynamicIslandExpandedRegion(.trailing) {
//                    Text("Trailing")
//                }
//                DynamicIslandExpandedRegion(.bottom) {
//                    Text("Bottom \(context.state.emoji)")
//                    // more content
//                }
//            } compactLeading: {
//                Text("L")
//            } compactTrailing: {
//                Text("T \(context.state.emoji)")
//            } minimal: {
//                Text(context.state.emoji)
//            }
//            .widgetURL(URL(string: "http://www.apple.com"))
//            .keylineTint(Color.red)
//        }
//    }
//}
//
//extension RandomTextWidgetAttributes {
//    fileprivate static var preview: RandomTextWidgetAttributes {
//        RandomTextWidgetAttributes(name: "World")
//    }
//}
//
//extension RandomTextWidgetAttributes.ContentState {
//    fileprivate static var smiley: RandomTextWidgetAttributes.ContentState {
//        RandomTextWidgetAttributes.ContentState(emoji: "😀")
//     }
//     
//     fileprivate static var starEyes: RandomTextWidgetAttributes.ContentState {
//         RandomTextWidgetAttributes.ContentState(emoji: "🤩")
//     }
//}
//
//#Preview("Notification", as: .content, using: RandomTextWidgetAttributes.preview) {
//   RandomTextWidgetLiveActivity()
//} contentStates: {
//    RandomTextWidgetAttributes.ContentState.smiley
//    RandomTextWidgetAttributes.ContentState.starEyes
//}
