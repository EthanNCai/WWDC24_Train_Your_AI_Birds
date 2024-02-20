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
                                Text("2. Bird's Brain: Neural Networks")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.pink)
                                    
                            }.padding()
                           
                            Text("The Artificial Bird Brain")
                                .font(.title2)
                                .foregroundColor(.indigo)
                                .padding(.horizontal)
                            Text("\n\tTo enable the birds to think and fly based on the environment, we start by equipping each bird in the game with an \"artificial brain\" known as a __neural network.__")
                                .font(.body)
                                .padding(.horizontal)
                            Text("\n\tThe bird's decision-making is driven by its \"artificial brain,\" which can be thought of as a \"black box\" In our experiment, the brain, or neural network, takes in information about the environment as __INPUT__ and generates __OUTPUT__ that represent the probabilities of flying or not flying.")
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
                            Text("\n\tEach neural network is represented by a set of numbers called __WEIGHTS__. These weights determine how the neural network processes inputs and produces outputs. Our objective is to find the optimal weights that enable the bird to fly through the columns accurately. Think of it as discovering the perfect formula for the bird's successful flight.")
                                .font(.body)
                                .padding(.horizontal)
                        }
                    }.frame(width: content_ctrl.size.width*1/2,
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
                
                self.scene.display_reset()
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
