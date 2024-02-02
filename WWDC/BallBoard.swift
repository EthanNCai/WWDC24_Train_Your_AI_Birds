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
                }
            }
            
            
            
            
            
    }
}



func generate_test_sample() -> [Ball]{
    var ball1:Ball = Ball(x: 0, y: 0, ball_index: 0, ball_radius: 0, ball_color: .red)
    var ball2:Ball = Ball(x: 0, y: 0, ball_index: 0, ball_radius: 0, ball_color: .red)
    var ball3:Ball = Ball(x: 0, y: 0, ball_index: 0, ball_radius: 0, ball_color: .red)
    var ball4:Ball = Ball(x: 0, y: 0, ball_index: 0, ball_radius: 0, ball_color: .red)
    var ball5:Ball = Ball(x: 0, y: 0, ball_index: 0, ball_radius: 0, ball_color: .red)
    var ball6:Ball = Ball(x: 0, y: 0, ball_index: 0, ball_radius: 0, ball_color: .red)
    
    ball1.distance_score = 123.124
    ball2.distance_score = 653.124
    ball3.distance_score = 423.324
    ball4.distance_score = 743.124
    ball5.distance_score = 17233.124
    ball6.distance_score = 9821.32
    
    ball1.isActive = false
    ball2.isActive = true
    ball3.isActive = true
    ball4.isActive = true
    ball5.isActive = true
    ball6.isActive = false
    
    let balls:[Ball] = [ball1,ball2,ball3,ball4,ball5]
    return balls
}

