//
//  Zenger_EditorApp.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 09.02.23.
//

import SwiftUI
import Firebase

@main
struct Zenger_EditorApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
