//
//  DetailView.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/16/24.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack {
            Text("작성된 일기가 없습니다.")
                .font(.title2)
            Text("(탭하여 작성하기)")
        }
        
    }
}

#Preview {
    DetailView()
}
