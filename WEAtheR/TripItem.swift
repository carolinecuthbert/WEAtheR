import Foundation
import SwiftData

@Model
class TripItem {
    var title: String
    var location: String
    var length: Int
    var occasion: String
    var listItems: [ListItem]

    init(title: String, location: String, length: Int, occasion: String, listItems: [ListItem] = []) {
        self.title = title
        self.location = location
        self.length = length
        self.occasion = occasion
        self.listItems = listItems
    }
}
