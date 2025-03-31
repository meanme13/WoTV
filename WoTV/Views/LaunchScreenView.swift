//
//  LaunchScreenView.swift
//  WoTV
//
//  Created by Vladyslav Markov on 31.03.2025.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? .black : .white)
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "film")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Text("WoTV")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .opacity(isActive ? 1 : 0)
            .scaleEffect(isActive ? 1 : 1.2)
            .animation(.easeInOut(duration: 1), value: isActive)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isActive = true
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
