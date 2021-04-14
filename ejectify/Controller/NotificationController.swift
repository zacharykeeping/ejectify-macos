//
//  EjectController.swift
//  Ejectify
//
//  Created by Zachary Keeping on 14/4/21.
//

import AppKit
import UserNotifications

class NotificationController {
    @objc static func displayAllEjectedNotification() {
        let title = "Disks ejected".localized
        let subTitle = "All external disks have been ejected successfully".localized
        let notificationDelay = 5
        let identifier = UUID().uuidString
        
        if #available(OSX 10.14, *) {
            let notificationCenter = UNUserNotificationCenter.current()

            let notification = UNMutableNotificationContent()
            notification.title = title
            notification.body = subTitle
            notification.sound = UNNotificationSound.default
            

            let request = UNNotificationRequest(identifier: identifier, content: notification, trigger: nil)
            notificationCenter.add(request)
            notificationCenter.perform(#selector(UNUserNotificationCenter.removeDeliveredNotifications(withIdentifiers:)), with: [identifier], afterDelay: TimeInterval(notificationDelay))
        } else {
            // Fallback on earlier versions
            let notification = NSUserNotification()
            notification.identifier = identifier
            notification.title = title
            notification.subtitle = subTitle
            notification.soundName = NSUserNotificationDefaultSoundName
            
            let notificationCenter = NSUserNotificationCenter.default
            notificationCenter.deliver(notification)
            notificationCenter.perform(#selector(notificationCenter.removeAllDeliveredNotifications), with: notification, afterDelay: TimeInterval(notificationDelay))
        }
        
    }
}
