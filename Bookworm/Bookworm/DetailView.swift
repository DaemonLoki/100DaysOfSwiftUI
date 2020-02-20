//
//  DetailView.swift
//  Bookworm
//
//  Created by Stefan Blos on 20.02.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        return GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                    .padding(12)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                    .clipShape(Capsule())
                        .offset(x: -10, y: -10)
                }

                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No review")
                .padding()
                
                Text(self.book.date != nil ? dateFormatter.string(from: self.book.date!) : "")
                    .font(.caption)
                    .padding(.bottom)
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Spacer()
            }
            
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBook()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
        .navigationBarTitle(Text(book.title ?? "Unknown book"), displayMode: .inline)
    }
    
    func deleteBook() {
        moc.delete(book)
        
        // uncomment line to make deletion permanent
        // try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
    
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        return NavigationView {
            DetailView(book: book)
        }
        
    }
}
