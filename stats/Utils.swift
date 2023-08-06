import Foundation
import UserNotifications
import UserNotificationsUI


typealias hoursMinutes = (hours: Int , minutes: Int);

func minutesToHoursAndMinutes(_ minutes: Int) -> hoursMinutes {
    return (minutes / 60, (minutes % 60))
}

func notification(_ title: String, _ subtitle: String) -> Void {
    let content = UNMutableNotificationContent()
    content.title = title;
    content.subtitle = subtitle;
    content.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)
}
