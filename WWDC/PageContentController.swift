//
//  PageContentController.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//

import SwiftUI


class PageContentController: ObservableObject {
    
    //mode
    var scene_update_ref:GameScene? = nil
    var display_mode:Bool = false
    var experiment_mode:Bool = false
    var play_mode:Bool = false
    var avg_dist: Int = 0
    
    @Published var is_selecting = false
    @Published var is_showed_notice = false
    @Published var is_show_notice = false
    @Published var isUserBegin:Bool = false
    @Published var isGameBegin:Bool = false
    @Published var isReset:Bool = false
    @Published var isGameOver:Bool = false
    //@Published var isOnSetting:Bool = true
    @Published var size:CGSize = .zero
    
    // debug infos
    @Published var bannerContent: String = " Tap to begin "
    @Published var distance_score:Float = 0.123
    @Published var velocity:Float = -600
    @Published var current_focus:Int = 0
    @Published var distance_u:Float = 0.123
    @Published var distance_d:Float = 0.123
    @Published var is_on_restricted_area = false
    
    //Retrive from GAME SCENE
    @Published var ui_bird_number: Int = 12
    @Published var ui_bird_brain_size: Int = 18
    @Published var ui_col_gap: Float = 10
    @Published var ui_selected_best_ratio: best_ratio = .x1
    @Published var ui_mutate_proab: Float = 0.15
    @Published var ui_speed_index:Float = 10
    
    // for GAME SCENE
    var difficulty_index: CGFloat = 0.25
    
    var col_gap_value_mapping: CGFloat = 0.0
    var best_bird_needed: Int = 2
    var bird_number: Int = 12
    var mutate_proab: Float = 0.10
    var speed_index: CGFloat = 0.007
    var gene_length: Int = 28
    @Published var show_welcome_mat: Bool = true
    
    
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
    @Published var best_fitneass:Int = 0
    @Published var focus: Int = 0
    
    // training
    @Published var best_balls:[Ball] = []
    @Published var rounds_count: Int = 0
    
    @Published var best_distance_score: Float = 0
    @Published var avg_distance_score: Float = 0
    @Published var best_fitness_score: Float = 0
    @Published var avg_fitness_score: Float = 0
    @Published var best_distance_score_trend: Float = 0
    @Published var avg_distance_score_trend: Float = 0
    @Published var best_fitness_score_trend: Float = 0
    @Published var avg_fitness_score_trend: Float = 0
    
    // round history
    @Published var round_history: [Round] = []
    
    // display has a fixed gene length -> 18
    var display_mlp: SimpleNeuralNetwork = SimpleNeuralNetwork(hidden_layer_len: 18)
    
    let count_down: Float = 2.0
    
    init (){
        //
        self.experiment_mode = true
    }
    
    init (display_mode:Bool,displaying_bird_mlp: SimpleNeuralNetwork){
        // single bird show
        // display mode
        self.display_mode = display_mode
        self.display_mlp = displaying_bird_mlp
        self.bannerContent = "Tap to Play"
    }
    
    init (display_mode:Bool,displaying_bird_mlp: SimpleNeuralNetwork,display_size: CGSize){
        // single bird show
        // display mode
        self.size = display_size
        self.display_mode = display_mode
        self.display_mlp = displaying_bird_mlp
        self.bannerContent = "Tap to Play"
    }
    
    init (play_mode:Bool){
        // single bird show
        // play mode
        self.play_mode = play_mode
    }
    
    
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
        self.difficulty_index = col_gap_value_mapping(value: self.ui_col_gap)
        self.gene_length = self.ui_bird_brain_size
        self.speed_index = self.speed_index_value_mapping(value: self.ui_speed_index)
        self.setBestBirdNumbers()
        
