//
//  CodeViewModel.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 24.02.24.
//

import SwiftUI

final class TimerViewModel: ObservableObject {
    @Published var timerStringValue: String = "00:00"
    @Published var isStarted: Bool = false
    
    @Published var hour: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 59
    
    @Published var totalSeconds: Int = 0
    @Published var staticTotalSeconds: Int = 0
    
    private func setStringValue(h: Int, m: Int, s: Int) -> String {
        "\(h == 0 ? "":"\(h):")\(m >= 10 ? "\(m)":"0\(m)"):\(s >= 10 ? "\(s)":"0\(s)")"
    }
    
    func startTimer() {
        withAnimation(.easeInOut(duration: 0.25)){ isStarted = true }
        timerStringValue = setStringValue(h: hour, m: minutes, s: seconds)
        
        totalSeconds = (hour * 3600) + (minutes * 60) + seconds
        staticTotalSeconds = totalSeconds
    }
    
    func stopTimer() {
        withAnimation {
            isStarted = false
            hour = 0
            minutes = 0
            seconds = 0
        }
        totalSeconds = 0
        staticTotalSeconds = 0
        timerStringValue = "00:00"
    }
    
    func updateTimer() {
        totalSeconds -= 1
        hour = totalSeconds / 3600
        minutes = (totalSeconds / 60 ) % 60
        seconds = (totalSeconds % 60 )
        
        timerStringValue = setStringValue(h: hour, m: minutes, s: seconds)
        
        if hour == 0 && minutes == 0 && seconds == 0 {
            stopTimer()
        }
    }
}
