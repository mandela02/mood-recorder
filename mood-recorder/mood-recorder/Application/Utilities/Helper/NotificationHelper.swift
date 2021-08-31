//
//  NotificationHelper.swift
//  NotificationHelper
//
//  Created by TriBQ on 8/27/21.
//

import Foundation
import NotificationCenter

// TODO: - TEST THIS METHOD
struct NotificationHelper {
    static let share = NotificationHelper()
    
    private init() {}
    
    func requestPermission() {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                requestNotification()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func requestNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Title"
        notificationContent.body = "This is a test"
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.sound = .default
        
        var datComp = DateComponents()
        datComp.hour = 8
        datComp.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
        let request = UNNotificationRequest(identifier: "ID",
                                            content: notificationContent,
                                            trigger: trigger)
        
        UNUserNotificationCenter
            .current()
            .add(request) { error in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
