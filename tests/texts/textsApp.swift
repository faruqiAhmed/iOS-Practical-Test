//
//  textsApp.swift
//  texts
//
//  Created by Md Omar Faruq on 7/7/21.
//

import SwiftUI

@main
struct textsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: QuranListViewModel())
        }
    }
}
