import SwiftUI

@main
struct ThreeOneOSFiveApp: App {
    @AppStorage("isKeyUnlocked") private var isKeyUnlocked = false
    
    var body: some Scene {
        WindowGroup {
            if isKeyUnlocked {
                ContentView()
            } else {
                KeyVerificationView(isUnlocked: $isKeyUnlocked)
            }
        }
    }
}