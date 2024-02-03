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
    
    @Published var size:CGSize = .zero
    
    // debug infos
    @Published var score: Int = 0
    @Published var bannerContent: String = "~ Tap to begin ~"
    @Published var distance_score:Float = 0.123
    @Published var velocity:Float = 1.23
    @Published var current_focus:Int = 0
    @Published var distance_u:Float = 0.123
    @Published var distance_d:Float = 0.123
    
    
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
    
    func reset() {
        isReset = false
        isBegin = false
        isTapBegin = false
        isGameOver = false
        score = 0
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
