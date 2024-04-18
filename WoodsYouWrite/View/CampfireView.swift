//
//  CampfireView.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/18/24.
//

import SwiftUI

struct CampfireView: View {
    var body: some View {
        VStack {
            Spacer()
            
            SlideJournalView()
                .padding(.horizontal)
            
            Spacer()
            
            FireView()
        }
    }
}

#Preview {
    CampfireView()
}
