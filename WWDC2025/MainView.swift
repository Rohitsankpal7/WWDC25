//
//  WWDC2025AnimationView.swift
//  WWDC2025
//
//  Created by Rohit Sankpal on 28/03/25.
//

import SwiftUI
import Foundation

struct WWDC2025AnimationView: View {
    @State private var offset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var bounce: Bool = false
    @State private var rotationAngle: Double = 0
    @State private var rotationAngles: [Double] = Array(repeating: 0, count: 2) // one angle per character
    let text = "25"
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("VW")
                        .font(.system(size: 120, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color.green,
                                    Color.yellow,
                                    Color.orange,
                                    Color.purple.opacity(0.6)
                                ],
                                startPoint: .leading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .kerning(-15)
                    
                    Text("DC")
                        .font(.system(size: 120, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color.red,
                                    Color.purple,
                                    Color.blue
                                ],
                                startPoint: .topLeading,
                                endPoint: .trailing
                            )
                        )
                }
                
                HStack(spacing: 0) {
                            ForEach(0..<text.count, id: \.self) { index in
                                Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                                    .font(.system(size: 280, weight: .bold))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [
                                                Color(red: 0.3, green: 0.2, blue: 0, opacity: 0.4),
                                                Color(red: 1, green: 0.9, blue: 0.9, opacity: 0.2),
                                                Color(red: 1.0, green: 1.0, blue: 1.0)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .overlay {
                                        LinearGradient(
                                            colors: [
                                                .white.opacity(0.8),
                                                .white.opacity(0.1)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                        .mask(Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                                            .font(.system(size: 280, weight: .medium))
                                            .foregroundStyle(Color.gray))
                                    }
                                    .shadow(color: .gray.opacity(0.6), radius: 10, x: 0, y: -10)
                                    .rotationEffect(Angle(degrees: rotationAngles[index]))
                                    .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false), value: rotationAngles[index])
                            }
                        }
                        .onAppear {
                            for i in 0..<text.count {
                                rotationAngles[i] = 360
                            }
                        }
            }
            .offset(CGSize(width: offset.width + dragOffset.width, height: offset.height + dragOffset.height))
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        offset.width += value.translation.width
                        offset.height += value.translation.height
                    }
            )
        }
    }
}

#Preview {
    WWDC2025AnimationView()
}
