//
//  BirdCapsuleTest.swift
//  Train your own bird AI!
//
//  Created by 蔡俊志 on 2024/2/14.
//

import SwiftUI

struct BirdCapsuleTest: View {
    @ObservedObject var content_ctrl: PageContentController
    var body: some View {
        
        ScrollView(.horizontal){
            HStack(spacing: 0){
                if content_ctrl.round_history.count == 0{
                    Text("No History, please launch your experiment")
                        .padding()
                    
                }else{
                    ForEach(content_ctrl.round_history.reversed()) { round in
                        VStack{
                            Text("No.\(round.round)")
                            HStack(spacing: 0){
                                Image(systemName: "pin")
                                Text("\(round.best_distance_score)")
                            }
                            if round.score_trend >= 0{
                                Text("+\(round.score_trend)")
                                    .font(.footnote)
                                    .foregroundColor(.green)
                                    .fontWeight(.heavy)
                            }else{
                                Text("\(round.score_trend)")
                                    .font(.footnote)
                                    .foregroundColor(.red)
                                    .fontWeight(.heavy)
                            }
                            
                        }
                        .padding()
                        .background(){
                            Circle().stroke(lineWidth: 5).fill(round.score_trend >= 0 ? .green : .red)
                        }.padding(.horizontal,8)
                    }
                }
                
            }.padding(7)
        }
    }
}


