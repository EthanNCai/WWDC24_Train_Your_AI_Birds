//
//  Intro_1_View.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//
import SpriteKit
import SwiftUI

struct ExperimentPage: View {
    
    @ObservedObject var content_ctrl = PageContentController()
    @State var isSpeeded = false
    var scene: GameScene{
        let scene = GameScene(viewController:content_ctrl)

        scene.size = CGSize(width: content_ctrl.size.width*1/2, height: content_ctrl.size.height*0.9)
        return scene
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                HStack { // info panal & game scene
                    HStack{
                        if content_ctrl.isOnSetting{
                            SettingView(content_ctrl: self.content_ctrl,scene:scene)
                        }else
                        {
                            ObservationView(content_ctrl: self.content_ctrl, scene: scene)
                        }
                    }
                    GameView(content_ctrl: content_ctrl, scene: scene)
                }
                if self.content_ctrl.is_show_notice{
                    NoticeView(content_ctrl: self.content_ctrl)
                }
                if self.content_ctrl.show_welcome_mat{
                    ExperimentHintView(content_ctrl: self.content_ctrl)
                        .padding()
                }
                
                
            }
            .onAppear {
                content_ctrl.size = geometry.size
            }
            .onChange(of: geometry.size) { newSize in
                content_ctrl.size = geometry.size
            }.onAppear(){
                scene.game_wise_experiment_reset()
                content_ctrl.isOnSetting = true
            }
            
            
        }
    }
}
struct Intro_1_View_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentPage()
    }
}
