import Foundation

enum APIError: Error { case badURL, decoding, network }

final class APIClient {
    static let shared = APIClient()
    private init() {}

    func searchRestaurants(query: String, lang: String, city: String) async throws -> [Restaurant] {
        var comps = URLComponents(url: BuildConfig.API_BASE_URL.appendingPathComponent("/restaurants"),
                                  resolvingAgainstBaseURL: false)!
        comps.queryItems = [
            .init(name: "query", value: query),
            .init(name: "lang", value: lang),
            .init(name: "city", value: city)
        ]
        guard let url = comps.url else { throw APIError.badURL }
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.network }
        return try JSONDecoder().decode([Restaurant].self, from: data)
    }
}
