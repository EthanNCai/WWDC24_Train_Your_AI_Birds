//
//  GameView.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/4.
//

import SwiftUI
import SpriteKit

struct GameView: View,Equatable {
    @Namespace var namespace
    @ObservedObject var content_ctrl = PageContentController()
    @State var isSpeeded = false
    var scene: GameScene
    
    static func == (lhs: GameView, rhs: GameView) -> Bool {
            return lhs.scene == rhs.scene
        }
    
    var body: some View {
        ZStack{
            
            // gamelayer
            SpriteView(scene: scene)
                .mask(RoundedRectangle(cornerRadius: 20))
                .overlay(){
                    RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 5).fill(self.content_ctrl.play_mode ? .green.opacity(0.8) : .red.opacity(0.8))
                }
                .padding()
                .overlay(){
                    
                        VStack{
                            Text(self.content_ctrl.play_mode ? "Birds' now controlled by you" : "Birds' now controlled by itself")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(5)
                                .padding(.horizontal)
                                .background(self.content_ctrl.play_mode ? .green : .red)
                                .mask(RoundedRectangle(cornerRadius: 11))
                            Spacer()
                            
                        }
                    
                }
            
            // banner
            
            if  self.content_ctrl.experiment_mode
            {
                if !content_ctrl.isUserBegin {
                    VStack{
                        if !self.content_ctrl.isGameOver{
                            
                            Text("Ready to test the \(String(self.content_ctrl.rounds_count))th. generation")
                            Text(content_ctrl.bannerContent)
                                .fontWeight(.black)
                        }else if self.content_ctrl.isGameOver && self.content_ctrl.is_selecting{
                            Text("starting breeding panal...")
                        }else{
                            VStack{
                                ProgressView()
                                    .padding(1)
                                Text("Breeding birds...")
                            }
                            
                        }
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial.opacity(0.5))
                    .matchedGeometryEffect(id: "bg1", in: namespace)
                    .mask(RoundedRectangle(cornerRadius: 10))
                    .matchedGeometryEffect(id: "msk1", in: namespace)
                    .padding()
                    
                }
            }else if !self.content_ctrl.isUserBegin && self.content_ctrl.display_mode{
                
                Text(content_ctrl.bannerContent)
                    .fontWeight(.black)
                    .padding()
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
            }else if !self.content_ctrl.isUserBegin && self.content_ctrl.play_mode{
                Text(content_ctrl.bannerContent)
                    .fontWeight(.black)
                    .padding()
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 10))
                    .padding()
                        
                }
            /*
            if  self.content_ctrl.experiment_mode{
            // gauges
                VStack{
                    
                    // gauges Top
                    HStack{
                        Spacer()
                    }
                    .padding(.vertical)
                    Spacer()
                    
                    
                    // gauges Buttom
                    HStack{
                        
                        Toggle(isOn: self.$content_ctrl.isLooped) {
                            Text("Automatically proceed to the next generation：")
                        }.toggleStyle(SwitchToggleStyle())
                            .padding(.horizontal)
                            
                    }
                    .padding()
                    
                }
            
            }
            */
//            if  self.content_ctrl.experiment_mode{
//            // gauges
//                VStack{
//
//
//
//
//                    Spacer()
//
//                    HStack {
//                        Image(systemName: "minus.circle.fill")
//                            .font(.title2)
//                        Text("Speed 12%")
//                        Image(systemName: "plus.circle.fill")
//                            .font(.title2)
//
//                    }
//                    .padding()
//
//
//
//                }.padding()
//
//            }
            if  self.content_ctrl.experiment_mode && self.content_ctrl.isUserBegin{
                //debug info
                HStack{
                    VStack{
                        VStack(alignment: .leading){
                            
                            if self.content_ctrl.rounds_count == 1{
                                Text(" \(String(self.content_ctrl.rounds_count))st. generation bird")
                                
                            }else if self.content_ctrl.rounds_count == 2{
                                Text(" \(String(self.content_ctrl.rounds_count))nd. generation bird")
                            }else if self.content_ctrl.rounds_count == 3{
                                Text(" \(String(self.content_ctrl.rounds_count))rd. generation bird")
                            }else{
                                Text(" \(String(self.content_ctrl.rounds_count))th. generation bird")
                            }
                        }
                        .fontWeight(.black)
                        .padding()
                        .background(.ultraThinMaterial.opacity(0.5))
                        .mask(RoundedRectangle(cornerRadius: 15))
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }.padding()
            }
            if  self.content_ctrl.play_mode{
                //debug info
                HStack{
                    VStack{
                        VStack(alignment: .leading){
            
                            Text("Distance:\(self.content_ctrl.balls.indices.contains(0) ? Int(self.content_ctrl.balls[0].distance_score) : 0)")
                        }
                        .fontWeight(.black)
                        .padding()
                        .background(.ultraThinMaterial.opacity(0.5))
                        .mask(RoundedRectangle(cornerRadius: 15))
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }.padding()
            }
            
            
            
        }
        
    
    }
}

