//
//  MyHealthWidgetLiveActivity.swift
//  MyHealthWidget
//
//  Created by Do Kiyong on 5/9/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MyHealthWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MyHealthWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MyHealthWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MyHealthWidgetAttributes {
    fileprivate static var preview: MyHealthWidgetAttributes {
        MyHealthWidgetAttributes(name: "World")
    }
}

extension MyHealthWidgetAttributes.ContentState {
    fileprivate static var smiley: MyHealthWidgetAttributes.ContentState {
        MyHealthWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MyHealthWidgetAttributes.ContentState {
         MyHealthWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MyHealthWidgetAttributes.preview) {
   MyHealthWidgetLiveActivity()
} contentStates: {
    MyHealthWidgetAttributes.ContentState.smiley
    MyHealthWidgetAttributes.ContentState.starEyes
}
