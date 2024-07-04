//
//  ContentView.swift
//  iExpense
//
//  Created by user on 6/15/24.
//
import SwiftUI

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

struct ExpenseRow: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                StyleView(item: item)
            }
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
    }
}

struct StyleView: View {
    let item: ExpenseItem
    
    var textStyle: Font {
        if item.amount >= 100 {
            return .largeTitle
        } else if item.amount >= 10 {
            return .headline
        } else {
            return .body
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(textStyle)
            Text(item.type)
        }
    }
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personal")) {
                    ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                        ExpenseRow(item: item)
                    }
                    .onDelete(perform: deletePersonalExpense)
                }
                
                Section(header: Text("Business")) {
                    ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                        ExpenseRow(item: item)
                    }
                    .onDelete(perform: deleteBusinessExpense)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func deletePersonalExpense(at offsets: IndexSet) {
        expenses.items.removeAll(where: { offsets.contains(expenses.items.firstIndex(of: $0)!) })
    }
    
    func deleteBusinessExpense(at offsets: IndexSet) {
        expenses.items.removeAll(where: { offsets.contains(expenses.items.firstIndex(of: $0)!) })
    }
}

#Preview {
    ContentView()
}

