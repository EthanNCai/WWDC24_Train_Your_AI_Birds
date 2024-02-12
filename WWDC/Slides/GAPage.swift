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
                    Text("\tBut how can we find the optimal neural network weights as explained on the previous page?\n\n\tWe can leverage Darwin's theory of evolution to allow the initially stupid bird to gradually evolve and iterate through constant trial and error. This method of allowing machines to learn is called a genetic algorithm(GA)")
                    .font(.body)
                    .padding(1)
                    
                    Text("Genetic Algorithm: The best survives...")
                        .font(.title2)
                        .foregroundColor(.indigo)
                    Image("darvin")
                
                Text("\tAs shown in the picture. Many years ago giraffes did not have long necks. Due to the high foliage in their environment, giraffes with long necks were more likely to survive, thus passing on the long neck excellence gene to the next generation.")
                    .font(.body)
                    .padding(1)
                
                HStack{
                    
                }
                
                    Text("\tIn genetic algorithms, the ability to adapt to the environment is called __Fitness__. When we train FlappyBrids' neural network, we can set the fitness to the __survival time__ of the birds. In each iteration, we take the best birds that have survived the longest and breed them (cross-reorganization of the weights of their neural networks, and genetic mutation) thus obtaining new offspring birds.\n\n\tTo summarize. What we need is an __initial population__ with random genes, a reasonable __Algorithms for calculating Fitness of individuals__ for selecting superior individuals, and a reasonable __probability of genetic variation__ to increase the randomness. This way we can slowly evolve the superior individuals each round of the game")
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
