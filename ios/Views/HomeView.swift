import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var query = ""
    @State private var results: [Restaurant] = []
    @State private var loading = false
    @State private var city = "kuwait"

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField(appState.isArabic ? "ابحث عن مطعم أو طبق"
                                                : "Search restaurants or dishes", text: $query)
                        .textFieldStyle(.roundedBorder)
                    Button { appState.isArabic.toggle() } label: {
                        Text(appState.isArabic ? "EN" : "AR").bold()
                    }
                }.padding()

                if loading { ProgressView().padding(.top, 20) }

                List(results) { r in
                    NavigationLink { RestaurantDetailView(restaurant: r) } label: {
                        RestaurantCard(restaurant: r)
                    }
                }.listStyle(.plain)
            }
            .navigationTitle("FoodBird")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(appState.isArabic ? "تصنيفات" : "Categories") {}
                }
            }
        }
        .task(id: query) { await submitSearch() }
    }

    func submitSearch() async {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { results = []; return }
        loading = true; defer { loading = false }
        do {
            let lang = appState.isArabic ? "ar" : "en"
            results = try await APIClient.shared.searchRestaurants(query: query, lang: lang, city: city)
        } catch { print("Search error:", error) }
    }
}

struct RestaurantCard: View {
    let restaurant: Restaurant
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: restaurant.imageURL) { image in
                image.resizable().scaledToFill()
            } placeholder: { Color.gray.opacity(0.2) }
            .frame(width: 64, height: 64)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(restaurant.name).font(.headline)
                Text(restaurant.cuisine.joined(separator: ", "))
                    .font(.subheadline).foregroundStyle(.secondary)
                HStack(spacing: 8) {
                    if let eta = restaurant.deliveryETA { Label(eta, systemImage: "clock") }
                    Label(restaurant.platform.capitalized, systemImage: "shippingbox")
                }.font(.caption)
            }
        }
    }
}
