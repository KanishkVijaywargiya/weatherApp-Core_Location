//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Kanishk Vijaywargiya on 04/01/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var action: () -> ()
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text, onCommit: action)
            Button(action: action) {
                Image(systemName: "magnifyingglass").foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Hello"), action: {})
    }
}

