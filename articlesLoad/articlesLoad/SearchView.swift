//
//  SearchView.swift
//  articlesLoad
//
//  Created by Richard Buehling on 9/4/21.
//

import SwiftUI

struct SearchView: View {
    
    
    
    
    
    
    
    
    // Search text
    @Binding var searchText: String
    
    // Checks if searching or not
    @Binding var searching: Bool
    
    var body: some View {
        
        // Searchbar view
        ZStack {
            Rectangle()
                .foregroundColor(Color("SearchBar"))
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchText) { startedSearching in
                    if startedSearching {
                        withAnimation {
                            searching = true
                        }
                    }
                    
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
            }
            .foregroundColor(.gray)
            .padding()
        }
        .frame(height: 40)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}


// Preview for Xcode
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: .constant(""), searching: .constant(false))
    }
}
