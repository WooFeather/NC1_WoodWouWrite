//
//  WriteView.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/13/24.
//

import SwiftUI

struct WriteView: View {
    var currentJournal: Journal?
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) var modelContext
    
    @State var texttext = ""
    
    // 작성된 텍스트가 있는지 확인하는 프로퍼티
    var hasValidText: Bool {
        let trimmedtext = texttext.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedtext.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        if let journal = currentJournal {
            VStack {
                ZStack {
                    TextEditor(text: $texttext)
                    
                    if hasValidText == false {
                        VStack {
                            Text("작성된 일기가 없습니다.")
                                .font(.title3)
                            Text("(탭하여 작성하기)")
                                .font(.callout)
                        }
                        .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
            .navigationTitle(journal.date.formattedDateYearMonthDayWeekDay())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        let newJournal = Journal(date: journal.date, dateString: journal.date.formattedDateYearMonthDay(), notes: texttext)
                        modelContext.delete(journal)
                        modelContext.insert(newJournal)
                        try? modelContext.save()
                        
                        dismiss()
                    } label: {
                        if hasValidText == true {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.green)
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.gray)
                        }
                    }
                    .disabled(hasValidText == false)
                }
            }
            .onAppear {
                texttext = currentJournal?.notes ?? ""
            }
            .navigationBarBackButtonHidden()
            .alert("일기를 삭제하시겠습니까?", isPresented: $showAlert) {
                Button("삭제", role: .destructive) {
                    
                    modelContext.delete(journal)
                    try? modelContext.save()
                    
                    dismiss()
                }
                .disabled(hasValidText == false)
                
                Button("취소", role: .cancel) { }
                Button("삭제하지 않고 나가기", role: .none) {
                    dismiss()
                }
            }
        } else {
            Text("값없음")
        }
    }
}
