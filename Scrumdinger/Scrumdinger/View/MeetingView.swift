//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Yusuf Kildan on 6.06.2021.
//

import AVFoundation
import SwiftUI

/*
 Use @State to create a source of truth for value type models.
 Use @StateObject to create a source of truth for reference type models that conform to the ObservableObject protocol.
 */

struct MeetingView: View {
    
    // MARK: - Properties
    
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    @State private var transcript = ""
    private let speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.color)
            VStack {
                MeetingHeaderView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsRemaining: scrumTimer.secondsRemaining,
                    scrumColor: scrum.color
                )
                MeetingTimerView(speakers: scrumTimer.speakers, scrumColor: scrum.color, isRecording: isRecording)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
            .padding()
        }
        .padding()
        .foregroundColor(scrum.color.accessibleFontColor)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            isRecording = true
            speechRecognizer.record(to: $transcript)
            scrumTimer.startScrum()
        }
        .onDisappear {
            scrumTimer.stopScrum()
            let newHistory = History(
                attendees: scrum.attendees,
                lengthInMinutes: scrumTimer.secondsElapsed / 60,
                transcript: transcript
            )
            isRecording = false
            speechRecognizer.stopRecording()
            scrum.history.insert(newHistory, at: 0)
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.data[0]))
    }
}
