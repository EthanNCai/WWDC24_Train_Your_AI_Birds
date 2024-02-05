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
            
            if self.content_ctrl.isOnSetting{
                Text("Set everything up and\nClick \"🔨Start Your Experiment\"\n on upper left To Continue")
                    .padding()
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 10))
            }else
            {
                if !content_ctrl.isUserBegin ||  content_ctrl.isGameOver{
                    Text(content_ctrl.bannerContent)
                        .padding()
                        .background(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 10))
                        
                }
            }
            
            if !self.content_ctrl.isOnSetting{
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
                        Button(action: {
                            self.content_ctrl.isReset = true
                        }) {
                            Image(systemName: "arrow.clockwise.circle")
                            Text("Reset Experiment")
                        }
                        Toggle(isOn: self.$content_ctrl.isLooped) {
                            Text("Auto loop")
                        }.toggleStyle(SwitchToggleStyle())
                            .padding(.horizontal)
                            .background(.ultraThinMaterial)
                            .cornerRadius(5) // 设置按钮的圆角半径
                    }
                    .padding()
                    
                }
            
            }
            if !self.content_ctrl.isOnSetting{
                //debug info
                HStack{
                    VStack{
                        VStack(alignment: .leading){
                            
                            Text("Round" + String(self.content_ctrl.rounds_count))
                                
                        }
                        .padding()
                        .background(.gray.opacity(0.2))
                        .mask(RoundedRectangle(cornerRadius: 15))
                        
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    VStack{
                        VStack(alignment: .leading){
                            
                            Text("__Debug infos__")
                                .foregroundColor(.green)
                            Text("isGameBegin -> " + (self.content_ctrl.isGameBegin ? "true" : "false"))
                            Text("isUserBegin -> " + (self.content_ctrl.isUserBegin ? "true" : "false"))
                            Text("isGameOver -> " + (self.content_ctrl.isGameOver ? "true" : "false"))
                            Text("isLooped -> " + (self.content_ctrl.isLooped ? "true" : "false"))
                            Text("isReset -> " + (self.content_ctrl.isReset ? "true" : "false"))
                        }
                        .padding()
                        .background(.gray.opacity(0.2))
                        .mask(RoundedRectangle(cornerRadius: 15))
                        
                        Spacer()
                    }
                    .padding()
                    
                }
                
            }
            
        }
        .frame(width: content_ctrl.size.width*1/2,
               height: content_ctrl.size.height)
    }
}

