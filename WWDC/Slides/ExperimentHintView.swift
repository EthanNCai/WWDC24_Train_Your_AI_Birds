//
//  ExperimentHintview.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/11.
//

import SwiftUI

struct ExperimentHintView: View {
    @ObservedObject var content_ctrl: PageContentController
    var body: some View {
        
            VStack{
                Text("Welcome to your machine learning playground. ")
                    .font(.title)
                    .fontWeight(.heavy)
                Text("\tThis is the place you could witness the amazingness of birds learning on their own using genetic algorithms!\n\n\t The experiment offers a number of options for modifying the __bird, the environment, also, the algorithm.__ You are free to explore tweaking them, but it's BEST to start the experiment with the __default settings__ first as a trial before you begin!")
                Button("Let's Begin！", action: {
                    
                    withAnimation(){
                        self.content_ctrl.show_welcome_mat = false
                    }
                    
                    
                    
                })
            }
            
            .padding()
            .frame(maxHeight: .infinity)
            .background(.ultraThinMaterial)
            .mask(RoundedRectangle(cornerRadius: 15))
            .overlay(){
                RoundedRectangle(cornerRadius: 15).stroke().fill(.gray.opacity(0.4))
            }
            .padding()
            .padding()
            
        
        
    }
}

