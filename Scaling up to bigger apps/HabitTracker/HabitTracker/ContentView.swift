//
//  ContentView.swift
//  HabitTracker
//
//  Created by user on 7/4/24.
//

import SwiftUI

@Observable
class Habit: Codable, Identifiable {
    var title: String
    var description: String
    var timesCompleted: Int
    
    init(title: String = "", description: String = "", timesCompleted: Int = 0) {
        self.title = title
        self.description = description
        self.timesCompleted = timesCompleted
    }
}

@Observable
class Habits {
    var items: [Habit] = [] {
        didSet {
            saveItems()
        }
    }
    
    init() {
        loadItems()
    }
    
    public func loadItems() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            do {
                let decodedItems = try JSONDecoder().decode([Habit].self, from: savedItems)
                items = decodedItems
                print("Loaded items from UserDefaults:")
                for habit in items {
                    print("- Title: \(habit.title), Description: \(habit.description), Times Completed: \(habit.timesCompleted)")
                }
            } catch {
                print("Error decoding items: \(error.localizedDescription)")
            }
        } else {
            print("No items found in UserDefaults.")
            items = []
        }
    }
    
    public func saveItems() {
        do {
            let encoded = try JSONEncoder().encode(items)
            UserDefaults.standard.set(encoded, forKey: "Items")
            print("Saved items to UserDefaults:")
            for habit in items {
                print("- Title: \(habit.title), Description: \(habit.description), Times Completed: \(habit.timesCompleted)")
            }
        } catch {
            print("Error encoding items: \(error.localizedDescription)")
        }
    }
    
    func add(_ habit: Habit) {
        items.append(habit)
    }
    
    func remove(atOffsets offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct ContentView: View {
    @State private var habits = Habits()
    @State private var habit: Habit = Habit()
    @State private var createHabit = false
    @State private var isCreated = false
    @State private var isChanged = false
    @Environment(\.colorScheme) var colorScheme
    var scheme: Bool {
        if colorScheme == .dark {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { habit in
                    VStack(alignment: .leading) {
                        NavigationLink(destination: Detail(habit: habit, isChanged: $isChanged)) {
                            Text(habit.title)
                                .font(.headline)
                        }
                        .onChange(of: isChanged) {
                            habits.saveItems()
                            isChanged = false
                        }
                    }
                }
                .onDelete(perform: deleteHabits)
            }
            .navigationTitle("Habits")
            .toolbar {
                Button {
                    createHabit.toggle()
                } label: {
                    Label("Add Habit", systemImage: "plus")
                }
            }
            .fullScreenCover(isPresented: $createHabit) {
                AddHabit(habit: habit, isCreated: $isCreated)
                    .onDisappear {
                        if isCreated {
                            habits.add(Habit(title: habit.title, description: habit.description))
                            isCreated = false
                        }
                    }
            }
        }
        .preferredColorScheme(colorScheme)
    }
    
    private func deleteHabits(offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
}


#Preview {
    ContentView()
}
