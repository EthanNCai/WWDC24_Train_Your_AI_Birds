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
        VStack{
            
            
            ScrollView{
                
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "hammer.fill")
                        VStack(alignment:.leading){
                            Text("Experiment")
                                .fontWeight(.bold)
                            Text("Test page")
                                .font(.title3)
                            
                        }
                        
                    }
                    
                    .font(.title)
                    .foregroundColor(.pink)
                    
                        Button(action: {
                            self.scene.game_wise_experiment_reset()
                            
                        }){
                            HStack{
                                Image(systemName: "arrow.counterclockwise")
                                Text("Reset Experiment")
                            }
                            .padding(10)
                            .background(.ultraThinMaterial)
                            .mask(RoundedRectangle(cornerRadius: 15))
                            .overlay(){
                                RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 4).fill(.gray)
                            }
                           
                            .fontWeight(.heavy)
                        }
                        .padding(5)
                        .buttonStyle(.plain)
                        
                       
                    
                    HStack{
                        
                        Text("Generation History")
                            .font(.title3)
                            .padding(2)
                            .foregroundColor(.indigo)
                        Spacer()
                    }
                    
                    
                    
                    
                    
                    Divider()
                    HStack{
                        
                        Text("Bird Status")
                            .font(.title3)
                            .foregroundColor(.indigo)
                            .padding(2)
                        Spacer()
                       
                    }
                    
                    HStack{
                        VStack{
                            
                            Image(systemName: "pin")
                                .fontWeight(.heavy)
                            Image(systemName: "ruler.fill")
                                .fontWeight(.heavy)
                        }
                        VStack(alignment: .leading){
                            
                            Text("=  Bird's total distance (higher the better)")
                                .fontWeight(.heavy)
                            Text("=  Bird's average distance to gap (lower the better)")
                                .fontWeight(.heavy)
                            
                        }
                        
                    }
                    BallBoard(balls: self.$content_ctrl.balls)
                    Divider()
                    //            HStack{
                    //                Text("BestGenes")
                    //                    .font(.title2)
                    //                    .fontWeight(.heavy)
                    //                    .padding(2)
                    //                Spacer()
                    //            }
                    //            Text("this place will count the farest bird and display visulize it's gene segment this section displayed some round informations, indicating the on-screen bird situation")
                    //                .font(.caption2)
                    //                .fontWeight(.light)
                    //            GeneBoard()
                    
                    
                }
            }
            .padding()
            
        }
        .frame(width: content_ctrl.size.width*1/2,
               height: content_ctrl.size.height)
    }
}


