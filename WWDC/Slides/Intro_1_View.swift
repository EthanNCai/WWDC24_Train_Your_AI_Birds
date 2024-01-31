//
//  Intro_1_View.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//
import SpriteKit
import SwiftUI

struct Intro_1_View: View {
    
    @ObservedObject var pageContentController = PageContentController()
    @State var isSpeeded = false
    var scene: GameScene{
        let scene = GameScene(viewController:pageContentController)

        scene.size = CGSize(width: pageContentController.size.width*3/5, height: pageContentController.size.height)
        return scene
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack {
                    Text("text_field")
                        .frame(width: pageContentController.size.width*2/5,
                               height: pageContentController.size.height)
                    .background(.blue)
                    
                    
                    ZStack{
                        
                        // gamelayer
                        SpriteView(scene: scene)
                            .mask(RoundedRectangle(cornerRadius: 15))
                            .padding(.vertical,10)
                            .padding(.trailing,10)
                        
                        // banner
                        
                        if !pageContentController.isBegin {
                            Text(pageContentController.bannerContent)
                                .padding()
                                .background(.ultraThinMaterial)
                                .mask(RoundedRectangle(cornerRadius: 10))
                                
                        }
                        
                        
                        
                        // gauges
                        VStack{
                            
                            // gauges Top
                            HStack{
                                Text("Scores: 0")
                                    .padding()
                                Spacer()
                            }
                            .padding(.vertical)
                            Spacer()
                            
                            
                            // gauges Buttom
                            HStack{
                                Button(action: {
                                    self.pageContentController.isReset = true
                                    //self.scene.resetGame()
                                    }) {
                                        Text("Reset")
                                    }
                                    .background(Color.red) // 设置背景颜色为红色
                                    .cornerRadius(10) // 设置按钮的圆角半径
                                
                                
                                Toggle(isOn: $isSpeeded) {
                                    Text("10x Fast forward")
                                }.toggleStyle(SwitchToggleStyle())
                            }
                            .padding()
                        }
                    }
                }
            }
            .onAppear {
                pageContentController.size = geometry.size
            }
            .onChange(of: geometry.size) { newSize in

                pageContentController.size = geometry.size
            }
            
            Text("父视图的大小：\(Int(pageContentController.size.width)) x \(Int(pageContentController.size.height))")
                .foregroundColor(.white)
                .padding()
        }
    }
}
struct Intro_1_View_Previews: PreviewProvider {
    static var previews: some View {
        Intro_1_View()
    }
}
