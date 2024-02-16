//
//  ReproductionBirdCard.swift
//  Train your own bird AI!
//
//  Created by 蔡俊志 on 2024/2/14.
//

import SwiftUI

struct ReproductionBirdCard: View {
    var ball:Ball
    @Binding var is_selected:Bool
    @State var show_shadow:Bool = false
    var body: some View {
        VStack{
            HStack{
                    
                VStack
                {
                    Image(systemName: "bird.fill")
                    .foregroundColor(.white)
                        .font(.title3)
                        .padding(5)
                        .background(){
                            Circle()
                                .foregroundColor(self.ball.color)
                        }
                }

                HStack{
                    VStack(alignment: .leading,spacing: 5){
                        Image(systemName: "pin")
                        
                        Image(systemName: "ruler.fill")
                       
                    }.fontWeight(.heavy)
                    VStack(alignment: .leading,spacing: 3){
                        Gauge(value: self.ball.norm_distance_score, in: 0...1, label: {})
                            .tint(.blue)
                        Gauge(value: (1-self.ball.norm_avg_gap_dist_score), in: 0...1, label: {})
                            .tint(.red)
                       
                    }
                    .frame(maxWidth: 35)
                    .overlay(){
                        Color.white.opacity(0.01)
                    }
                    .fontWeight(.heavy)
                }
            }
        }
            .padding()
            .background(.white.opacity(0.1))
            .shadow(radius: show_shadow ? 5 : 0)
            .mask(RoundedRectangle(cornerRadius: 18))
            
            .overlay(){
                RoundedRectangle(cornerRadius: 18).stroke(lineWidth: 5).fill(is_selected ? .green : .gray)
            }
            .padding(10)
            .overlay(){
                if is_selected{

                    HStack{
                        Spacer()
                        VStack{
                            
                            Image(systemName: "checkmark.circle.fill")
                                .background(){
                                    Circle()
                                }
                                .font(.largeTitle)
                                .foregroundColor(.green)
                                .overlay(){
                                    Image(systemName: "checkmark")
                                        .fontWeight(.heavy)
                                        .foregroundColor(.white)
                                }
                            
                            
                            
                            Spacer()
                        }
                    }
                }
            }
            .onHover{
                is_hover in
                show_shadow = is_hover
            }
            
            
    }
}

