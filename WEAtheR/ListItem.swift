//
//  TripItem.swift
//  Trip
//
//  Created by Scholar on 6/26/24.
//

import Foundation
import SwiftData

@Model
class ListItem {
    var name: String
    var quantity: Int
    var isChecked: Bool

    init(name: String, quantity: Int = 1, isChecked: Bool = false) {
        self.name = name
        self.quantity = quantity
        self.isChecked = isChecked
    }
}
