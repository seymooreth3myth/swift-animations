//
//  ContentView.swift
//  animations
//
//  Created by Fábio Carlos de Souza on 21/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    
    @State private var animationAmount2 = 1.0
    
    @State private var animationAmount3d = 0.0
    
    let letters = Array("Animation SwiftUI")
        @State private var enabled = false
        @State private var dragAmount = CGSize.zero
    var body: some View {
        
        VStack {
            Stepper("Escala", value: $animationAmount2.animation(), in: 1...10)
            Spacer()

            HStack(spacing: 0) {
                ForEach(0..<letters.count, id: \.self) {num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .blue : .red)
                        .offset(dragAmount)
                        .animation(.default.delay(Double(num) / 20), value: dragAmount)
                }
                
            }
            .gesture(
                DragGesture()
                    .onChanged{dragAmount = $0.translation}
                    .onEnded{_ in
                        dragAmount = .zero
                        enabled.toggle()
                    }
            )
            Button("3d") {
                withAnimation(
                    .interpolatingSpring(stiffness: 5, damping: 1))
                {
                    animationAmount3d += 360
                }

            }
            .padding(50)
            .background(.green)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(
                .degrees(
                    animationAmount3d),
                axis: (x: 0, y:1, z: 0))

            Button("Scale") {
                animationAmount2 += 1
            }
            .padding(50)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount2)

            Button("repeat forever") {
                //            animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animationAmount)
            )
            .onAppear {
                animationAmount = 2
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
