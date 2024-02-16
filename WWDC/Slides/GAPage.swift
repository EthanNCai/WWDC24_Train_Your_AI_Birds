//
//  IntroductionPage.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/11.
//

import SwiftUI

struct GAPage: View {
    
    var body: some View {
        ScrollView{
            HStack{
            VStack(alignment: .leading){
                
                    HStack(spacing: 1){
                    
                        Image(systemName:"atom")
                        Text("3. Genetic Algorithm")
                            
                    }
                    .fontWeight(.heavy)
                    .font(.title)
                    .foregroundColor(.pink)
                    .padding(4)
                    Text("How does a machine learn a good neural network?")
                        .font(.title2)
                        .foregroundColor(.indigo)
                    Text("\tUpon realizing that our aim is to discover excellent neural network weights that enable the bird to fly accurately, we must establish a method for the bird to autonomously seek out these desired weights through trial and error. Inspired by Darwin's theory of evolution, we adopt the concept of __\"survival of the fittest,\"__ where the most capable individuals thrive while the less competent ones are eliminated.\n\n\tIn machine learning, this method is known as a __Genetic Algorithm__")
                    
                    .padding(1)
                    
                    Text("Genetic Algorithm: The fittest survives...")
                        .font(.title2)
                        .foregroundColor(.indigo)
                    Image("darvin")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .padding()
                    .padding(.horizontal)
                    
                
                Text("\tAs shown above. Long ago, giraffes didn't have long necks. But in their environment filled with tall foliage, giraffes with longer necks were more likely to survive. As a result, they passed on the genetic trait for longer necks to future generations.")
                    
                    .padding(1)
                
                Image("darvin_bird")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .padding()
                .padding(.horizontal)
                
                    Text("\tGenetic algorithms mimic this process. In genetic algorithms, the ability to adapt to the environment is called  \"fitness.\" When training the neural network of Flappy Birds, we can measure fitness based on the birds' \"fitness\" In each iteration, we select the top-performing birds that have survived the longest and breed them by combining their __neural network weights(aka genes)__ through cross-reorganization and introducing genetic mutations. This process generates new better offspring birds. so on and so forth\n\n\t As we repeat this process over time, our bird population will become increasingly skilled at playing Flappy Bird!")
                    .font(.body)
                    
                    
                        
                
                    
                        
                    
            }.padding()
                Spacer()
            }
        }
    }
}

struct GA_Previews: PreviewProvider {
    static var previews: some View {
        GAPage()
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
