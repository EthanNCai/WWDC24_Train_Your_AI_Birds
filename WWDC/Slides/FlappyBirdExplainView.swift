//
//  FlappyBirdExplainView.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/11.
//

import SwiftUI

struct FlappyBirdExplainView: View {
    var body: some View {
        ScrollView{
            HStack{
            VStack(alignment: .leading){
                
                    HStack(spacing: 1){
                        Image(systemName: "bird")
                            .font(.title)
                            .foregroundColor(.orange)
                        Text("What's FlappyBird")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.orange)
                        
                    }.padding(4)
                    Text("\t Our goal is to design a machine learning model that automatically plays FlappyBrid, but first we need to understand the FlappyBrid game.\n\tFlappyBird is a very simple and well-known game, __SKIP THIS PAGE__ if you already know how to play it. \n\n\tIf you haven't played it before, the rules are: \n\t_(1)Tap the screen to make the bird go up\n\t(2)Keep the bird away from the column.._ \tYou can try the game on the right to get a understanding of the rules, but __DON'T PLAY FOR TOO LONG__ because that's not the point of this app.")
                    .font(.body)
                    .padding(1)
                
                    
                        
                    
            }.padding()
                Spacer()
            }
        }
    
    }
}

struct FlappyBirdExplainView_Previews: PreviewProvider {
    static var previews: some View {
        FlappyBirdExplainView()
    }
}
