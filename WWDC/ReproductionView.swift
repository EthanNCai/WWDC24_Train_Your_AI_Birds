//
//  ReproductionView.swift
//  Train your own bird AI!
//
//  Created by 蔡俊志 on 2024/2/14.
//

import SwiftUI

struct ReproductionView: View {
    @ObservedObject var content_ctrl: PageContentController
    var get_new_scene: () -> GameScene
    let scene:GameScene
    @State var is_selected:[Bool] = [false,false,false,false,false,false,false,false,false,false,false,false]
    var body: some View {
        VStack{
            Text("All birds in round 1 was outed!")
                .font(.title)
            
            Text("Please select the best 2-4 birds you think the best for breeding the next generation")
                .font(.title2)
                .padding(.horizontal)
            Text("genes of unselected birds will be considered inferior and discarded.")
                .font(.title2)
            
            HStack{
                VStack{
                    
                    Image(systemName: "pin")
                        .fontWeight(.heavy)
                    Image(systemName: "ruler.fill")
                        .fontWeight(.heavy)
                }
                
                VStack(alignment: .leading){
                    
                    HStack{
                        Text("=  Bird's total distance ")
                        Text("_(Higher the better)_")
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)
                    }
                    
                    HStack{
                        Text("=  Bird's average distance to gap (inverted)")
                        Text("_(Higher the better)_")
                            .fontWeight(.heavy)
                            .foregroundColor(.red)
                    }
                   
                        
                    
                }
                
            }
            
            VStack{
                HStack{
                    ReproductionBirdCard(ball: self.content_ctrl.balls[0],is_selected: self.$is_selected[0])
                        .onTapGesture {
                            self.is_selected[0].toggle()
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[1],is_selected: self.$is_selected[1])
                        .onTapGesture {
                            self.is_selected[1].toggle()
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[2],is_selected: self.$is_selected[2])
                        .onTapGesture {
                            self.is_selected[2].toggle()
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[3],is_selected: self.$is_selected[3])
                        .onTapGesture {
                            self.is_selected[3].toggle()
                        }
                }
                HStack{
                    ReproductionBirdCard(ball: self.content_ctrl.balls[4],is_selected: self.$is_selected[4])
                        .onTapGesture {
                            self.is_selected[4].toggle()
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[5],is_selected: self.$is_selected[5])
                        .onTapGesture {
                            self.is_selected[5].toggle()
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[6],is_selected: self.$is_selected[6])
                        .onTapGesture {
                            self.is_selected[6].toggle()
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[7],is_selected: self.$is_selected[7])
                        .onTapGesture {
                            self.is_selected[7].toggle()
                        }
                }
                HStack{
                    ReproductionBirdCard(ball: self.content_ctrl.balls[8],is_selected: self.$is_selected[8])
                        .onTapGesture {
                            self.is_selected[8].toggle()
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[9],is_selected: self.$is_selected[9])
                        .onTapGesture {
                            self.is_selected[9].toggle()
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[10],is_selected: self.$is_selected[10])
                        .onTapGesture {
                            self.is_selected[10].toggle()
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[11],is_selected: self.$is_selected[11])
                        .onTapGesture {
                            self.is_selected[11].toggle()
                        }
                }
                
            }
            HStack{
                
                
                Text("Breed and go to the next round")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(.green)
                    .mask(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 3)
                    .onTapGesture {
                        
                        self.content_ctrl.is_selecting = false
                
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
    
                            self.content_ctrl.scene_update_ref!.experiment_reset()
                            self.content_ctrl.set_game_begin()
                            self.content_ctrl.counting_down_set_user_begin()    // user begin 3 secs later
                            self.content_ctrl.scene_update_ref!.counting_down_then_set_active()
                        }
                        
                    }
                
                Text("Suggest bird")
                    .padding(.horizontal)
            }
        }
        
        
    }
}

