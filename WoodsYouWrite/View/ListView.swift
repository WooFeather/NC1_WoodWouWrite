//
//  ListView.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/16/24.
//

import SwiftData
import SwiftUI

struct ListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var journals: [Journal]
    
    var body: some View {
        List {
            ForEach(journals.sorted(by: { $0.date > $1.date }), id: \.self) { journal in
                NavigationLink {
                    JournalDetailView(journal: journal)
                } label: {
                    HStack() {
                        Text(journal.date.formattedDay())
                            .frame(maxWidth: 40)
                            .font(.title)
                            .bold()
                        
                        Divider()
                            .padding(.vertical)
                        
                        Text(journal.notes.count > 40 ? "\(journal.notes.prefix(40))..." : journal.notes)
                            .font(.callout)
                    }
                }
            }
            .onDelete(perform: deleteJournals)
            .frame(maxHeight: 50)
        }
        .navigationTitle("모아보기")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func deleteJournals(_ indexSet: IndexSet) {
        for index in indexSet {
            let journal = journals[index]
            modelContext.delete(journal)
        }
    }
}

#Preview {
    ListView()
}
