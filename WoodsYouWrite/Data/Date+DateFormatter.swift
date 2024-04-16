//
//  Date+DateFormatter.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/16/24.
//

import SwiftUI

extension Date {
    func formattedDateYearMonthDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
    
    func formattedDateMonthDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM"
        return dateFormatter.string(from: self)
    }
    
    func formattedDayKR() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self) + "일"
    }
}
