import SwiftUI

@main
struct FoodBirdApp: App {
    @StateObject private var appState = AppState()
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(appState)
                .environment(\.layoutDirection, appState.isArabic ? .rightToLeft : .leftToRight)
                .environment(\.locale, .init(identifier: appState.isArabic ? "ar" : "en"))
        }
    }
}

final class AppState: ObservableObject {
    @Published var isArabic: Bool = Locale.current.languageCode == "ar"
}
