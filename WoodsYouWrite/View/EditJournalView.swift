//
//  EditJournalView.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/16/24.
//

import SwiftData
import SwiftUI

struct EditJournalView: View {
    @Bindable var journal: Journal
    
    var body: some View {
        Form {
            Section("날짜선택") {
                DatePicker("Date", selection: $journal.date)
            }
            
            Section("일기") {
                TextField("일기를 작성하세요",text: $journal.notes, axis: .vertical)
            }
        }
        .navigationTitle("오늘의 일기")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Journal.self, configurations: config)
//        let example = Journal(date: Date(), notes: "안녕하세요 선생님 안녕 친구야 인사하는 어린이 착한 어린이")
//        return EditJournalView(journal: example)
//            .modelContainer(container)
//    } catch {
//        fatalError("Falied to creat model container.")
//    }
//}
