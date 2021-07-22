//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Yusuf Kildan on 6.06.2021.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        ProgressView(value: 5, total: 15)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
