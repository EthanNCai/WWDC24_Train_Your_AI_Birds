//
//  Intro_2_View.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//

import SwiftUI

struct FlappyBirdPage: View {
    @ObservedObject var content_ctrl = PageContentController(play_mode:  true)
    @State var isSpeeded = false
    var scene: GameScene{
        let scene = GameScene(viewController:content_ctrl)

        scene.size = CGSize(width: content_ctrl.size.width*1/2, height: content_ctrl.size.height*0.8)
        return scene
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                HStack { // info panal & game scene
                    //NeuralNetworkExplanation(content_ctrl: self.content_ctrl)
                    FlappyBirdExplainView()
                    .frame(width: content_ctrl.size.width*1/2,
                            height: content_ctrl.size.height)
                    GameView(content_ctrl: content_ctrl, scene: scene)
                        .frame(maxWidth: content_ctrl.size.width*1/2,maxHeight: content_ctrl.size.height * (0.9))
                }
                if self.content_ctrl.is_show_notice{
                    NoticeView(content_ctrl: self.content_ctrl)
                }
                
            }
            .onAppear {
                content_ctrl.size = geometry.size
            }
            .onChange(of: geometry.size) { newSize in
                content_ctrl.size = geometry.size
            }
            .onAppear(){
                content_ctrl.isGameOver = true
            }
            
            
        }
    }
}

