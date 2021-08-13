//
//  Date+Extension.swift
//  mood-recorder
//
//  Created by LanNTH on 07/08/2021.
//

import Foundation

extension Date {
    var year: Int {
        return Calendar.gregorian.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.gregorian.component(.month, from: self)
    }
    
    var day: Int {
        return Calendar.gregorian.component(.day, from: self)
    }
    
    var hour: Int {
        return Calendar.gregorian.component(.hour, from: self)
    }
    
    var minute: Int {
        return Calendar.gregorian.component(.minute, from: self)
    }
    
    var second: Int {
        return Calendar.gregorian.component(.second, from: self)
    }
    
    var previousYear: Date {
        return Calendar.gregorian.date(byAdding: .year, value: -1, to: self) ?? self
    }
    
    var nextYear: Date {
        return Calendar.gregorian.date(byAdding: .year, value: 1, to: self) ?? self
    }
    
    var previousMonth: Date {
        return Calendar.gregorian.date(byAdding: .month, value: -1, to: self) ?? self
    }
    
    var nextMonth: Date {
        return Calendar.gregorian.date(byAdding: .month, value: 1, to: self) ?? self
    }
    
    var noon: Date {
        return Calendar(identifier: .gregorian).date(bySettingHour: 12, minute: 0, second: 0, of: self) ?? self
    }
    
    var nanoSecondRemoved: Date {
        return Calendar.gregorian.date(bySettingHour: self.hour, minute: self.minute, second: self.second, of: self) ?? self
    }
    
    var yesterday: Date {
        return Calendar.gregorian.date(byAdding: .day, value: -1, to: self) ?? self
    }
    
    var tomorrow: Date {
        return Calendar.gregorian.date(byAdding: .day, value: 1, to: self) ?? self
    }
    
    var previousHour: Date {
        return Calendar.gregorian.date(byAdding: .hour, value: -1, to: self) ?? self
    }
    
    var nextHour: Date {
        return Calendar.gregorian.date(byAdding: .hour, value: 1, to: self) ?? self
    }
    
    var previousSecond: Date {
        return Calendar.gregorian.date(byAdding: .second, value: -1, to: self) ?? self
    }
    
    var startOfHour: Date {
        let components = Calendar.gregorian.dateComponents([.year, .month, .day, .hour], from: self)
        return Calendar.gregorian.date(from: components) ?? self
    }
    
    var startOfYear: Date {
        let components = Calendar.gregorian.dateComponents([.year], from: self)
        return Calendar.gregorian.date(from: components) ?? self
    }
    
    var endOfYear: Date {
        return startOfYear.nextYear.previousSecond
    }
    
    var startOfMonth: Date {
        let components = Calendar.gregorian.dateComponents([.year, .month], from: self)
        return Calendar.gregorian.date(from: components) ?? self
    }
    
    var endOfMonth: Date {
        return startOfMonth.nextMonth.previousSecond
    }
    
    var startOfDay: Date {
        let components = Calendar.gregorian.dateComponents([.year, .month, .day], from: self)
        return Calendar.gregorian.date(from: components) ?? self
    }
    
    var endOfDay: Date {
        return startOfDay.tomorrow.previousSecond
    }
    
    var isLastDayOfMonth: Bool {
        return tomorrow.month != self.month
    }
    
    var weekday: Int {
        /* 1: Sun, 2: Mon, 3: Tue, 4: Wed, 5: Thu, 6: Fri, 7: Sat */
        return Calendar.gregorian.component(.weekday, from: self)
    }
    
    var isSunday: Bool {
        return Calendar.gregorian.component(.weekday, from: self) == 1
    }
    
    var isSaturday: Bool {
        return Calendar.gregorian.component(.weekday, from: self) == 7
    }
    
    var nextWeek: Date {
        return Calendar.gregorian.date(byAdding: .day, value: 7, to: self) ?? self
    }
    
    var startOfWeek: Date {
        let components = Calendar.gregorian.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        return Calendar.gregorian.date(from: components) ?? self
    }
    
    var endOfWeek: Date {
        return startOfWeek.nextWeek.previousSecond
    }
    
