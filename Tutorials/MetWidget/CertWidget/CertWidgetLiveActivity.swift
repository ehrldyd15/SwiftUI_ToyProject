//
//  CertWidgetLiveActivity.swift
//  CertWidget
//
//  Created by Do Kiyong on 7/8/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct CertWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct CertWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CertWidgetAttributes.self) { context in
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

extension CertWidgetAttributes {
    fileprivate static var preview: CertWidgetAttributes {
        CertWidgetAttributes(name: "World")
    }
}

extension CertWidgetAttributes.ContentState {
    fileprivate static var smiley: CertWidgetAttributes.ContentState {
        CertWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: CertWidgetAttributes.ContentState {
         CertWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: CertWidgetAttributes.preview) {
   CertWidgetLiveActivity()
} contentStates: {
    CertWidgetAttributes.ContentState.smiley
    CertWidgetAttributes.ContentState.starEyes
}