        print("Experiment Infos")
        print("bird_number:", bird_number)
        print("mutate_proab:", mutate_proab)
        print("col_gap_value_mapping:", col_gap_value_mapping)
        print("gene_len:", gene_length)
        print("best_bird_needed:", best_bird_needed)
        
    }
    

    
    func fetch_the_best_birds(){
        assert(self.balls.count == self.bird_number, "balls array number error: \(self.balls.count)")
        self.best_balls.removeAll()
        let sortedBalls = self.balls.sorted { $0.fitness_score > $1.fitness_score }
        let count = min(self.best_bird_needed, sortedBalls.count)
        for i in 0..<count {
           self.best_balls.append(sortedBalls[i])
        }
        self.best_fitneass = sortedBalls[0].fitness_score
    }
    
    func generate_round_record(){
        assert(self.balls.count == self.bird_number, "balls array number error: \(self.balls.count)")
        
        var birdsum:Float = 0
        for birds in self.balls{
            birdsum += birds.distance_score
        }
        var avg_dist:Float = 0
        if self.balls.count != 0{
            avg_dist = birdsum / Float(self.balls.count)
        }
        
        let avg_dist_int = Int(avg_dist)
        let delta = avg_dist_int - self.avg_dist
        self.avg_dist = avg_dist_int
        withAnimation(.spring()){
            self.round_history.append(Round(avg_distance_score: avg_dist_int, score_trend: delta,round: self.rounds_count))
        }
            
        
        //print(self.round_history)
        
        
    }
    
    func reproduce(){
        
        //save
        for best_ball in self.best_balls{
            let rand_y_pos = Float.random(in: 0.4...0.6)
            let new_ball = Ball(x: CGFloat(100), y: self.size.height * CGFloat(rand_y_pos), ball_index: -1, ball_radius: 15.0, ball_color: .red, mlp: best_ball.mlp)
            self.balls.append(new_ball)
        }
        
            let rand_y_pos = Float.random(in: 0.4...0.6)
        let new_ball = Ball(x: CGFloat(100), y: self.size.height * CGFloat(rand_y_pos), ball_index: -1, ball_radius: 15.0, ball_color: .red, gene_len: self.gene_length)
            self.balls.append(new_ball)
        let new_ball_2 = Ball(x: CGFloat(100), y: self.size.height * CGFloat(rand_y_pos), ball_index: -1, ball_radius: 15.0, ball_color: .red, gene_len: self.gene_length)
            self.balls.append(new_ball_2)
        
        
        
        // random
        var bird_parent_a: Ball
        var bird_parent_b: Ball
        
        while self.balls.count < self.bird_number{
            
            // save the best ball
            
            // select 2 parent for weights
            
            assert(self.best_balls.count == self.best_bird_needed,"best bird number check")
            
            
            
            repeat {
                bird_parent_a = self.best_balls.randomElement()!
                bird_parent_b = self.best_balls.randomElement()!
            } while bird_parent_a == bird_parent_b
            
            // select 2 parent for bias
            
            
            let nn_new = NNBreader.weight_fusion(nn1: bird_parent_a.mlp, nn2: bird_parent_b.mlp, mutate_probability: self.mutate_proab)
            
            let rand_y_pos = Float.random(in: 0.3...0.7)
            let new_ball = Ball(x: CGFloat(100), y: self.size.height * CGFloat(rand_y_pos), ball_index: -1, ball_radius: 15.0, ball_color: .red, mlp: nn_new)
            self.balls.append(new_ball)
            
            
            /*
                old codes
             */
            /*
            // generate new gene segment
            
            let w_break_point = Int.random(in: 1..<(self.gene_length-1))
            let b_break_point = Int.random(in: 1..<(self.gene_length-1))
            
            
            /*
                Index range     ->  0 1 2 ... 9
                bp range        ->  1 2 3 ... 8
             */
            
            let new_weights = Array(bird_a_w.weights.prefix(w_break_point) + bird_b_w.weights.suffix(from: w_break_point))
            let new_bias = Array(bird_a_b.weights.prefix(b_break_point) + bird_b_b.weights.suffix(from: b_break_point))
            
            
            // make new ball (inherit everything except gene)
            let rand_y_pos = Float.random(in: 0.1...0.9)
            var new_ball = Ball(x: 100, y: self.size.height * CGFloat(rand_y_pos), ball_index: -1, ball_radius: 15.0, ball_color: .red)
            new_ball.weights = new_weights
            new_ball.bias = new_weights
            self.balls.append(new_ball)
             */
            
        }

        assert(self.balls.count == self.bird_number, "reproduced number incorrect: \(self.balls.count)")
        
        for bird in self.balls{
            assert(bird.ball_node.parent == nil, "bird parenting error")
        }
        
    }
    
    func dropout(){
        
        
        /* old codes*/
        /*
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
        */
    }
    
    func col_gap_value_mapping(value: Float) -> CGFloat {
        // gap height*0.3
        let inputMin: Float = 0
        let inputMax: Float = 20
        let outputMin: Float = Float(0.20)
        let outputMax: Float = Float(0.35)
        
        let normalizedValue = (value - inputMin) / (inputMax - inputMin)
        let mappedValue = (outputMax - outputMin) * normalizedValue + outputMin
        
        return CGFloat(mappedValue)
    }
    
    func speed_index_value_mapping(value: Float) -> CGFloat {
        // gap height*0.3
        let inputMin: Float = 0
        let inputMax: Float = 20
        let outputMin: Float = Float(0.003)
        let outputMax: Float = Float(0.007)
        
        let normalizedValue = (value - inputMin) / (inputMax - inputMin)
        let mappedValue = (outputMax - outputMin) * normalizedValue + outputMin
        
        return CGFloat(mappedValue)
    }
    
    
    func setBestBirdNumbers(){
        
        self.best_bird_needed =  Int(Float(self.ui_bird_number) * self.ui_selected_best_ratio.rawValue)
        
    }
    
    func set_game_begin(){
        withAnimation(){
            self.isGameBegin = true
        }
        
    }
    
    
    func counting_down_set_user_begin() {
        
        let timeToGo = TimeInterval(self.count_down)
        
        DispatchQueue.main.async {
            self.bannerContent = "Counting down 3..."
            DispatchQueue.main.asyncAfter(deadline: .now() + (timeToGo / 3)) {
                if self.isGameBegin{
                    self.bannerContent = "Counting down 2..."
                    DispatchQueue.main.asyncAfter(deadline: .now() + (timeToGo / 3)) {
                        if self.isGameBegin{
                            self.bannerContent = "Counting down 1..."
                            DispatchQueue.main.asyncAfter(deadline: .now() + timeToGo / 3) {
                                if self.isGameBegin{
                                    self.isUserBegin = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func set_game_over_banner() {
        DispatchQueue.main.async {
            if self.play_mode{
                self.bannerContent = "Oops, Tap to restart"
            }
            
        }
    }

    func set_game_over_flags() {
        DispatchQueue.main.async {
            self.isGameOver = true
            self.isUserBegin = false
            self.isGameBegin = false
        }
    }
    
    
    func manuallyChildRemoving(){
        for ball in self.balls{
            ball.ball_node.removeFromParent()
        }
    }
    
    func gathering_round_brief() {
        var avg_distance_score: Float = 0
        var best_distance_score: Float = 0
        var avg_fitness: Float = 0
        var best_fitness: Float = 0
        
        for ball in self.balls {
            avg_distance_score += ball.distance_score
            avg_fitness += Float(ball.fitness_score)
            
            if Float(ball.distance_score) > best_distance_score {
                best_distance_score = ball.distance_score
            }
            
            if Float(ball.fitness_score) > best_fitness {
                best_fitness = Float(ball.fitness_score)
            }
        }
        
        let count = Float(self.balls.count)
        avg_distance_score /= count
        avg_fitness /= count
        
        
        // trend calculation
        self.best_distance_score_trend = (best_distance_score - self.best_distance_score )
        self.avg_distance_score_trend = (avg_distance_score - self.avg_distance_score)
        self.best_fitness_score_trend = (best_fitness - self.best_fitness_score )
        self.avg_fitness_score_trend = (avg_fitness - self.avg_fitness_score)
            
        
        self.best_fitness_score = best_fitness
        self.avg_fitness_score = avg_fitness
        self.best_distance_score = best_distance_score
        self.avg_distance_score = avg_distance_score
        
    }
    func get_display_mode_info() -> (Float, Float, Float, Float){
        
        if self.balls.indices.contains(0){
            return (balls[0].distance_u,balls[0].distance_d,balls[0].velocity,0)
        }else{
            return (0,0,0,0)
        }
    }
    
    func get_normalized_scores(){
        var dist_scores: [Float] = []
        var avg_gap_dist_scores: [Float] = []
        
        for ball in self.balls{
            dist_scores.append(ball.distance_score)
            avg_gap_dist_scores.append(ball.avg_gap_dist_score)
        }
        if dist_scores.count == 0 || avg_gap_dist_scores.count == 0{
            return
        }
        
        let dist_score_max = dist_scores.max()!
        let dist_score_min = dist_scores.min()!
        let avg_gap_dist_max = avg_gap_dist_scores.max()!
        let avg_gap_dist_min = avg_gap_dist_scores.min()!
        
        
        for (index, ball) in self.balls.enumerated(){
            // mapping
            let mapped_avg_gap_dist_score =  self.normalization(ball.avg_gap_dist_score, lowerLimit: avg_gap_dist_min, upperLimit: avg_gap_dist_max)
            let mapped_distance_score =  self.normalization(ball.distance_score, lowerLimit: dist_score_min, upperLimit: dist_score_max)
            // asign
            self.balls[index].norm_distance_score = mapped_distance_score
            self.balls[index].norm_avg_gap_dist_score = mapped_avg_gap_dist_score
        }
    }
    
    func normalization(_ input: Float, lowerLimit: Float, upperLimit: Float) -> Float {
        
        let normalizedData = (input - lowerLimit) / (upperLimit - lowerLimit)
        return max(0, min(1, normalizedData))
    }
}


// MARK: - resets
extension PageContentController{
    
    func experiment_controller_reset() {
        
        // reset don't incluede the setting reset
        if self.rounds_count >= 1 {
            //print("+ fetching best birds")
            self.fetch_the_best_birds()
            self.generate_round_record()
            // print best brid DNA
            self.balls.removeAll()
            //print("+ reproducing")
            self.reproduce()
            self.dropout()
        }
        if self.rounds_count != 0{
            // print round infos
            
        }
        
        
            self.rounds_count += 1
        
        isReset = false
        isGameBegin = false
        isUserBegin = false
        //bannerContent = " Tap to begin "
        
    
    }
    func experiment_game_wise_controller_reset() {
        
        // reset don't incluede the setting reset
        self.rounds_count = 0
        isLooped = false
        isReset = false
        isGameBegin = false
        isUserBegin = false
        isGameOver = false
        is_selecting = false
        //isOnSetting = true
        is_on_restricted_area = false
        balls.removeAll()
        round_history.removeAll()
        best_balls.removeAll()
        bannerContent = " Tap to begin "
    
    }
    
    func display_controller_reset(){
        isLooped = true
        isReset = false
        isGameBegin = false
        isUserBegin = false
        isGameOver = false
        //isOnSetting = false
        is_on_restricted_area = false
        self.balls.removeAll()
        balls.append(Ball(x: CGFloat(100), y: self.size.height * 0.5, ball_index: -1, ball_radius: 15.0, ball_color: .red, mlp: pretrained_bird_instance))
        self.gene_length = 18
        
    }
    
    func play_controller_reset(){
        isLooped = false
        isReset = false
        isGameBegin = false
        isUserBegin = false
        isGameOver = false
        //isOnSetting = false
        is_on_restricted_area = false
        balls.removeAll()
        balls.append(Ball(x: CGFloat(100), y: self.size.height * 0.5, ball_index: -1, ball_radius: 15.0, ball_color: .red, gene_len: 8))
        bannerContent = " Tap to try FlappyBrid "
    }
    
}
