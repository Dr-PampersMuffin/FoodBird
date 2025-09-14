import Foundation

struct Restaurant: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let imageURL: URL?
    let cuisine: [String]
    let deliveryETA: String?
    let platform: String
    let rating: Double?
    let city: String?
    let menu: [MenuItem]?
}

struct MenuItem: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let price: Double?
    let currency: String?
    let imageURL: URL?
    let options: [String]?
}
