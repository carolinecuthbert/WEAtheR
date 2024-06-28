//
//  NewItemView.swift
//  WEAtheR
//
//  Created by Caroline Cuthbert on 6/27/24.
//

import SwiftUI

struct NewItemView: View {
    @Bindable var tripItem: TripItem
    @Environment(\.modelContext) var modelContext
    @Binding var showNewItem: Bool
    @Binding var newItemName: String
    @Binding var newQuantity: String
    
    var body: some View {
        VStack{
            TextField("Add new item", text: $newItemName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Quantity", text: $newQuantity)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                addItem()
                self.showNewItem = false
            } label: {
                Text("Add Item")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
    func addItem() {
        guard let quantity = Int(newQuantity) else { return }
        let newListItem = ListItem(name: newItemName, quantity: quantity)
        tripItem.listItems.append(newListItem)
        modelContext.insert(newListItem)
        newItemName = ""
        newQuantity = "1"
    }
}

/*
#Preview {
    NewItemView()
}
*/
