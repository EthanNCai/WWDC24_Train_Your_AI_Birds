//
//  GameView.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/4.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    @ObservedObject var content_ctrl = PageContentController()
    @State var isSpeeded = false
    var scene: GameScene
    var body: some View {
        ZStack{
            
            // gamelayer
            SpriteView(scene: scene)
                .mask(RoundedRectangle(cornerRadius: 5))
                .padding(.vertical,10)
                .padding(.trailing,10)
                .onDisappear(){
                    //self.content_ctrl.controller_reset()
                }
                .onChange(of: scene.size) { newSize in
                    //self.content_ctrl.controller_reset()
                }
            
            // banner
            
            if self.content_ctrl.isOnSetting && self.content_ctrl.experiment_mode{
                Text("Tweak the settings whatever you want and then click __\"🔨Start Your Experiment\"__ on upper left to see what happens.")
                    .padding()
                    .padding()
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .padding()
            }else if !self.content_ctrl.isOnSetting && self.content_ctrl.experiment_mode
            {
                if !content_ctrl.isUserBegin ||  content_ctrl.isGameOver{
                    VStack{
                        if !self.content_ctrl.isGameOver{
                            if self.content_ctrl.rounds_count == 1{
                                Text("Ready to test the \(String(self.content_ctrl.rounds_count))st. generation")
                            }else if self.content_ctrl.rounds_count == 2{
                                Text("Ready to test the \(String(self.content_ctrl.rounds_count))nd. generation")
                            }else if self.content_ctrl.rounds_count == 3{
                                Text("Ready to test the \(String(self.content_ctrl.rounds_count))rd. generation")
                            }else{
                                Text("Ready to test the \(String(self.content_ctrl.rounds_count))th. generation")
                            }
                        }
                        Text(content_ctrl.bannerContent)
                            .fontWeight(.black)
                            .padding()
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 10))
                    
                }
            }else if !self.content_ctrl.isUserBegin && self.content_ctrl.display_mode{
                
                Text(content_ctrl.bannerContent)
                    .fontWeight(.black)
                    .padding()
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 10))
                
            }else if !self.content_ctrl.isUserBegin && self.content_ctrl.play_mode{
                Text(content_ctrl.bannerContent)
                    .fontWeight(.black)
                    .padding()
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 10))
                        
                }
            
            if !self.content_ctrl.isOnSetting && self.content_ctrl.experiment_mode{
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
            if !self.content_ctrl.isOnSetting && self.content_ctrl.experiment_mode{
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
                        .background(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 15))
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
            }
            if !self.content_ctrl.isOnSetting && self.content_ctrl.play_mode{
                //debug info
                HStack{
                    VStack{
                        VStack(alignment: .leading){
            
                            Text("Distance:\(self.content_ctrl.balls.indices.contains(0) ? Int(self.content_ctrl.balls[0].distance_score) : 0)")
                        }
                        .fontWeight(.black)
                        .padding()
                        .background(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 15))
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
            }
            
        }
        
    
    }
}

