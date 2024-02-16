//
//  ReproductionView.swift
//  Train your own bird AI!
//
//  Created by 蔡俊志 on 2024/2/14.
//

import SwiftUI

struct ReproductionView: View {
    @State private var show_shadow = false
    @State private var min_alert = false
    @State private var max_alert = false
    @ObservedObject var content_ctrl: PageContentController
    var get_new_scene: () -> GameScene
    let scene:GameScene
    @State var is_selected: [Bool] = Array(repeating: false, count: 12)
    
    func check_larger_than_four() -> Bool{
        var selected_count:Int = 0
        for selection in self.is_selected{
            if selection == true{
                selected_count += 1
            }
        }
        if selected_count > 4{
            return false
        }else{
            return true
        }
        
    }
    var body: some View {
        VStack{
            Text("All birds in round \(content_ctrl.rounds_count) was outed!")
                .font(.title)
            
            Text("Please select the best 2-5 birds you think the best for breeding the next generation")
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
                            if check_larger_than_four() || self.is_selected[0]{
                                self.is_selected[0].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[1],is_selected: self.$is_selected[1])
                        .onTapGesture {
                            if check_larger_than_four() || self.is_selected[1]{
                                self.is_selected[1].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[2],is_selected: self.$is_selected[2])
                        .onTapGesture {
                            if check_larger_than_four() || self.is_selected[2]{
                                self.is_selected[2].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[3],is_selected: self.$is_selected[3])
                        .onTapGesture {
                            if check_larger_than_four() || self.is_selected[3]{
                                self.is_selected[3].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                }
                HStack{
                    ReproductionBirdCard(ball: self.content_ctrl.balls[4],is_selected: self.$is_selected[4])
                        .onTapGesture {
                            if check_larger_than_four() || self.is_selected[4]{
                                self.is_selected[4].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[5],is_selected: self.$is_selected[5])
                        .onTapGesture {
                            if check_larger_than_four() || self.is_selected[5]{
                                self.is_selected[5].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[6],is_selected: self.$is_selected[6])
                        .onTapGesture {
                            if check_larger_than_four() || self.is_selected[6]{
                                self.is_selected[6].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[7],is_selected: self.$is_selected[7])
                        .onTapGesture {
                            if check_larger_than_four() || self.is_selected[7]{
                                self.is_selected[7].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                }
                HStack{
                    ReproductionBirdCard(ball: self.content_ctrl.balls[8],is_selected: self.$is_selected[8])
                        .onTapGesture {
                            if check_larger_than_four() || self.is_selected[8]{
                                self.is_selected[8].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[9],is_selected: self.$is_selected[9])
                        .onTapGesture {
                            
                            if check_larger_than_four() || self.is_selected[9]{
                                self.is_selected[9].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[10],is_selected: self.$is_selected[10])
                        .onTapGesture {
                            if check_larger_than_four() || self.is_selected[10] {
                                self.is_selected[10].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                    ReproductionBirdCard(ball: self.content_ctrl.balls[11],is_selected: self.$is_selected[11])
                        .onTapGesture {
                            if check_larger_than_four() || self.is_selected[11]{
                                self.is_selected[11].toggle()
                            }else{
                                max_alert = true
                            }
                        }
                }
                
            } .alert(isPresented: $max_alert) {
                Alert(
                    title: Text("Warning"),
                    message: Text("Select up to 5 birds"),
                    primaryButton: .default(Text("OK")),
                    secondaryButton: .cancel()
                )
            }
            HStack{
                
                Button(action: {
                    
                    var selected_count:Int = 0
                    for selection in self.is_selected{
                        if selection == true{
                            selected_count += 1
                        }
                    }
                    if selected_count < 2 || selected_count > 5{
                        
                        self.min_alert = true
                        
                    }else{
                        
                        withAnimation(){
                            self.content_ctrl.is_selecting = false
                            
                        }
                        
                        // add best things
                        
                        self.content_ctrl.best_balls.removeAll()
                        for (index, selection) in self.is_selected.enumerated(){
                            if selection == true{
                                let ball = self.content_ctrl.balls[index]
                                self.content_ctrl.best_balls.append(ball)
                            }
                        }
                        

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                            
                            self.content_ctrl.scene_update_ref!.experiment_reset()
                            self.content_ctrl.set_game_begin()
                            self.content_ctrl.counting_down_set_user_begin()    // user begin 3 secs later
                            self.content_ctrl.scene_update_ref!.counting_down_then_set_active()
                        }
                    }
                    
                }){
                    Text("Breed and go to the next round")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.green)
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: show_shadow ? 5 : 0)
                        
                        
                }
                .onHover{
                    is_hover in
                    show_shadow = is_hover
                }
                .buttonStyle(.plain)
               
                .alert(isPresented: $min_alert) {
                        Alert(
                            title: Text("Warning"),
                            message: Text("At least choose 2 birds for breeding"),
                            primaryButton: .default(Text("OK")),
                            secondaryButton: .cancel()
                        )
                    }
                Button(action: {
                    /*
                     
                     for index ....
                     self.is_selected
                     .....
                     
                     */
                    for index in 0..<self.is_selected.count {
                        withAnimation(){
                            self.is_selected[index] = false
                        }
                    }
                    for suggest_bird in self.content_ctrl.best_balls_suggest{
                        for (index, bird) in self.content_ctrl.balls.enumerated(){
                            if suggest_bird.id == bird.id{
                                withAnimation(){
                                    self.is_selected[index] = true
                                }
                               
                            }
                        }
                    }
                    
                }){
                    Text("Suggested birds")
                        .padding(.horizontal)
                }
                
            }
        }
        
        
    }
}

