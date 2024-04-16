//
//  ContentView.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/11/24.
//

import SwiftData
import SwiftUI


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var journals: [Journal]
    
    @State var numOfJournal: Int
    
    @State var selectedDate: Date = Date()
    
    // @State var showJournal: Journal = .init()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("모은 장작 개수")
                            .font(.title2)
                            .bold()
                        Text("\(numOfJournal)개")
                            .font(.largeTitle)
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        VStack {
                            Text("🪵🪵")
                            Text("🪵")
                        }
                        .allowsTightening(false)
                        .padding(30)
                        .background {
                            NavigationLink(destination: ListView()) {
                                Circle()
                                    .frame(width: 80)
                                    .foregroundStyle(.black)
                                    .opacity(0.9)
                                    .shadow(radius: 10, y: 10)
                            }
                        }
                        Text("모아보기")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                
                Divider()
                    .padding(.horizontal)
                
                CalendarView(clickedCurrentMonthDates: $selectedDate)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(destination: WriteView(currentJournal: queryJournal(date: selectedDate))) {
                    if isJournalExist(date: selectedDate) {
                        VStack(alignment: .leading) {
                            Text("\(queryJournal(date: selectedDate).date.formattedDayKR())")
                                .font(.title2.bold())
                                .frame(alignment: .topLeading)
                            Text("\(queryJournal(date: selectedDate).notes)")
                        }
                            .foregroundStyle(.black)
                    } else {
                        DetailView()
                            .foregroundStyle(.gray)
                    }
                }
                
                
                Spacer()
            }
            //            .onChange(of: selectedDate, { oldValue, newValue in
            //                showJournal = queryJournal(date: selectedDate))
            //            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // settingView로 이동
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundStyle(.black)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        // search action
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
    
    func queryJournal(date: Date) -> Journal {
        
        let dateString = date.formattedDateYearMonthDay()
        
        let predicate = #Predicate<Journal> {
            $0.dateString == dateString
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        do {
            let array = try modelContext.fetch(descriptor)
            return array.first ?? Journal(date: selectedDate, dateString: "", notes: "")
        } catch {
            fatalError("얌마")
        }
    }
    
    func isJournalExist(date: Date) -> Bool {
        let filtered = journals.filter { journal in
            journal.date.formattedDateYearMonthDay() == date.formattedDateYearMonthDay()
        }
        return !filtered.isEmpty
    }
    
    func dateOfJournal(from date: Date) -> Journal? {
        let filtered = journals.filter { journal in
            journal.date.formattedDateYearMonthDay() == date.formattedCalendarDayDate
        }
        print(journals)
        return filtered.first
    }
}

//#Preview {
//    ContentView(numOfJournal: 8)
//}

