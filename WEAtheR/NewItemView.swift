import SwiftUI
import SwiftData

struct NewItemView: View {
    @Bindable var tripItem: TripItem
    @Environment(\.modelContext) var modelContext
    @Binding var showNewItem: Bool
    @Binding var newItemName: String
    @Binding var newQuantity: Int
    
    var body: some View {
        VStack {
            TextField("Add new item", value: $newItemName, formatter: NumberFormatter())
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Quantity", value: $newQuantity, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                addItem()
                self.showNewItem = false
            } label: {
                Text("Add Item")
                    .padding()
                    .font(.system(size: 20.0))
                    .background(Color("cre"))
                    .foregroundColor(.black)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    func addItem() {
        let newListItem = ListItem(name: newItemName, quantity: newQuantity, isChecked: false)
        tripItem.listItems.append(newListItem)
        modelContext.insert(newListItem)
        newItemName = ""
        newQuantity = 0
    }
}


/*
#Preview {
    NewItemView()
}
*/
