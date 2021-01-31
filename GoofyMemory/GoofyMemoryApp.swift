//
//  GoofyMemoryApp.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 30/12/2020.
//

import SwiftUI

@main
struct GoofyMemoryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: GameFactory.createMemoryGame())
        }
    }
}
