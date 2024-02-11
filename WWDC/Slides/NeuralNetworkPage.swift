//
//  Intro_2_View.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//

import SwiftUI

struct NeuralNetworkPage: View {
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
                
                    ScrollView{
                        
                        
                        VStack(alignment: .leading){
                            HStack{
                                Image(systemName: "brain")
                                    .font(.title)
                                    .foregroundColor(.pink)
                                    .fontWeight(.heavy)
                                Text("Bird's Brain: Neural Networks")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.pink)
                                    
                            }.padding()
                           
                            Text("The Artificial Bird Brain")
                                .font(.title2)
                                .foregroundColor(.indigo)
                                .padding(.horizontal)
                            Text("\n\tWe fisrt need to give each bird in the game an _artificial brain_, which is something called a __neural network__.")
                                .font(.body)
                                .padding(.horizontal)
                            Text("\n\tThis brain determines how the bird will decide its behavior based on its external environment. So you can think of a neural network as a __black box__. In our experiment, there are three inputs and two outputs, the inputs are information about the __environment__  and the outputs are the __probabilities of flying or not flying.__")
                                .font(.body)
                                .padding(.horizontal)
                            ZStack{
                                NeuralNetworkExplanation(content_ctrl: self.content_ctrl)
                                if !self.content_ctrl.isGameBegin{
                                    Text("Click on the _Tap To Play_ on the right to observe intuitively how a pretrined bird neural network operates.")
                                        .font(.title2)
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .mask(RoundedRectangle(cornerRadius: 15))
                                        .overlay(){
                                            RoundedRectangle(cornerRadius: 15).stroke().fill(.gray.opacity(0.4))
                                        }
                                        .padding()
                                }
                            }.frame(width: content_ctrl.size.width*1/2)
                            Text("Weights of the neural network")
                                .font(.title2)
                                .foregroundColor(.indigo)
                                .padding(.horizontal)
                            Text("\n\tEach neural network is determined by a set of __numbers__ ( aka __weights__). This set of numbers will guide the neural network on __how to compute inputs into outputs__. \n\n\tSo our goal is to find the optimal set of numbers for the neural network that will allow the bird to fly correctly between the columns.")
                                .font(.body)
                                .padding(.horizontal)
                        }
                    }.frame(width: content_ctrl.size.width*1/2,
                            height: content_ctrl.size.height)
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
        NeuralNetworkPage()
    }
}
