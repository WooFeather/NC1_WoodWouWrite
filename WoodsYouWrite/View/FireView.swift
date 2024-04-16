//
//  FireView.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/11/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct FireView: View {
    var body: some View {
        ZStack {
            Image("wood")
                .resizable()
                .scaledToFit()
                .frame(width: 350)
                .offset(y: 40)
            AnimatedImage(name: "fire-flame.gif")
                .resizable()
                .scaledToFit()
                .opacity(0.95)
        }
    }
}

#Preview {
    FireView()
}
