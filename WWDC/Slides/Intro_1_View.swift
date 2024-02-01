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
                            .onDisappear(){
                                self.pageContentController.reset()
                            }
                        
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
                                        Image(systemName: "arrow.clockwise.circle")
                                        Text("Reset")
                                    }
                                Toggle(isOn: $isSpeeded) {
                                    Text("10x Fast forward")
                                }.toggleStyle(SwitchToggleStyle())
                                    .padding(.horizontal)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(5) // 设置按钮的圆角半径
                            }
                            .padding()
                            
                         
                        
                        }
                        //debug info
                        HStack{
                            Spacer()
                            VStack{
                                VStack(alignment: .leading){
                                
                                    Text("__Debug infos__")
                                        .foregroundColor(.green)
                                    Text("Current Focus -> " + String(self.pageContentController.current_focus))
                                    Text("Distanse Upper -> " + String(format: "%.1f", self.pageContentController.distance_u))
                                    Text("Distanse Downer -> " + String(format: "%.1f", self.pageContentController.distance_d))
                                    Text("Velocity -> ")
                                    Text("Decision -> ")
                                    Text("Distance -> " + String(format: "%.1f", self.pageContentController.distance_score))
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
