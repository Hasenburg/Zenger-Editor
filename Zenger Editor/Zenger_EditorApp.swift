//
//  Zenger_EditorApp.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 09.02.23.
//

import SwiftUI
import Firebase
import FirebaseAppCheck

@main
struct Zenger_EditorApp: App {
	
	class MyAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
		func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
			return AppAttestProvider(app: app)
		}
	}
	
	init() {
		let providerFactory = MyAppCheckProviderFactory()
		AppCheck.setAppCheckProviderFactory(providerFactory)
		FirebaseApp.configure()
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}
