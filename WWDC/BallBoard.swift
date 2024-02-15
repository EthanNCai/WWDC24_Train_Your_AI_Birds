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
  
                
            
        LazyVGrid(columns: [ GridItem(.flexible(minimum: 100), spacing: 2),
                             GridItem(.flexible(minimum: 100), spacing: 2),
                             GridItem(.flexible(minimum: 100), spacing: 2),
                             GridItem(.flexible(minimum: 100), spacing: 2),
                           ]){
            
            
            ForEach(balls) { ball in
                /*
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
                    )*/
                
                VStack(alignment: .leading) {
                        HStack {
                            
                            
                            VStack(spacing: 4) {
                                
                                HStack(spacing:0){
                                    VStack{
                                        Image(systemName: "pin")
                                        Image(systemName: "ruler.fill")
                                    }
                                    VStack{
                                        Text(String(format: ":%10.0f", ball.distance_score))
                                            .font(.caption2)
                                            .fontWeight(.heavy)
                                            .lineLimit(1)
                                        Text(String(format: ":%10.0f", ball.avg_gap_dist_score))
                                            .font(.caption2)
                                            .fontWeight(.heavy)
                                            .lineLimit(1)
                                    }
                                }
                            }
                        }
                    }
                    .padding(7)
                    .frame(minWidth: 80)
                    .mask(RoundedRectangle(cornerRadius: 15))
//                    .overlay(){
//                        // jump indicator
//                        
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(ball.is_jumped ? Color.orange.opacity(0.9) : Color.clear, lineWidth: 10)
//                            
//                    }
                    .overlay(){
                        // alive indicator
                        
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(ball.isActive ? Color.green.opacity(0.9) : Color.red.opacity(0.9), lineWidth: 5)
                           
                    }
                    .padding(10)
                    
                    .overlay(){
                        HStack{
                            Spacer()
                            VStack{
                                Image(systemName: "bird.fill")
                                    .foregroundColor(.white)
                                    .padding(3)
                                    .background(){
                                        Circle().fill(ball.color)
                                    }
                                Spacer()
                            }
                            
                        }
                    }
                }
            }
    }
}




