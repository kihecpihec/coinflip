//
//  ContentView.swift
//  CoinFlip
//
//  Created by kihec on 15. 6. 25.
//

import SwiftUI

struct BackgroundView: View {
    @State private var animateGradient = false
    
    var body: some View {
        ZStack {
            // Base gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.systemBackground),
                    Color(.systemBackground).opacity(0.8)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Animated circles
            ForEach(0..<3) { index in
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue.opacity(0.2),
                                Color.purple.opacity(0.2)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 300 + CGFloat(index * 150))
                    .offset(
                        x: animateGradient ? 100 : -100,
                        y: animateGradient ? -50 : 50
                    )
                    .blur(radius: 40)
                    .opacity(0.5)
            }
            
            // Additional accent circles
            ForEach(0..<2) { index in
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.yellow.opacity(0.15),
                                Color.orange.opacity(0.15)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 200 + CGFloat(index * 100))
                    .offset(
                        x: animateGradient ? -80 : 80,
                        y: animateGradient ? 40 : -40
                    )
                    .blur(radius: 30)
                    .opacity(0.4)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

struct ContentView: View {
    @State private var isFlipped = false
    @State private var rotation: Double = 0
    @State private var result: String = "Tap to flip"
    
    private func flipCoin() {
        // Generate random outcome
        let randomOutcome = Bool.random()
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            rotation += 180
            isFlipped = randomOutcome
            result = randomOutcome ? "Tails" : "Heads"
        }
    }
    
    var body: some View {
        ZStack {
            // Enhanced background
            BackgroundView()
            
            VStack(spacing: 30) {
                // Coin
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.gray.opacity(0.2), .gray.opacity(0.1)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 200, height: 200)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    
                    // Heads
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.yellow, .orange]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 180, height: 180)
                        .opacity(isFlipped ? 0 : 1)
                    
                    // Tails
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 180, height: 180)
                        .opacity(isFlipped ? 1 : 0)
                }
                .rotation3DEffect(
                    .degrees(rotation),
                    axis: (x: 0, y: 1, z: 0)
                )
                
                // Result text
                Text(result)
                    .font(.system(size: 24, weight: .medium, design: .rounded))
                    .foregroundColor(.primary)
                    .opacity(0.8)
            }
        }
        .onTapGesture {
            flipCoin()
        }
    }
}

#Preview {
    ContentView()
}
