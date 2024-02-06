//
//  PageContentController.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//

import Foundation


class PageContentController: ObservableObject {
    
    
    @Published var isUserBegin:Bool = false
    @Published var isGameBegin:Bool = false
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
    @Published var is_on_restricted_area = false
    
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
    let gene_length: Int = 10
    
    
    //
    var isLooped: Bool = false
    var ball_x_position: CGFloat = -1
    
    // bird
    @Published var jump_prob: Float = -1
    @Published var not_jump_prob: Float = -1
    
    // round
    @Published var balls: [Ball] = []
    @Published var parallel_balls: Int = 1
    @Published var ball_remaining:Int = 1
    @Published var best_distance:Float = 0
    
    // training
    @Published var best_balls:[Ball] = []
    @Published var rounds_count: Int = 0
    
    
    let count_down: Float = 2.0
    
    
    func update_birds_remaining(){
        var temp_bird_remaining = 0
        for bird in self.balls{
            if bird.isActive{
                temp_bird_remaining += 1
            }
        }
        self.ball_remaining = temp_bird_remaining
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
    
    
    func controller_reset() {
        
        // reset don't incluede the setting reset
        if self.rounds_count >= 1 {
            print("+ fetching best birds")
            self.fetch_the_best_birds()
            self.balls.removeAll()
            print("+ reproducing")
            self.reproduce()
            self.dropout()
        }
        self.rounds_count += 1
        isReset = false
        isGameBegin = false
        isUserBegin = false
        isGameOver = false
        bannerContent = "~ Tap to begin ~"
        
    
    }
    func deep_controller_reset() {
        
        // reset don't incluede the setting reset
        self.rounds_count = 0
        isLooped = false
        isReset = false
        isGameBegin = false
        isUserBegin = false
        isGameOver = false
        isOnSetting = true
        bannerContent = "~ Tap to begin ~"
    
    }
    
    func fetch_the_best_birds(){
        assert(self.balls.count == self.bird_number, "balls array number error: \(self.balls.count)")
        self.best_balls.removeAll()
        let sortedBalls = self.balls.sorted { $0.distance_score > $1.distance_score }
        let count = min(self.best_bird_needed, sortedBalls.count)
        for i in 0..<count {
           self.best_balls.append(sortedBalls[i])
        }
        self.best_distance = sortedBalls[0].distance_score
    }
    
    func reproduce(){
        
        var bird_a_w: Ball
        var bird_b_w: Ball
        var bird_a_b: Ball
        var bird_b_b: Ball
        
        
        while self.balls.count < self.bird_number{
            
            // select 2 parent for weights
            
            assert(self.best_balls.count == self.best_bird_needed,"best bird number check")
            
            repeat {
                bird_a_w = self.best_balls.randomElement()!
                bird_b_w = self.best_balls.randomElement()!
            } while bird_a_w.id == bird_b_w.id
            
            // select 2 parent for bias
            
            repeat {
                bird_a_b = self.best_balls.randomElement()!
                bird_b_b = self.best_balls.randomElement()!
            } while bird_a_b.id == bird_b_b.id
            
            // generate new gene segment
            
            let w_break_point = Int.random(in: 1..<(self.gene_length-1))
            let b_break_point = Int.random(in: 1..<(self.gene_length-1))
            
            assert(bird_a_b.weights.count == self.gene_length,"gene length check")
            
            /*
                Index range     ->  0 1 2 ... 9
                bp range        ->  1 2 3 ... 8
             */
            
            let new_weights = Array(bird_a_w.weights.prefix(w_break_point) + bird_b_w.weights.suffix(from: w_break_point))
            let new_bias = Array(bird_a_b.weights.prefix(b_break_point) + bird_b_b.weights.suffix(from: b_break_point))
            
            assert(new_weights.count == self.gene_length,"new weights length check")
            assert(new_bias.count == self.gene_length,"new bias length check")
            
            // make new ball (inherit everything except gene)
            
            var new_ball = Ball(x: self.ball_x_position, y: self.size.height/2, ball_index: -1, ball_radius: 15.0, ball_color: .red)
            new_ball.weights = new_weights
            new_ball.bias = new_weights
            self.balls.append(new_ball)
            
        }

        assert(self.balls.count == self.bird_number, "reproduced number incorrect: \(self.balls.count)")
        
        for bird in self.balls{
            assert(bird.ball_node.parent == nil, "bird parenting error")
        }
        
    }
    
    func dropout(){
        
        // randomly flip every ball's gene accordingly
        
        // calculate flip bits per gene
        
        let bits_to_flip = Int(Float(self.gene_length) * self.mutate_proab)
        
        // flip
        
        for (index, _) in self.balls.enumerated(){
            
            for _ in 0..<bits_to_flip{
                
                let w_flip_point = Int.random(in: 0..<(self.gene_length))
                let b_flip_point = Int.random(in: 0..<(self.gene_length))
                let w_flip_value = Float.random(in: -1...1)
                let b_flip_value = Float.random(in: -1...1)
                
                self.balls[index].weights[w_flip_point] = w_flip_value
                self.balls[index].bias[b_flip_point] = b_flip_value
                
            }
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
    
    func set_game_begin(){
        self.isGameBegin = true
    }
    
    
    func counting_down_set_user_begin() {
        
        let timeToGo = TimeInterval(self.count_down)
        
        DispatchQueue.main.async {
            self.bannerContent = "Counting down 3..."
            DispatchQueue.main.asyncAfter(deadline: .now() + (timeToGo / 3)) {
                self.bannerContent = "Counting down 2..."
                DispatchQueue.main.asyncAfter(deadline: .now() + (timeToGo / 3)) {
                    self.bannerContent = "Counting down 1..."
                    DispatchQueue.main.asyncAfter(deadline: .now() + timeToGo / 3) {
                        self.isUserBegin = true
                    }
                }
            }
        }
    }
    func set_game_over_banner(){
        self.bannerContent = " Game Over \n touch to reset"
    }
    func set_game_over_flags(){
        self.isGameOver = true
        self.isUserBegin = false
        self.isGameBegin = false
    }
    
    
    func manuallyChildRemoving(){
        for ball in self.balls{
            ball.ball_node.removeFromParent()
        }
    }
}
