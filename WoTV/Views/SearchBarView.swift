//
//  SearchBarView.swift
//  WoTV
//
//  Created by Vladyslav Markov on 29.03.2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 10)
            }
        }
        .padding(.horizontal)
        
        Spacer()
    }
}
