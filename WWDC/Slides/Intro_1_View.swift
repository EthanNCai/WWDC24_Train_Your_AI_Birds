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

        scene.size = CGSize(width: pageContentController.size.width*1/2, height: pageContentController.size.height)
        return scene
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack {
                    
                    VStack{
                        ScrollView{
                            HStack{
                                Text("Bird Status")
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .padding(2)
                                Spacer()
                            }
                            BallBoard(balls: self.$pageContentController.balls)
                                Divider()
                            
                        }
                        .padding()
                            .frame(width: pageContentController.size.width*1/2,
                                   height: pageContentController.size.height*(1/2))
                        
                        ScrollView{
                            HStack{
                                Text("Gene:")
                                ParamVisulizer()
                                Image(systemName: "ellipsis")
                            }
                            
                            HStack{
                                Text("Gene:")
                                ParamVisulizer()
                                Image(systemName: "ellipsis")
                            }
                            
                        }
                        .padding()
                            .frame(width: pageContentController.size.width*1/2,
                                   height: pageContentController.size.height*(1/2))
                    }
                    
                    
                    
                    ZStack{
                        
                        // gamelayer
                        SpriteView(scene: scene)
                            .mask(RoundedRectangle(cornerRadius: 15))
                            .padding(.vertical,10)
                            .padding(.trailing,10)
                            .onDisappear(){
                                self.pageContentController.reset()
                            }
                            .onChange(of: scene.size) { newSize in
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
                                    Text("jump_probabiliry -> " + String(format: "%.2f",self.pageContentController.jump_prob))
                                    Text("idle_probabiliry -> " + String(format: "%.2f",self.pageContentController.not_jump_prob))
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
            
            
        }
    }
}
struct Intro_1_View_Previews: PreviewProvider {
    static var previews: some View {
        Intro_1_View()
    }
}
