import SwiftUI

struct Order: Identifiable {
    let id = UUID()
    var personName: String
    var drink: String
}

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    
    func addOrder(name: String, drink: String) {
        let newOrder = Order(personName: name, drink: drink)
        orders.append(newOrder)
    }
}

struct ContentView: View {
    @State private var name = ""
    @State private var drink = ""
    @ObservedObject var viewModel = OrderViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Add New Order")) {
                        TextField("Enter name", text: $name)
                        TextField("Enter drink", text: $drink)
                        
                        Button("Add Order") {
                            if !name.isEmpty && !drink.isEmpty {
                                viewModel.addOrder(name: name, drink: drink)
                                name = ""
                                drink = ""
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                List(viewModel.orders) { order in
                    VStack(alignment: .leading) {
                        Text(order.personName)
                            .font(.headline)
                        Text(order.drink)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Tim Hortons Orders")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

