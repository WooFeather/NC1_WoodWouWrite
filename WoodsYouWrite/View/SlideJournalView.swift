//
//  SlideJournalView.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/18/24.
//

//import SwiftData
//import SwiftUI
//
//struct SlideJournalView: View {
//    @Query var journals: [Journal]
//    @State private var index = 0
//    
//    var body: some View {
//        VStack {
//            TabView(selection: $index) {
//                ForEach(Array(journals.sorted(by: { $0.date < $1.date }).enumerated()), id: \.element) { (index, journal) in
//                    Text("\(journal.notes)")
//                        .frame(width: 300, height: 500)
//                        .background(.red)
//                        .tag(index)
//                }
//            }
//            .tabViewStyle(.page)
//            .onAppear {
//                Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
//                    index = (index + 1) % journals.count
//                }
//            }
//        }
//    }
//}

import SwiftData
import SwiftUI

struct SlideJournalView: View {
    @Query var journals: [Journal]
    @State private var index = 0
    
    var sortedJournals: [Journal] {
        journals.sorted(by: { $0.date < $1.date })
    }
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(Array(sortedJournals.enumerated()), id: \.element) { (idx, journal) in
                    if idx == index {
                        VStack(alignment: .leading) {
                            
                            HStack {
                                Text("\(journal.date.formattedDateYearMonthDayWeekDay())")
                                    .font(.title.bold())
                                
                                Spacer()
                            }
                            
                            Spacer()
                            
                            Text("\(journal.notes)")
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .transition(.opacity)
                        .tag(idx)
                    }
                }
            }
            .animation(.easeInOut(duration: 1.0), value: index)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                    withAnimation {
                        index = (index + 1) % journals.count
                    }
                }
            }
        }
    }
}


#Preview {
    SlideJournalView()
}
