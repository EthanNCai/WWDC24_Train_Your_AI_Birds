//
//  PageContentController.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//

import Foundation


class PageContentController: ObservableObject {
    
    
    @Published var isBegin:Bool = false
    @Published var isTapBegin:Bool = false
    @Published var isReset:Bool = false
    @Published var isGameOver:Bool = false
    @Published var isOnSetting:Bool = true
    @Published var size:CGSize = .zero
    
    // debug infos
    @Published var bannerContent: String = "~ Tap to begin ~"
    @Published var distance_score:Float = 0.123
    @Published var velocity:Float = 1.23
    @Published var current_focus:Int = 0
    @Published var distance_u:Float = 0.123
    @Published var distance_d:Float = 0.123
    
    //Retrive for GAME SCENE
    @Published var ui_bird_number: Int = 10
    @Published var ui_bird_radius: Float = 10
    @Published var ui_bird_speed: Float = 10
    @Published var ui_selected_best_ratio: best_ratio = .x1
    @Published var ui_mutate_proab: Float = 0.1
    
    // for GAME SCENE
    var difficulty_index: CGFloat = 0.0
    var bird_speed_index: CGFloat = 0.0
    var bird_size_index: CGFloat = 0.0
    var best_bird_needed: Int = 0
    var bird_number: Int = 0
    var mutate_proab: Float = 0.0
    
    // bird
    @Published var jump_prob: Float = -1
    @Published var not_jump_prob: Float = -1
    
    // round
    @Published var balls: [Ball] = []
    @Published var parallel_balls: Int = 1
    @Published var ball_remaining:Int = 1
    
    // training
    @Published var best_3_balls:[Ball] = []
    @Published var best_2_balls:[Ball] = []
    @Published var rounds: Int = 1
    
    let count_down: Float = 2.0
    
    func acc_distance_score(new_score:Float){
        self.balls[0].distance_score += new_score
  
    }
    
    func done_setting(){
        
        // retieve from UI
        self.bird_number = ui_bird_number
        self.mutate_proab = ui_mutate_proab
        self.bird_size_index = sizeIndexMapping(value: self.ui_bird_radius)
        self.bird_speed_index = speedIndexMapping(value: self.ui_bird_speed)
        self.setBestBirdNumbers()
        
        
        print("birdNumber:", bird_number)
        print("mutateProb:", mutate_proab)
        print("birdSizeIndex:", bird_size_index)
        print("birdSpeedIndex:", bird_speed_index)
        print("bestBirdNeeded:", best_bird_needed)
        
    }
    
    
    func reset() {
        
        // reset don't incluede the setting reset
        isReset = false
        isTapBegin = false
        isBegin = false
        isGameOver = false
        balls.removeAll()
        bannerContent = "~ Tap to begin ~"
    
    }
    
    func decrease_ball_count(){
        
        self.ball_remaining -= 1
        
        if self.ball_remaining == 1 || self.ball_remaining == 0 || self.ball_remaining == 2{
            if self.ball_remaining == 2{
                // collect for best_3_balls
                
            }
            // collect for both
            
            
        }
    }
    
    func sizeIndexMapping(value: Float) -> CGFloat {
        // gap height*0.3
        let inputMin: Float = 0
        let inputMax: Float = 20
        let outputMin: Float = Float(self.size.height * (0.3 - 0.28))
        let outputMax: Float = Float(self.size.height * (0.3 - 0.25))
        
        let normalizedValue = (value - inputMin) / (inputMax - inputMin)
        let mappedValue = (outputMax - outputMin) * normalizedValue + outputMin
        
        return CGFloat(mappedValue)
    }
    
    func speedIndexMapping(value: Float) -> CGFloat {
        let inputMin: Float = 0
        let inputMax: Float = 20
        let outputMin: Float = 0.004
        let outputMax: Float = 0.006
        
        let normalizedValue = (value - inputMin) / (inputMax - inputMin)
        let mappedValue = (outputMax - outputMin) * normalizedValue + outputMin
        
        return CGFloat(mappedValue)
    }
    
    func setBestBirdNumbers(){
        
        self.best_bird_needed =  Int(Float(self.ui_bird_number) * self.ui_selected_best_ratio.rawValue)
        
    }
    
    
    
    func setCountingDown() {
        
        let timeToGo = TimeInterval(self.count_down)
        
        self.isTapBegin = true
        DispatchQueue.main.async {
            self.bannerContent = "Counting down 3..."
            DispatchQueue.main.asyncAfter(deadline: .now() + (timeToGo / 3)) {
                self.bannerContent = "Counting down 2..."
                DispatchQueue.main.asyncAfter(deadline: .now() + (timeToGo / 3)) {
                    self.bannerContent = "Counting down 1..."
                    DispatchQueue.main.asyncAfter(deadline: .now() + timeToGo / 3) {
                        self.isBegin = true
                    }
                }
            }
        }
    }
    func setGameOver(){
        
        self.bannerContent = " Game Over \n touch to reset"
        self.isBegin = false
        self.isTapBegin = false
    }
}
