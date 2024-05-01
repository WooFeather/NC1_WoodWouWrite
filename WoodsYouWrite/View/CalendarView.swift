//
//  CalendarView.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/12/24.
//

import SwiftData
import SwiftUI

struct CalendarView: View {
    @State private var month: Date = Date()
    @Binding var clickedCurrentMonthDates: Date
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
        }
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                yearMonthView
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 5)
            
            HStack {
                ForEach(Self.weekdaySymbols.indices, id: \.self) { symbol in
                    Text(Self.weekdaySymbols[symbol].uppercased())
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 5)
        }
    }
    
    // MARK: - 연월 표시
    private var yearMonthView: some View {
        HStack(alignment: .center, spacing: 20) {
            Button(
                action: {
                    changeMonth(by: -1)
                },
                label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(canMoveToPreviousMonth() ? .black : . gray)
                }
            )
            .disabled(!canMoveToPreviousMonth())
            
            Text(month, formatter: Self.calendarHeaderDateFormatter)
                .font(.title.bold())
            
            Button(
                action: {
                    changeMonth(by: 1)
                },
                label: {
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(canMoveToNextMonth() ? .black : .gray)
                }
            )
            .disabled(!canMoveToNextMonth())
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        let lastDayOfMonthBefore = numberOfDays(in: previousMonth())
        let numberOfRows = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        let visibleDaysOfNextMonth = numberOfRows * 7 - (daysInMonth + firstWeekday)
        
        //        let dateManager = DateManager.shared
        
        var selectedDate: Date = Date()
        
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(-firstWeekday ..< daysInMonth + visibleDaysOfNextMonth, id: \.self) { index in
                Group {
                    if index > -1 && index < daysInMonth {
                        let date = getDate(for: index)
                        let day = Calendar.current.component(.day, from: date)
                        let clicked = clickedCurrentMonthDates == date
                        let isToday = date.formattedCalendarDayDate == today.formattedCalendarDayDate
                        
//                        CellView(day: day, clicked: clicked, isToday: isToday)
                        CellView(date: date, clicked: clicked, isToday: isToday)
                    } else if let prevMonthDate = Calendar.current.date(
                        byAdding: .day,
                        value: index + lastDayOfMonthBefore,
                        to: previousMonth()
                    ) {
                        let day = Calendar.current.component(.day, from: prevMonthDate)
                        
                        CellView(date: prevMonthDate, isCurrentMonthDay: false)
                    }
                }
                .onTapGesture {
                    if 0 <= index && index < daysInMonth {
                        let date = getDate(for: index)
                        clickedCurrentMonthDates = date
                        print("캘린더: \(clickedCurrentMonthDates.formattedDateYearMonthDay())")
                        selectedDate = date
                    }
                }
            }
        }
    }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
    @Query var journals: [Journal]
    // date는 위의 날짜그리드뷰에서 가져온 것이기 때문에 private붙이면 안됨
    var date: Date
    private var day: Int {
        let day = Calendar.current.component(.day, from: date)
        return day
    }
    private var month: Int {
        let month = Calendar.current.component(.month, from: date)
        return month
    }
    private var clicked: Bool
    private var isToday: Bool
    private var isCurrentMonthDay: Bool
    private var textColor: Color {
        if clicked {
            return Color.white
        } else if isCurrentMonthDay {
            return Color.black
        } else {
            return Color.gray
        }
    }
    private var backgroundColor: Color {
        if clicked {
            return Color.black
        } else if isToday {
            return Color.gray
        } else {
            return Color.white
        }
    }
    
    fileprivate init(
        date: Date,
        clicked: Bool = false,
        isToday: Bool = false,
        isCurrentMonthDay: Bool = true
    ) {
        self.date = date
        self.clicked = clicked
        self.isToday = isToday
        self.isCurrentMonthDay = isCurrentMonthDay
    }
    
    fileprivate var body: some View {
        VStack {
            Circle()
                .fill(backgroundColor)
                .overlay(Text(String(day)))
                .foregroundColor(textColor)
            
            Spacer()
            
            if isJournalExist(date: date) {
                Text("🪵")
                    .font(.footnote)
            } else {
                Spacer()
                    .frame(height: 15)
            }
        }
        .frame(height: 50)
    }
    
    func isJournalExist(date: Date) -> Bool {
        let filtered = journals.filter { journal in
            journal.date.formattedDateYearMonthDay() == date.formattedDateYearMonthDay()
        }
        return !filtered.isEmpty
    }
}

// MARK: - 프로퍼티 모음
private extension CalendarView {
    var today: Date {
        let now = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: now)
        return Calendar.current.date(from: components)!
    }
    
    static let calendarHeaderDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM"
        return formatter
    }()
    
    static let weekdaySymbols: [String] = Calendar.current.shortWeekdaySymbols
}

//MARK: - 내부 로직 메서드
private extension CalendarView {
    /// 특정 해당 날짜
    func getDate(for index: Int) -> Date {
        let calendar = Calendar.current
        guard let firstDayOfMonth = calendar.date(
            from: DateComponents(
                year: calendar.component(.year, from: month),
                month: calendar.component(.month, from: month),
                day: 1
            )
        ) else {
            return Date()
        }
        
        var dateComponents = DateComponents()
        dateComponents.day = index
        
        let timeZone = TimeZone.current
        let offset = Double(timeZone.secondsFromGMT(for: firstDayOfMonth))
        dateComponents.second = Int(offset)
        
        let date = calendar.date(byAdding: dateComponents, to: firstDayOfMonth) ?? Date()
        return date
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 이전 월 마지막 일자
    func previousMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
        
        return previousMonth
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        self.month = adjustedMonth(by: value)
    }
    
    /// 이전 월로 이동 가능한지 확인
    func canMoveToPreviousMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: -3, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: -1) < targetDate {
            return false
        }
        return true
    }
    
    /// 다음 월로 이동 가능한지 확인
    func canMoveToNextMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: 3, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: 1) > targetDate {
            return false
        }
        return true
    }
    
    /// 변경하려는 월 반환
    func adjustedMonth(by value: Int) -> Date {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: month) {
            return newMonth
        }
        return month
    }
}

// MARK: - Data extension
extension Date {
    static let calendarDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy dd"
        return formatter
    }()
    
    var formattedCalendarDayDate: String {
        return Date.calendarDayDateFormatter.string(from: self)
    }
}


