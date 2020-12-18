//
//  ExtensionUIDatePicker.swift
//  F49
//
//  Created by Le Dat on 11/12/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit

extension UIDatePicker{
    

    
    func dateFormatte(txt: UITextField){
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = .none
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MM/yyyy"
        
        txt.text = formatter.string(from: self.date)
    }
    
    func formatter1(picker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.string(from: picker.date)
    }
    
    func createDatePicker(tf: UITextField) -> UIDatePicker{
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        tf.inputView = datePicker
        return datePicker
    }
}


enum DateFormatConstant : String {
    case DayMonthYear = "dd/MM/yyyy"
    case HourMinSec = "HH:mm:ss"
    case HourMin = "HH:mm"
    case YearMonthDay = "yyyy-MM-dd"
    case WeekDayMonthYear = "EEEE, dd/MM/yyyy"
    case WeekDayMonthYearHourMinute = "EEEE, dd/MM/yyyy HH:mm"
    case DayMonthYearHourMinute = "dd/MM/yyyy HH:mm"
    case YearMonthDayHourMinuteSecond = "yyyy-MM-ddTHH:mm:ssZ"
    case YearMonthDayHour = "yyyy-MM-dd-hh"
    case CalendarDisplayDate = "EEEE 'ngày' d MMMM 'năm' yyyy"
}

extension DateFormatter {
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        formatter.timeZone = TimeZone(identifier: "UTC")!
        return formatter
    }()
    
    
    public class func shortMonthFormater() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter
    }
    
    public class func postParamFormater() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    public class func sessionTimeFormater() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    public class func monthNameDateFormater() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }
    
    public class func dayDateFormater() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }
}

extension Date {
    // usage:
    public func toString() -> String {
        return DateFormatter.dateFormatter.string(from: self)
    }
    
    public func postParam() -> String {
        return DateFormatter.postParamFormater().string(from: self)
    }
    
    public func dateTimeParam() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: self)
    }
    
    public func toTimeDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd/MM/yyyy"
        return formatter.string(from: self)
    }
    
    public func toDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: self)
    }
    
    public func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    public func toTimeHHmm() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    public func toDayMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
    
    public func timeAgoSinceDate(numericDates:Bool = false) -> String {
        let calendar = NSCalendar.current
        let date = self
        let unitFlags: Set<Calendar.Component> = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        //        let gregorian = Calendar(identifier: .gregorian)
        //        var componentsDate = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 30) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
    public func reviewTimeAgoSinceDate() -> String {
        let calendar = NSCalendar.current
        let date = self
        let unitFlags: Set<Calendar.Component> = [.second, .minute, .hour, .day]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.day! > 7){
            return self.toString(format: "dd/MM/yyy hh:mm:ss")
        } else if (components.day! >= 1){
            return "\(components.day!) ngày trước"
        } else if (components.hour! >= 2) {
            return "\(components.hour!) giờ trước"
        } else if (components.hour! >= 1){
            return "1 giờ trước"
        } else if (components.minute! >= 2) {
            return "\(components.minute!) phút trước"
        } else if (components.minute! >= 1){
            return "1 phút trước"
        } else if (components.second! >= 30) {
            return "\(components.second!) giây trước"
        } else {
            return "vừa mới"
        }
        
    }
    
    func isEqualDate(_ comparisonDate: Date) -> Bool {
      let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
      return order == .orderedSame
    }

    func isBeforeDate(_ comparisonDate: Date) -> Bool {
      let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
      return order == .orderedAscending
    }

    func isAfterDate(_ comparisonDate: Date) -> Bool {
      let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
      return order == .orderedDescending
    }
    
    func isEqualOrBeforeDate(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedAscending || order == .orderedSame
    }
    
    func isEqualOrAfterDate(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedDescending || order == .orderedSame
    }
    
    func addDays(_ daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(_ hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
    
    func addComponent(hours: Int, minutes: Int) -> Date? {
        let secondsInHours: TimeInterval = Double(hours) * 60 * 60 + Double(minutes) * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
    
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self).rawValue * self.compare(date2).rawValue >= 0
    }
    
    static func toDayString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatConstant.DayMonthYear.rawValue
        return formatter.string(from: date)
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "vi_VN")
        
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }

    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
    
    var nextMonth: Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self) ?? Date()
    }

    var previousMonth: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self) ?? Date()
    }
    
    static func tomorrowOf(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatConstant.DayMonthYear.rawValue
        let myDate = dateFormatter.date(from: date)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        let tomorrowString = dateFormatter.string(from: tomorrow!)
        return tomorrowString
    }
    
    static func yesterdayOf(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatConstant.DayMonthYear.rawValue
        let myDate = dateFormatter.date(from: date)!
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: myDate)
        let yesterdayString = dateFormatter.string(from: yesterday!)
        return yesterdayString
    }
    
    static func currentYear() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return components.year ?? 2000
    }
    
    static func currentMonth() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return components.month ?? 1
    }
    
    static func nextMonth() -> Int {
        let currentMonth = Date.currentMonth()
        if currentMonth == 12 {
            return 1
        }
        return currentMonth + 1
    }
    
    static func currentDate() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return components.day ?? 1
    }
    
    static func currentMonth(fromDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: fromDate)
        return components.month ?? 1
    }
    
    static func currentDate(fromDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: fromDate)
        return components.day ?? 1
    }
    
    func currentWeek() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekOfYear], from: self)
        return components.weekOfYear ?? 1
    }
    
    func currentYear() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return components.year ?? 1
    }
    
    public func setTime(hour: Int, min: Int, sec: Int = 0) -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)
        components.hour = hour
        components.minute = min
        components.second = sec

        return cal.date(from: components)
    }
    
}

extension String {
    public func toDate() -> Date? {
        if self.count > 19 {
            return DateFormatter.dateFormatter.date(from: String(self.prefix(19)))
        } else {
            return DateFormatter.dateFormatter.date(from: self)
        }
    }
    func toDate(fromFormat format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "vi_VN")
        if self.count > format.count {
            return formatter.date(from: String(self.prefix(format.count)))
        } else {
            return formatter.date(from: self)
        }
    }
}
