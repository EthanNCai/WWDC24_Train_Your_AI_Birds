//
//  FourGameView.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/12.
//

import SwiftUI

struct FourGameView: View {
    @ObservedObject var content_ctrl_d1 = PageContentController(display_mode: true, displaying_bird_mlp: SimpleNeuralNetwork(hidden_layer_len: 16))
    @ObservedObject var content_ctrl_d2 = PageContentController(display_mode: true, displaying_bird_mlp: SimpleNeuralNetwork(hidden_layer_len: 16))
    @ObservedObject var content_ctrl_d3 = PageContentController(display_mode: true, displaying_bird_mlp: SimpleNeuralNetwork(hidden_layer_len: 16))
    @ObservedObject var content_ctrl_d4 = PageContentController(display_mode: true, displaying_bird_mlp: SimpleNeuralNetwork(hidden_layer_len: 16))
    var scene1: GameScene{
        let scene = GameScene(viewController:content_ctrl_d1)

        scene.size = CGSize(width: content_ctrl_d1.size.width*0.24, height: content_ctrl_d1.size.width*0.24*2)
        return scene
    }
    var scene2: GameScene{
        let scene = GameScene(viewController:content_ctrl_d2)

        scene.size = CGSize(width: content_ctrl_d2.size.width*0.24, height: content_ctrl_d1.size.width*0.24*2)
        return scene
    }
    var scene3: GameScene{
        let scene = GameScene(viewController:content_ctrl_d3)

        scene.size = CGSize(width: content_ctrl_d3.size.width*0.24, height: content_ctrl_d1.size.width*0.24*2)
        return scene
    }
    var scene4: GameScene{
        let scene = GameScene(viewController:content_ctrl_d4)

        scene.size = CGSize(width: content_ctrl_d4.size.width*0.24, height: content_ctrl_d1.size.width*0.24*2)
        return scene
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FourGameView_Previews: PreviewProvider {
    static var previews: some View {
        FourGameView()
    }
}
