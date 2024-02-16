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
                Text("\tThis is the place you could witness the amazingness of birds learning on their own using genetic algorithms!\n\n\t The experiment will go through multiple rounds, and after each round, you'll select the best bird to pass down its excellent genes. Typically, it takes around __8 to 10 rounds__ for the birds to become proficient in flying. Let's get started!")
                Text("\tTry to train a bird that can fly through __8__ columns")
                Button("Let's Begin！", action: {
                    
                    withAnimation(){
                        self.content_ctrl.show_welcome_mat = false
                    }
                    
                    
                    
                })
            }
            
            .padding()
            .frame(maxHeight: .infinity)
            .background(.ultraThickMaterial)
            .mask(RoundedRectangle(cornerRadius: 15))
            .overlay(){
                RoundedRectangle(cornerRadius: 15).stroke().fill(.gray.opacity(0.4))
            }
            .padding()
            .padding()
            
        
        
    }
}

