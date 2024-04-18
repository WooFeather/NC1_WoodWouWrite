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
            HStack {
                VStack(alignment: .leading) {
                    Text("\(journal.date.formattedDateYear())")
                    
                    Text("\(journal.date.formattedDateMonthDay())")
                        .font(.largeTitle.bold())
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView {
                Spacer()
                
                LazyVStack(alignment: .leading) {
                    Text("\(journal.notes)")
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                Spacer()
            }
        }
    }
}

//#Preview {
//    JournalDetailView(journal: journal)
//}
