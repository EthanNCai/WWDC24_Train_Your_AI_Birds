//
//  IntroductionPage.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/11.
//

import SwiftUI

struct IntroductionView: View {
    var body: some View {
        ScrollView{
            HStack{
            VStack(alignment: .leading){
                
                    HStack(spacing: 1){
                        Image(systemName: "swift")
                            .font(.largeTitle)
                            .padding(1)
                            .foregroundColor(.orange)
                           
                            
                        Text("Welcome to your Bird Machine Learning Lab") 
                            .fontWeight(.heavy)
                            .font(.title)
                            
                        
                    }.padding(4)
                    
                    .foregroundColor(.orange)
                    Text("What does this app do?")
                        .font(.title2)
                        .foregroundColor(.indigo)
                    Text("\tThis is a machine learning experiment playground app. In less than three minutes, you can easily grasp and interact with a machine learning model that plays Flappy Bird automatically. You will also experience the __ENTIRE TRAINING PROCESS__ of this model, starting from scratch. Regardless of your prior knowledge of machine learning, this app guarantees a better understanding of the machine learning!")
                    .font(.body)
                    .padding(1)
                
                    Text("What is the Process of the Experience?")
                        .font(.title2)
                        .foregroundColor(.indigo)
                    Text("\tWe will start by introducing Flappy Bird.\n\t Then, I'll give you a simple and straightforward explanation of neural networks and genetic algorithms, which are crucial for training our machine learning models. \n\tFinally, you'll have the opportunity to easily tweak the settings in a specially designed lab environment and witness the entire process of training your own machine learning model!")
                    .font(.body)
                    .padding(1)
                        
                    
            }.padding()
                Spacer()
            }
        }
    }
}

struct IntroductionPage_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView()
    }
}

/*
 
 Paradigm
 
 struct IntroductionPage: View {
     var body: some View {
         ScrollView{
             HStack(spacing: 1){
                 Image(systemName: "bird.fill")
                 Text("Bird & Game settings")
                     .font(.title2)
                     .fontWeight(.heavy)
                     .padding(2)
                     
                 Spacer()
             }
             .padding()
         }.frame(width: 450,height: 600)
     }
 }
 */
