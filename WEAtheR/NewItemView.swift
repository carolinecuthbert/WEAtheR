import SwiftUI
import SwiftData

struct NewItemView: View {
    @Bindable var tripItem: TripItem
    @Environment(\.modelContext) var modelContext
    @Binding var showNewItem: Bool
    @Binding var newItemName: String
    @Binding var newQuantity: String
    
    var body: some View {
        VStack {
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
                    .font(.system(size: 20.0))
                    .background(Color("cre"))
                    .foregroundColor(.black)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    func addItem() {
        guard let quantity = Int(newQuantity) else { return }
        let newListItem = ListItem(name: newItemName, quantity: quantity, isChecked: false)
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
