//
//  InGameView.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/4.
//

import SwiftUI

struct ObservationView: View {
    @ObservedObject var content_ctrl: PageContentController
    let scene:GameScene
    var body: some View {
        ScrollView{
            
            VStack(alignment: .leading){
                HStack{
                    Button(action: {
                        
                        withAnimation(){
                            self.content_ctrl.isOnSetting = true
                        }
                        self.scene.game_wise_reset_everything()
                        
                    
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
                    Text("Round Counts : \(self.content_ctrl.rounds_count)")
                }.padding(1)
                HStack{
                    Image(systemName: "bird.fill")
                    Text("Remaining : \(self.content_ctrl.ball_remaining)")
                }.padding(1)
                HStack{
                    Text("Best distance : \(Int(self.content_ctrl.best_distance))")
                }.padding(1)
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


