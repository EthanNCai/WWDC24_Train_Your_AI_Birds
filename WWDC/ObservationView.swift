//
//  InGameView.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/4.
//

import SwiftUI

struct ObservationView: View {
    @ObservedObject var content_ctrl: PageContentController
    var body: some View {
        ScrollView{
            
            VStack(alignment: .leading){
                HStack{
                    Button(action: {
                        
                        withAnimation(){
                            self.content_ctrl.isOnSetting = true
                        }
                        
                    }){
                        HStack{
                            Image(systemName: "chevron.left")
                            Text("Adjust training settings")
                        }
                    }
                    Spacer()
                }
                HStack{
                    Text("Round Info.")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding(2)
                    Spacer()
                }
                Text("this section displayed some round informations")
                    .font(.caption2)
                    .fontWeight(.ultraLight)
                HStack{
                    
                    Text("Round Counts : 13")
                }.padding(.horizontal,5)
                HStack{
                    Image(systemName: "bird.fill")
                    Text("Remaining : 8")
                }.padding(.horizontal,5)
            }
            
            
            Divider()
            HStack{
                Text("Bird Status")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(2)
                Spacer()
            }
            Text("this section displayed some round informations, indicating the on-screen bird situation")
                .font(.caption2)
                .fontWeight(.light)
            BallBoard(balls: self.$content_ctrl.balls)
                Divider()
            HStack{
                Text("BestGenes")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(2)
                Spacer()
            }
            Text("this place will count the farest bird and display visulize it's gene segment this section displayed some round informations, indicating the on-screen bird situation")
                .font(.caption2)
                .fontWeight(.light)
            GeneBoard()
            
        }
        .padding()
            .frame(width: content_ctrl.size.width*1/2,
                   height: content_ctrl.size.height)
    }
}


