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
                        self.scene.game_wise_experiment_reset()
                        
                    
                    }){
                        HStack{
                            Image(systemName: "chevron.left")
                            Text("Adjust training settings")
                        }
                    }
                    Spacer()
                }
                HStack{
                    Image(systemName: "bird.fill")
                    Text("Last Bird Generation Info.")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding(2)
                    Spacer()
                }
                Text("this section displayed some round informations")
                    .font(.caption2)
                    .fontWeight(.ultraLight)
                HStack{
                    
                    if self.content_ctrl.best_distance_score == 0 {
                        Text("Best Flying Distance: --")
                    } else {
                        
                        if self.content_ctrl.best_distance_score_trend >= 0{
                            Text("Best Flying Distance: \(Int(self.content_ctrl.best_distance_score))")
                            Text("(+\(Int(self.content_ctrl.best_distance_score_trend)))")
                                .foregroundColor(.green)
                        }else{
                            Text("Best Flying Distance: \(Int(self.content_ctrl.best_distance_score))")
                            Text("(\(Int(self.content_ctrl.best_distance_score_trend)))")
                                .foregroundColor(.red)
                        }
                    }
                }
                HStack {
                    
                    if self.content_ctrl.avg_distance_score == 0 {
                        Text("Avg. Flying Distance: --")
                    } else {
                        if self.content_ctrl.avg_distance_score_trend >= 0{
                            Text("Avg. Flying Distance: \(Int(self.content_ctrl.avg_distance_score))")
                            Text("(+\(Int(self.content_ctrl.avg_distance_score_trend)))")
                                .foregroundColor(.green)
                        }else{
                            Text("Avg. Flying Distance: \(Int(self.content_ctrl.avg_distance_score))")
                            Text("(\(Int(self.content_ctrl.avg_distance_score_trend)))")
                                .foregroundColor(.red)
                        }
                    }
                }

                HStack {
                    if self.content_ctrl.best_fitness_score == 0 {
                        Text("Best Fitness Score: --")
                    } else {
                        if self.content_ctrl.best_fitness_score_trend >= 0{
                            Text("Best Fitness Score: \(Int(self.content_ctrl.best_fitness_score))")
                            Text("(+\(Int(self.content_ctrl.best_fitness_score_trend)))")
                                .foregroundColor(.green)
                        }else{
                            Text("Best Fitness Score: \(Int(self.content_ctrl.best_fitness_score))")
                            Text("(\(Int(self.content_ctrl.best_fitness_score_trend)))")
                                .foregroundColor(.red)
                        }
                    }
                }

                HStack {
                    if self.content_ctrl.avg_fitness_score == 0 {
                        Text("Avg. Fitness Score: --")
                    } else {
                        if(self.content_ctrl.avg_fitness_score_trend >= 0)
                        {
                            Text("Avg. Fitness Score: \(Int(self.content_ctrl.avg_fitness_score))")
                            Text("(+\(Int(self.content_ctrl.avg_fitness_score_trend)))")
                                .foregroundColor(.green)
                        }else
                        {
                            Text("Avg. Fitness Score: \(Int(self.content_ctrl.avg_fitness_score))")
                            Text("(\(Int(self.content_ctrl.avg_fitness_score_trend)))")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            
            
            Divider()
            HStack{
                Image(systemName: "bird.fill")
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
        .padding()
            .frame(width: content_ctrl.size.width*1/2,
                   height: content_ctrl.size.height)
    }
}


