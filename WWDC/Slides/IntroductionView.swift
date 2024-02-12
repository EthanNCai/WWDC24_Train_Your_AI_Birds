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
                    Text("\tThis is a machine learning experiment playground App. In less than three minutes, this app allows you to quickly understand, play with a machine learning model that automatically plays FlappyBird, and experience the process of training this model from scratch. \n\tIn the process, you will definitely gain a better understanding of machine learning, regardless of whether you have any prior knowledge of machine learning or not!")
                    .font(.body)
                    .padding(1)
                
                    Text("What is the Process of the Experience?")
                        .font(.title2)
                        .foregroundColor(.indigo)
                    Text("\tI'll start with a brief introduction to FlappyBrid\n\tThen I'll give a quick and easy introduction to neural networks as well as genetic algorithms, which are key to training our own machine models.\n\tFinally, you'll be free to tweak any of the parameters in a lab environment I've built for you, and experience the whole process of training your own machine learning model!")
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
