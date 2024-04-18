//
//  FirewoodView.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/18/24.
//

import SwiftData
import SwiftUI

struct FirewoodView: View {
    
    @Query var journals: [Journal]
    
    @State var isSerchable: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("모은 장작 개수")
                            .font(.title2)
                            .bold()
                        Text("\(journals.count)개 🪵")
                            .font(.largeTitle)
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        VStack {
                            Text("🔥")
                                .font(.largeTitle)
                        }
                        .allowsTightening(false)
                        .padding(30)
                        .background {
                            NavigationLink(destination: CampfireView()) {
                                Circle()
                                    .frame(width: 80)
                                    .foregroundStyle(.black)
                                    .opacity(0.9)
                                    .shadow(radius: 10, y: 10)
                            }
                        }
                        Text("돌아보기")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                
                Spacer()
                
                ListView(isSerchable: $isSerchable)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isSerchable.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    FirewoodView()
}
