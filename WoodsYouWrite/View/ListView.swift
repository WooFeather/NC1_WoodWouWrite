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
            ForEach(journals) { journal in
                NavigationLink(value: journal) {
                    VStack(alignment: .leading) {
                        Text(journal.notes.count > 20 ? "\(journal.notes.prefix(20))..." : journal.notes)
                            .font(.headline)
                        
                        Text(journal.date.formatted(date: .numeric, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteJournals)
        }
        .navigationTitle("모아보기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Journal.self, destination: EditJournalView.init)
        .toolbar {
            Button("Add Journal", systemImage: "plus", action: addJournal)
            
        }
    }
    
    func addJournal() {
        //        let journal = Journal(date: Date(), notes: "gdgdgd")
        //        modelContext.insert(journal)
        //        path = [journal]
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
