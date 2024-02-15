//
//  Intro_2_View.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//

import SwiftUI

struct IntroductionPage: View {
    @ObservedObject var content_ctrl = PageContentController(play_mode:  true)
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
                    //NeuralNetworkExplanation(content_ctrl: self.content_ctrl)
                    IntroductionView()
                    .frame(width: content_ctrl.size.width*1/2,
                            height: content_ctrl.size.height)
                    Image("post")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .mask( RoundedRectangle(cornerRadius: 20))
                        .overlay(){
                            RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 5).fill( .red.opacity(0.8))
                        }
                        .padding()
                        .overlay(){
                            
                                VStack{
                                    Text( "Birds' now controlled by itself")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(5)
                                        .padding(.horizontal)
                                        .background( .red)
                                        .mask(RoundedRectangle(cornerRadius: 11))
                                    Spacer()
                                    
                                }
                            
                        }
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

struct PlayPage_View_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionPage()
    }
}
