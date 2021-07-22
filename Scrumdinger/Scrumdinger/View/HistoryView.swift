//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by Yusuf Kildan on 22.07.2021.
//

import SwiftUI

struct HistoryView: View {
    
    let history: History
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendees.joined(separator: ", "))
                if let transcript = history.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(history: History(attendees: [], lengthInMinutes: 0, transcript: nil))
    }
}
