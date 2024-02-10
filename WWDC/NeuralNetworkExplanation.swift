//
//  NeuralNetworkExplanation.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/9.
//

import SwiftUI

struct NeuralNetworkExplanation: View {
    @ObservedObject var content_ctrl: PageContentController
    var body: some View {
        
        
        VStack {
            
            
            
            HStack {
                VStack{
                    
                    VStack(spacing: 0){
                        Text("Distance to the column")
                            .font(.caption2)
                        HStack{
                            
                            Gauge(value: self.content_ctrl.balls.indices.contains(0) ? self.content_ctrl.balls[0].distance_d : 0, in: 0...500, label: {}).frame(width: 30,height: 30)
                            Image(systemName: "arrow.right")
                                .frame(width: 30,height: 30)
                        }
                    }
                    .padding(1)
                    
                    VStack(spacing: 0) {
                        Text("Distance to lower column")
                            .font(.caption2)
                        HStack{
                            Gauge(value: self.content_ctrl.balls.indices.contains(0) ? self.content_ctrl.balls[0].distance_u : 0, in: 0...500, label: {}).frame(width: 30,height: 30)
                            Image(systemName: "arrow.right")
                                .frame(width: 30,height: 30)
                        }
                        
                    }.padding(1)
                    
                    VStack(spacing: 0) {
                        Text("velocity")
                            .font(.caption2)
                        HStack{
                            Gauge(value: self.content_ctrl.balls.indices.contains(0) ? self.content_ctrl.balls[0].velocity : -700, in: -700...700, label: {}).frame(width: 30,height: 30)
                            Image(systemName: "arrow.right")
                                .frame(width: 30,height: 30)
                        }
                        
                    }.padding(1)
                    
                    
                }
                
                    Text("🧠Neural Network")
                        .font(.title2)
                        .fontWeight(.heavy)
                    
                    .frame(width: 100,height: 130)
                    .padding()
                    .background(.ultraThickMaterial)
                    .mask(RoundedRectangle(cornerRadius: 15))
                    
                    
                
                
                VStack{
                    VStack(spacing: 0) {
                        Text("Fly")
                            .font(.caption2)
                            .padding(.leading)
                        HStack{
                            
                            Image(systemName: "arrow.right")
                                .frame(width: 30,height: 30)
                            Gauge(value: self.content_ctrl.balls.indices.contains(0) ? self.content_ctrl.balls[0].fly_probability : 0, in: 0...1, label: {}).frame(width: 30,height: 30)
                                .tint(.red)
                                
                            
                        }
                    }
                    .padding(1)
                    
                    VStack(spacing: 0) {
                        Text("Not fly")
                            .font(.caption2)
                            .padding(.leading)
                        HStack{
                            
                            Image(systemName: "arrow.right")
                                .frame(width: 30,height: 30)
                            Gauge(value: self.content_ctrl.balls.indices.contains(0) ? (1-self.content_ctrl.balls[0].fly_probability) : 0, in: 0...1, label: {}).frame(width: 30,height: 30)
                                .tint(.red)
                                
                            
                        }
                    }
                    .padding(1)
                }
                
                
                
            }
            
                        
            
        }.padding()
            .frame(width: content_ctrl.size.width*1/2,
                   height: content_ctrl.size.height)
            
    }
}


