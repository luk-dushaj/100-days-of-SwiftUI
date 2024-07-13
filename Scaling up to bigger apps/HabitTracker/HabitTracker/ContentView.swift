//
//  ContentView.swift
//  HabitTracker
//
//  Created by user on 7/4/24.
//

/*
 Checklist:
 
 Wednesday:
 fix the Codable thing to have data show up live on the views and be reloaded
 *I mainly have to fix the saving part and making sure it shows up on the views like description and add more to timesCompleted*
 Make sure the timesCompleted is saved after the view disappears
 Add more styling (Like add dark/light mode styles)
 Overall add more styling
 
 */

/* did take from iExpense https://github.com/luk-dushaj/100-days-of-SwiftUI/blob/main/Scalinguptobiggerapps/Project7/iExpense/iExpense/ContentView.swift
 */

import SwiftUI

// Identifiable so it can be used in a list
// Using object instead of struct so I can dynamically modify the data easier
struct Habit: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var timesCompleted: Int
    
    init(id: UUID = UUID(), title: String = "", description: String = "", timesCompleted: Int = 0) {
        self.id = id
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
    
    private func loadItems() {
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
    
    private func saveItems() {
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
    @State private var saveTimesCompleted = false
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
                        NavigationLink(destination: Detail(habit: $habit, saveTimesCompleted: $saveTimesCompleted    )) {
                            Text(habit.title)
                                .font(.headline)
                        }
                        .onDisappear() {
                            if saveTimesCompleted {
                                print(habit.timesCompleted)
                                saveHabit()
                            }
                        }
                    }
                }
                .onDelete(perform: deleteHabits)
            }
            .navigationTitle("Habits")
            .foregroundColor(scheme ? .black : .white)
            .toolbar {
                Button {
                    createHabit.toggle()
                } label: {
                    Label("Add Habit", systemImage: "plus")
                }
            }
            .fullScreenCover(isPresented: $createHabit) {
                AddHabit(habit: $habit, isCreated: $isCreated)
                    .onDisappear {
                        if isCreated {
                            habits.add(Habit(title: habit.title, description: habit.description))
                        }
                    }
            }
        }
        .preferredColorScheme(colorScheme) // Set dark mode globally
    }
    
    private func deleteHabits(offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
    private func saveHabit() {
        // Find the index of the habit in the Habits list and replace it with the updated habit
        if let index = habits.items.firstIndex(where: { $0.id == habit.id }) {
            habits.items[index] = habit
        }
    }
}


#Preview {
    ContentView()
}
