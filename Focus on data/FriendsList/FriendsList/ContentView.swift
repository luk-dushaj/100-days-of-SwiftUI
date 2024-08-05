//
//  ContentView.swift
//  FriendsList
//
//  Created by user on 7/29/24.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    @Query (sort: \User.name) private var users: [User]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    HStack {
                        Circle()
                            .fill(user.isActive ? .green : .red)
                            .frame(width: 30)

                        Text(user.name)
                    }
                }
            }
            .navigationTitle("FriendList")
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
            .task {
                await fetchUsers()
            }
        }
    }

    func fetchUsers() async {
        guard users.isEmpty else { 
            return
        }

        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let downloadedUsers = try decoder.decode([User].self, from: data)
            let insertContext = ModelContext(modelContext.container)
            
            for user in downloadedUsers {
                insertContext.insert(user)
            }
            
            try insertContext.save()
        } catch {
            print("Download failed")
        }
    }
}

#Preview {
    ContentView()
}
