//
//  AddBookView.swift
//  Bookworm
//
//  Created by user on 7/20/24.
//

import SwiftUI

extension String {
    func onlyContainsWhitespaces() -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedString.isEmpty
    }
}

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var bookPrompt = "Name of book"
    @State private var authorPrompt = "Author's name text"
    
    let genres = ["Fantasy" , "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(bookPrompt, text: $title)
                    TextField(authorPrompt, text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text ($0)
                        }
                    }
                }
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                Section {
                    Button("Save") {
                        let isValid = validateForm()
                        if isValid {
                            let newBook = Book(title: title, author: author, genre: genre,
                                               review: review, rating: rating)
                            modelContext.insert(newBook)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func validateForm() -> Bool {
        // Genres already have a forced default by fantasy, so I dont have to validate that property
        if title.isEmpty || title.onlyContainsWhitespaces() {
            bookPrompt = "Please enter a name of a actual book."
            return false
        } else if author.isEmpty || author.onlyContainsWhitespaces() {
            authorPrompt = "Please list a actual realistic author name."
            return false
        }
        return true
    }
}

#Preview {
    AddBookView()
}
