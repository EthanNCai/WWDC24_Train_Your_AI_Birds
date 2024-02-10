//
//  Intro_2_View.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//

import SwiftUI

struct DisplayPage: View {
    @ObservedObject var content_ctrl = PageContentController(display_mode: true, displaying_bird_mlp: SimpleNeuralNetwork(hidden_layer_len: 16))
    @State var isSpeeded = false
    var scene: GameScene{
        let scene = GameScene(viewController:content_ctrl)

        scene.size = CGSize(width: content_ctrl.size.width*1/2, height: content_ctrl.size.height)
        return scene
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                HStack { // info panal & game scene
                    NeuralNetworkExplanation(content_ctrl: self.content_ctrl)
                    GameView(content_ctrl: content_ctrl, scene: scene)
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

struct Intro_2_View_Previews: PreviewProvider {
    static var previews: some View {
        DisplayPage()
    }
}
