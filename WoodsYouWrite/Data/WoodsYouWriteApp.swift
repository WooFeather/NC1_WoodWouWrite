//
//  WoodsYouWriteApp.swift
//  WoodsYouWrite
//
//  Created by 조우현 on 4/11/24.
//

import SwiftData
import SwiftUI

@main
struct WoodsYouWriteApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Journal.self)
    }
}
