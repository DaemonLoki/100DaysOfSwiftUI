//
//  AddBockView.swift
//  Bookworm
//
//  Created by Stefan Blos on 12.02.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct AddBockView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    var isValidInput: Bool {
        if title.isEmpty || author.isEmpty || genre.isEmpty || review.isEmpty {
            return false
        }
        return true
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        newBook.date = Date()
                        
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }.disabled(isValidInput == false)
            }
        .navigationBarTitle("Add Book")
        }
    }
}

struct AddBockView_Previews: PreviewProvider {
    static var previews: some View {
        AddBockView()
    }
}
