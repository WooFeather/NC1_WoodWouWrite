//
//  Journal.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/16/24.
//

import Foundation
import SwiftData

@Model
class Journal {
    var date: Date
    var dateString: String
    var notes: String
    
    init(date: Date, dateString: String, notes: String) {
        self.date = date
        self.dateString = dateString
        self.notes = notes
    }
}