    var numberOfDaysInMonth: Int {
        return Calendar.gregorian.range(of: .day, in: .month, for: self)?.count ?? 0
    }
    
    var firstDayOfThisYear: Date {
        let components = Calendar(identifier: .gregorian).dateComponents([.year], from: self)
        return Calendar(identifier: .gregorian).date(from: components) ?? Date()
    }
    
    var lastDayOfThisYear: Date {
        return self.firstDayOfThisYear.nextYear.yesterday
    }
    
    var hourString: String {
        let formatter = DateFormatter(dateFormat: "HH:mm")
        return formatter.string(from: self)
    }
    
    func isEqualMonthInYear(with date: Date) -> Bool {
        return self.year == date.year && self.month == date.month
    }
    
    func isInSameDay(as date: Date) -> Bool {
        return Calendar.gregorian.isDate(self, inSameDayAs: date)
    }
    
    func isInSameMonth(as date: Date) -> Bool {
        return self.month == date.month
    }
    
    func subtract(days: Int) -> Date {
        return Calendar.gregorian.date(byAdding: .day, value: -days, to: self) ?? self
    }
    
    func add(days: Int) -> Date {
        return Calendar.gregorian.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    func add(weeks: Int) -> Date {
        return Calendar.gregorian.date(byAdding: .weekOfYear, value: weeks, to: self) ?? self
    }
    
    func add(minutes: Int) -> Date {
        return Calendar.gregorian.date(byAdding: .minute, value: minutes, to: self) ?? self
    }
    
    func addHour(_ value: Int) -> Date {
        return self.addingTimeInterval(Double(value) * 60 * 60)
    }
    
    func setTime(hour: Int, minutes: Int) -> Date? {
        return Calendar.gregorian.date(bySettingHour: hour, minute: minutes, second: 0, of: self)
    }
        
    var monthYearString: String {
        let formatter = DateFormatter(dateFormat: "MMMM/y")
        // formatter.locale = Locale(identifier: Strings.localeIdentifier)
        return formatter.string(from: self)
    }
    
    var dayMonthYearHourMinuteString: String {
        let formatter = DateFormatter(dateFormat: "d/M/y HH:mm")
        // formatter.locale = Locale(identifier: Strings.localeIdentifier)
        return formatter.string(from: self)
    }
    
    var dayMonthYearDayOfWeekString: String {
        let formatter = DateFormatter(dateFormat: "d/M/y (EEEE)")
        // formatter.locale = Locale(identifier: Strings.localeIdentifier)
        return formatter.string(from: self)
    }
    
    var dayMonthYearString: String {
        let formatter = DateFormatter(dateFormat: "d MMMM y")
        // formatter.locale = Locale(identifier: Strings.localeIdentifier)
        return formatter.string(from: self)
    }
    
    var startOfDayInterval: Double {
        return self.startOfDay.timeIntervalSince1970
    }
}

extension Date {
    static func countBetweenDate(component: Calendar.Component, start: Date, end: Date) -> Int {
        let components = Calendar.gregorian.dateComponents([component], from: start, to: end)
        return components.value(for: component) ?? 0
    }
    
    func getAllDateInMonth() -> [Date] {
        var dates: [Date] = []
        
        let startDate = self.startOfMonth
        let endDate = self.endOfMonth
        
        // Get all date in month
        var date = startDate
        while date <= endDate {
            dates.append(date)
            date = date.tomorrow
        }
        // Get all date show in last month
        let startDayOfWeek = 1
        guard let weekDayOfFirstDay = dates.first?.weekday else { return dates }
        let numberDatesInsert = startDayOfWeek <= weekDayOfFirstDay ? weekDayOfFirstDay - startDayOfWeek : 7 - startDayOfWeek + weekDayOfFirstDay
        for _ in 0..<numberDatesInsert {
            if let firstDate = dates.first {
                dates.insert(firstDate.yesterday, at: 0)
            }
        }
        // Get all date show in next month
        while dates.count % 7 != 0 {
            if let lastDate = dates.last {
                dates.append(lastDate.tomorrow)
            }
        }
        return dates
    }
}
