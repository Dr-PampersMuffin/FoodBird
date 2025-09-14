import Foundation
enum BuildConfig {
#if DEBUG
    static let API_BASE_URL = URL(string: "http://localhost:8000")!
#else
    static let API_BASE_URL = URL(string: "https://api.foodbird.app")! // update when deployed
#endif
}
