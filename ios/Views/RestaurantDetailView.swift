import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    @State private var qty: [String:Int] = [:]

    var body: some View {
        List {
            if let items = restaurant.menu, !items.isEmpty {
                ForEach(items) { item in
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(item.title).font(.headline)
                            if let price = item.price, let c = item.currency {
                                Text(String(format: "%.3f %@", price, c))
                                    .font(.subheadline).foregroundStyle(.secondary)
                            }
                            if let options = item.options, !options.isEmpty {
                                Text(options.joined(separator: " • "))
                                    .font(.caption).foregroundStyle(.secondary)
                            }
                            Stepper("Qty: \(qty[item.id, default: 0])") {
                                qty[item.id, default: 0] += 1
                            } onDecrement: {
                                qty[item.id, default: 0] = max(0, qty[item.id, default: 0] - 1)
                            }.labelsHidden()
                        }
                        Spacer()
                        AsyncImage(url: item.imageURL) { image in
                            image.resizable().scaledToFill()
                        } placeholder: { Color.gray.opacity(0.2) }
                        .frame(width: 72, height: 72)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }.padding(.vertical, 6)
                }
            } else {
                Text("No menu available").foregroundStyle(.secondary)
            }
        }
        .navigationTitle(restaurant.name)
    }
}
