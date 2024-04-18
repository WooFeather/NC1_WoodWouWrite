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
    
    @State private var searchText = ""
    
    @Binding var isSerchable: Bool

    var filterJournals: [Journal] {
            if searchText.isEmpty {
                return journals
            } else {
                return journals.filter { $0.notes.localizedCaseInsensitiveContains(searchText) }
            }
        }

    
    var body: some View {
        if isSerchable {
            List {
                Section("4월") {
                    ForEach(filterJournals.sorted(by: { $0.date > $1.date }), id: \.self) { journal in
                        NavigationLink {
                            JournalDetailView(journal: journal)
                        } label: {
                            HStack() {
                                Text(journal.date.formattedDateSimpleDayKR())
                                    .frame(maxWidth: 40)
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
            }
            .searchable(text: $searchText, prompt: "일기 내용 검색")
        } else {
            List {
                Section("4월") {
                    ForEach(filterJournals.sorted(by: { $0.date > $1.date }), id: \.self) { journal in
                        NavigationLink {
                            JournalDetailView(journal: journal)
                        } label: {
                            HStack() {
                                Text(journal.date.formattedDateSimpleDayKR())
                                    .frame(maxWidth: 40)
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
            }
        }
    }
    
    func deleteJournals(_ indexSet: IndexSet) {
        for index in indexSet {
            let journal = journals[index]
            modelContext.delete(journal)
        }
    }
}

//#Preview {
//    ListView()
//}
