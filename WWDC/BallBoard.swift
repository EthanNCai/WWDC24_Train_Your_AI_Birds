//
//  BallBoard.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/2.
//

import SwiftUI

struct BallBoard: View {
    @Binding var balls:[Ball]
    var body: some View {
  
                
            
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]){
            
            
            ForEach(balls) { ball in
                VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "bird.fill")
                            Text(ball.isActive ? "Alive" : "Outed")
                                .font(.caption)
                        }
                        
                        HStack(spacing: 0) {
                            Text(String(format: "%8.1f", ball.distance_score))
                                .font(.caption2)
                                .fontWeight(.heavy)
                            
    
                        }
                    }
                    .padding(2)
                    .background(ball.isActive ? Color.green.opacity(0.8) : Color.red.opacity(0.6))
                    .mask(RoundedRectangle(cornerRadius: 3))
                    .overlay(
                        ball.is_jumped ?
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.yellow, lineWidth: 3) :
                            RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.clear, lineWidth: 3)
                    )
                }
            }
            
            
            
            
            
    }
}




