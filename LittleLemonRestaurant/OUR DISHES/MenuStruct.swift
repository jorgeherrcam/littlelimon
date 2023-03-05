import Foundation

struct JSONMenu: Decodable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}

struct MenuItem: Decodable, Hashable, Identifiable {
    var id = UUID()
    let title: String
    let price: String
    let description: String
    let image: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title, price, description, category, image
    }
}
