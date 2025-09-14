import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appState: AppState
    @State private var animate = false
    @State private var goHome = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.orange.opacity(0.2), Color.pink.opacity(0.2)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Image("foodbird_logo")
                    .resizable().scaledToFit()
                    .frame(width: 160, height: 160)
                    .rotationEffect(.degrees(animate ? 0 : -12))
                    .scaleEffect(animate ? 1.0 : 0.85)
                    .shadow(radius: 10)
                    .onAppear {
                        withAnimation(.spring(response: 0.8, dampingFraction: 0.6)
                            .repeatCount(2, autoreverses: true)) { animate = true }
                    }
                Text(appState.isArabic ? "كل مطاعم الكويت في مكان واحد"
                                       : "All Kuwait restaurants in one app")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        .task {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            goHome = true
        }
        .fullScreenCover(isPresented: $goHome) { HomeView() }
    }
}
