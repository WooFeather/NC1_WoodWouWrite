//
//  JournalDetailView.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/17/24.
//

import SwiftUI

struct JournalDetailView: View {
    @Bindable var journal: Journal
    
    var body: some View {
        VStack {
            Text("\(journal.date.formattedDateMonthDay())")
            Text("\(journal.notes)")
        }
    }
}

//#Preview {
//    JournalDetailView()
//}
