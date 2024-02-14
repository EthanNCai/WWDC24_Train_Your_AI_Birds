//
//  GameScene.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//

import SwiftUI

import SpriteKit

class GameScene: SKScene{
    
    
    // controller
    @ObservedObject var content_ctrl: PageContentController
    
    //  hyper-params
    var cloud_speed_index:CGFloat = 0.003
    var colTimeInterval: Double = 3.0
    var cloudTimeInterval: Double = 3.4
    var jmpTimeInterval: Double = 0.2
    var gameTickInterval: Double = 0.02
    var ballRadius:CGFloat = 15.0
    var outed_tolerance: CGFloat = 8
    var colDistanceInterval: CGFloat {
        
        return CGFloat((colTimeInterval / gameTickInterval) * self.content_ctrl.speed_index) * self.size.width
    }
    var ballXPosition: CGFloat {
        100
    }
    
    // on-going variables
    var jmpTimer: TimeInterval = 0.0
    var colGeneratorTimer: TimeInterval = 0.0
    var gameTickTimer: TimeInterval =  0.0
    var cloudTickTimer: TimeInterval =  0.0
    var onscreen_cols: [Int] = []
    var onscreen_clouds: [Int] = []
    var newest_col_index = 0
    var newest_cloud_index = 0
    var currently_focus = 0
    var is_on_restricted_area = false
   
    
    init(viewController: PageContentController) {
        self.content_ctrl = viewController
        super.init(size: viewController.size)
        self.content_ctrl.ball_x_position = self.ballXPosition
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        makeBackgrounds()
        
    }
    
    func checkRestrictedZone() {
        
        if self.currently_focus == 0{
            return
        }
        let colu = childNode(withName: "colu" + String(self.currently_focus))!
        if abs(colu.position.x - self.ballXPosition) < outed_tolerance {
            self.is_on_restricted_area = true
            self.content_ctrl.is_on_restricted_area = true
        }else
        {
            self.is_on_restricted_area = false
        }
        
    }
    
    
    func remove_collide_balls() {
        for (index, ball) in self.content_ctrl.balls.enumerated(){
            
            if !ball.isActive{
                continue
            }
            
            
            
            
            // check for cell and floor
            
            
            let y = ball.ball_node.position.y
            
            let y_lower_boundary = self.size.height * 0.1 + ball.ballRadius + outed_tolerance
            // 0.1 => solid 
            let y_higher_boundary = self.size.height - ball.ballRadius - outed_tolerance
            
            if y < y_lower_boundary || y > y_higher_boundary{
                self.content_ctrl.balls[index].isActive = false
                let scaleAction = SKAction.scale(to: 0.0, duration: 0.2)
                let removeAction = SKAction.removeFromParent()
                let sequence = SKAction.sequence([scaleAction, removeAction])
                ball.ball_node.run(sequence)
            }
            
            // check for column
            
            if self.is_on_restricted_area {
                if self.currently_focus == 0{
                    return
                }
                let colu = childNode(withName: "colu" + String(self.currently_focus))!
                let col_upper_bounds = colu.position.y
                let col_lower_bounds = col_upper_bounds - self.size.height * self.content_ctrl.difficulty_index
                
                if y < col_lower_bounds || y > col_upper_bounds{
                    self.content_ctrl.balls[index].isActive = false
                    let scaleAction = SKAction.scale(to: 0.0, duration: 0.2)
                    let removeAction = SKAction.removeFromParent()
                    assert(self.is_on_restricted_area == true, "removing objects our of restricted area")
                    let sequence = SKAction.sequence([scaleAction, removeAction])
                    ball.ball_node.run(sequence)
                }
            }
            
            
        }
    }
    
    
    
    func makeBackgrounds(){
        let background = SKSpriteNode(color: NSColor(hex:0x9BB8CD,alpha:1), size: self.size)
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        background.zPosition = -5
        addChild(background)
        
        let solid = SKSpriteNode(color: NSColor(hex: 0xBCA37F,alpha:1.0), size: CGSize(width: self.content_ctrl.size.width, height: self.content_ctrl.size.height * 0.1))
        solid.anchorPoint = .zero
        solid.position = .zero
        solid.zPosition = 1
        addChild(solid)
        
        let ground = SKSpriteNode(color: NSColor(hex: 0xEAD7BB,alpha:1.0),  size: CGSize(width: self.content_ctrl.size.width, height: 10))
        ground.anchorPoint = .zero
        ground.position = CGPoint(x: 0, y: self.content_ctrl.size.height * 0.1)
        solid.zPosition = 0
        addChild(ground)
    }
    
    func updateBallDistScore(){
        for (index, ball) in self.content_ctrl.balls.enumerated(){
            if ball.isActive {
                self.content_ctrl.balls[index].distance_score += Float(self.content_ctrl.speed_index * self.size.width)
            }
        }
        
    }
    func update_ball_fitness_score(){
        for (index, ball) in self.content_ctrl.balls.enumerated(){
            if ball.isActive {
            
                let current_height = ball.ball_node.position.y
                if self.currently_focus == 0{
                    return
                }
                let colu = childNode(withName: "colu" + String(self.currently_focus))!
                let col_upper_bounds = colu.position.y
                
                let col_lower_bounds = col_upper_bounds - self.size.height * self.content_ctrl.difficulty_index
                
                
                if current_height < col_lower_bounds || current_height > col_upper_bounds{
                    continue
                }else{
                    
                    self.content_ctrl.balls[index].fitness_score += 1
                }
            }
        }
        
    }
    func update_ball_fitness_scorev2(){
        for (index, ball) in self.content_ctrl.balls.enumerated(){
            if ball.isActive {
            
                let current_height = ball.ball_node.position.y
                if self.currently_focus == 0{
                    return
                }
                let colu = childNode(withName: "colu" + String(self.currently_focus))!
                let col_upper_bounds = colu.position.y
                
                let col_lower_bounds = col_upper_bounds - self.size.height * self.content_ctrl.difficulty_index
                
                let distance_upper = abs(current_height - col_upper_bounds)
                let distance_lower = abs(current_height - col_lower_bounds)
                
                self.content_ctrl.balls[index].fitness_score_v2 = 100/(Float(distance_lower + distance_upper)/2)
                
            }
        }
        
    }
    
    func shift_col_left() {

        for col_index in self.onscreen_cols {
            if let col = childNode(withName: "colu" + String(col_index)) as? SKSpriteNode {
                col.position.x -= self.content_ctrl.speed_index * self.size.width
                if col.position.x < -col.size.width-10 {
                    self.removeCol(col_index: col_index)
                }
            }
            
            if let col = childNode(withName: "cold" + String(col_index)) as? SKSpriteNode {
                col.position.x -= self.content_ctrl.speed_index * self.size.width
                    
                if col.position.x < -col.size.width-10 {
                    self.removeCol(col_index: col_index)
                    
                }
            }
        }
    }
    func shift_cloud_left(){
        for cloud_index in self.onscreen_clouds {
            if let cloud = childNode(withName: "cloud" + String(cloud_index)) as? SKSpriteNode {
                cloud.position.x -= self.cloud_speed_index * self.size.width
                //print("cloud shifted, position :\(cloud.position.x), screen_width:\(self.content_ctrl.size.width)")
                if cloud.position.x < -cloud.size.width-100 {
                    if let index = self.onscreen_clouds.firstIndex(of: cloud_index) {
                        onscreen_clouds.remove(at: index)
                    }
                }
            }
            
        }
    }
    func make_cloud(){
        
        //print("made cloud")
        self.newest_cloud_index += 1
        let cloud_index = newest_cloud_index
        // y boundary
        
        let y_upper_bound = Float(self.content_ctrl.size.height * 0.9)
        let y_lower_bound = Float(self.content_ctrl.size.height * 0.4)
        // rand y
        let y = CGFloat(Float.random(in: y_lower_bound...y_upper_bound))
        
        // size boundary

        // rand size
        let length:CGFloat = 100
        let coin = Int.random(in: 1...4)
        let name:String
        if coin == 1{
            name = "cloud_sp"
        }else{
            name = "cloud"
        }
        
        let cloud = SKSpriteNode(imageNamed: name)
        cloud.anchorPoint = CGPoint.zero
        cloud.scale(to: CGSize(width: length, height: length))
        cloud.position = CGPoint(x: self.size.width, y: y)
        cloud.name = "cloud" + String(cloud_index)
        cloud.zPosition = -3
        // add child
        addChild(cloud)
        self.onscreen_clouds.append(cloud_index)
    }
    
    func makeCol(provided_position: CGFloat = -1){
        
        self.newest_col_index += 1
        let col_index = newest_col_index
        let (pos_index_u,pos_index_d) = colPositionIndexGenerator()
        let colwidth: CGFloat = 12.0
        let colheight: CGFloat = self.size.height
        var position: CGFloat {
            if(provided_position != -1){
                return provided_position
            }else{
                return self.size.width
            }
        }
        
        let colu = SKSpriteNode(color: NSColor(hex:0xD2DE32,alpha:1), size: CGSize(width: colwidth, height: colheight))
        colu.anchorPoint = CGPoint.zero
        colu.position = CGPoint(x: position , y: self.size.height * pos_index_u)
        colu.name = "colu" + String(col_index)
        colu.zPosition = -1
        addChild(colu)
        
        let cold = SKSpriteNode(color: NSColor(hex:0xD2DE32,alpha:1), size: CGSize(width: colwidth, height: colheight))
        cold.anchorPoint = CGPoint.zero
        cold.position = CGPoint(x: position , y: self.size.height * pos_index_d)
        cold.name = "cold" + String(col_index)
        cold.zPosition = -1
        
        
        addChild(cold)
        self.onscreen_cols.append(col_index)
        
    }
    
    func update_velocity(){
        
        for (index, ball) in self.content_ctrl.balls.enumerated(){
            if ball.isActive && content_ctrl.isUserBegin {
                self.content_ctrl.balls[index].velocity = Float(self.content_ctrl.balls[index].ball_node.physicsBody!.velocity.dy)
                self.content_ctrl.velocity = Float(self.content_ctrl.balls[index].ball_node.physicsBody!.velocity.dy)
            }
        }
    }
    
    
    
    func updateFocusIndex(){
        for col_index in self.onscreen_cols{
            let col_name = "cold" + String(col_index)
            let col_node = self.childNode(withName: col_name)!
            if col_node.position.x > CGFloat(100){
                self.currently_focus =  col_index
                self.content_ctrl.current_focus = col_index
                return
            }
        }
        self.currently_focus =  0
        self.content_ctrl.current_focus = 0
    }
    
    func updateColDistance() {
        
        for (index, ball) in self.content_ctrl.balls.enumerated(){
            let colu_index = self.currently_focus
            
            if colu_index == 0{
                self.content_ctrl.balls[index].distance_d = -1
                self.content_ctrl.balls[index].distance_u = -1
                return
            }
            let colu_name = "colu" + String(colu_index)
            let colu = self.childNode(withName: colu_name)!
            
            // ball x,y
            let ball_x = ball.ball_node.position.x
            let ball_y = ball.ball_node.position.y
            // upper x,y
            let colu_x = colu.position.x
            let colu_y = colu.position.y
            // downer x,y
            let cold_x = colu_x
            let cold_y = colu_y - self.size.height * self.content_ctrl.difficulty_index
            
            let ball_cold_distance = Float(sqrt(pow(ball_x - cold_x, 2) + pow(ball_y - cold_y, 2)))
            let ball_colu_distance = Float(sqrt(pow(ball_x - colu_x, 2) + pow(ball_y - colu_y, 2)))
            
            self.content_ctrl.balls[index].distance_d = ball_cold_distance
            self.content_ctrl.balls[index].distance_u = ball_colu_distance
        }
    }
    
    func cleanOutedBirds() {
        
        for (_, ball) in self.content_ctrl.balls.enumerated(){
            if !ball.isActive && ball.ball_node.parent != nil{
                let ball_node = ball.ball_node
                let scaleAction = SKAction.scale(to: 0.0, duration: 0.2)
                let removeAction = SKAction.removeFromParent()
                assert(self.is_on_restricted_area == true, "removing objects our of restricted area")
                let sequence = SKAction.sequence([scaleAction, removeAction])
                ball_node.run(sequence)
            }
        }
    }
    func checkGameOver(){
        
        for ball in self.content_ctrl.balls{
            if ball.isActive == true{
                return
            }
        }
        
        self.content_ctrl.isGameOver = true
        self.content_ctrl.gathering_round_brief()
        self.content_ctrl.set_game_over_flags()
        self.content_ctrl.set_game_over_banner()
        
        // print best mlp
        
        //print(content_ctrl.)
        
    }
    
    func check_node_unique(){
        
        let ballset = Set(self.content_ctrl.balls)
        assert(self.content_ctrl.balls.count == self.content_ctrl.bird_number, "ball number error")
        assert(ballset.count == self.content_ctrl.bird_number, "ball element repeated")
        
    }
    
    func print_node_obj_info(){
        
        for ball in self.content_ctrl.balls{
            print(Unmanaged.passUnretained(ball.ball_node).toOpaque())
        }
    }
    
    func jump_accordingly()
    {
        for (index, ball) in self.content_ctrl.balls.enumerated(){
            
//            let rand = Int.random(in: 0...1)
//            if rand == 1{
//                ball.jump()
//            }
            let(jump_proab,is_jump) = ball.get_dicision_is_jump(scene_size: self.size)
            
            self.content_ctrl.balls[index].set_fly_probability(fly_probability: jump_proab)
            if ball.isActive && is_jump
            {
                ball.jump()
                self.content_ctrl.balls[index].is_jumped = true
            }else{
                self.content_ctrl.balls[index].is_jumped = false
            }
            
            if ball.ball_node.physicsBody!.velocity.dy > CGFloat(330){
                self.content_ctrl.balls[index].ball_node.physicsBody?.velocity.dy = CGFloat(330)
            }else if ball.ball_node.physicsBody!.velocity.dy < CGFloat(-330){
                self.content_ctrl.balls[index].ball_node.physicsBody?.velocity.dy = CGFloat(-330)
            }
            
            /*
            if ball.isActive && ball.get_dicision_is_jump(scene_size: self.size)
            {
                ball.jump()
            }
            if ball.ball_node.physicsBody!.velocity.dy > CGFloat(250){
                self.content_ctrl.balls[index].ball_node.physicsBody?.velocity.dy = CGFloat(350)
            }else if ball.ball_node.physicsBody!.velocity.dy < CGFloat(-250){
                self.content_ctrl.balls[index].ball_node.physicsBody?.velocity.dy = CGFloat(-350)
            }
             */
        }
        
    }
}


// MARK: - Initialize

extension GameScene{
    func generate_balls_accordingly(){
        //print("hi")
        //print("child_num",self.children.count)
        assert(self.content_ctrl.balls.count == 0 , "balls.count error: \(self.content_ctrl.balls.count)")
       // print("+ newly generated - bird child adding")
        for i in 0..<self.content_ctrl.bird_number{
            let rand_y_pos = Float.random(in: 0.3...0.7)
            self.content_ctrl.balls.append(Ball(x: CGFloat(100), y: self.size.height * CGFloat(rand_y_pos), ball_index: -1, ball_radius: 15.0, ball_color: .red,gene_len: self.content_ctrl.gene_length))
            let ball_node = self.content_ctrl.balls[i].ball_node
            assert(ball_node.parent == nil, "bird parent error")
            addChild(ball_node)
        }
        //print("> children.count \(self.children.count)")
        //print("> balls.count \(self.content_ctrl.balls.count)")
        //print("child_num",self.children.count)
    }
    func join_balls_accordingly(){
        //print("hi")
        //print("child_num",self.children.count)
        //print("+ parent generated - bird child adding")
        for bird in self.content_ctrl.balls{
            let bird_node = bird.ball_node
            assert(bird_node.parent == nil, "bird parent error")
            addChild(bird_node)
        }
        //print("> children.count \(self.children.count)")
        //print("> balls.count \(self.content_ctrl.balls.count)")
        //print("child_num",self.children.count)
    }
}


// MARK: - Utilities

extension GameScene{
    
    
    func colPositionIndexGenerator() -> (CGFloat, CGFloat) {
        let iu = CGFloat.random(in: (self.content_ctrl.difficulty_index*1.3)...1)
        let id = iu - (1+self.content_ctrl.difficulty_index)
        return (iu, id)
    }
    
    func removeCol(col_index: Int){
        
        if let col = childNode(withName: "colu" + String(col_index)) as? SKSpriteNode {
            col.removeFromParent()
        }
        if let col = childNode(withName: "cold" + String(col_index)) as? SKSpriteNode {
            col.removeFromParent()
        }
        if let index = self.onscreen_cols.firstIndex(of: col_index) {
            onscreen_cols.remove(at: index)
        }
        
    }
    
    func adjust_bird_rotation(){
        
        for bird in self.content_ctrl.balls{
            
            if bird.isActive{
                let bird_ndoe = bird.ball_node
                let velocityY = bird_ndoe.physicsBody?.velocity.dy ?? 0
                let angle = atan2(velocityY, 1) * 0.10
                let rotateAction = SKAction.rotate(toAngle: angle, duration: 0.05)
                bird_ndoe.run(rotateAction)
            }
            
        }
    }
    
    func touch_jumping(){
        assert(self.content_ctrl.balls.indices.contains(0), "checkin'")
        if self.content_ctrl.balls.indices.contains(0){
           self.content_ctrl.balls[0].human_jump()
        }
    }
}


//MARK: - Update

extension GameScene{
    override func update(_ currentTime: TimeInterval) {
        
        /*
            UPDATES *Directed* by tick
         */
        let dt_sm = currentTime - self.colGeneratorTimer
        if  !self.content_ctrl.isGameOver {
            
            /* sm-tick update*/
            if dt_sm >= self.gameTickInterval {
                
                if self.content_ctrl.isGameBegin{
                    
                    // update col position
                    self.shift_col_left()
                    
                    self.shift_cloud_left()
                    
                }
                
                if self.content_ctrl.isUserBegin{
                    
                    //
                    //self.check_node_unique()
                    
                    
                    self.updateBallDistScore()
                    
                    if self.content_ctrl.experiment_mode{
                        
                        self.update_ball_fitness_score()
                        
                        self.see_if_we_can_show_the_notice()
                    }
                    
                    // update focus to *game scene*
                    self.updateFocusIndex()
                    
                    // update distance to *ball matrics*
                    self.updateColDistance()
                    
                    // update distance to *ball matrics*
                    self.update_velocity()
                    
                    self.adjust_bird_rotation()
                    
                    // check restricted zone
                    self.checkRestrictedZone()
                    
                    // update is_active statu
                    self.remove_collide_balls()
                    
                    // check game over, find the best bird
                    self.checkGameOver()
                }
                
                
                
                // reset time
                self.colGeneratorTimer = currentTime
            }
            
            /* md-tick update*/
            let dt_md = currentTime - self.jmpTimer
            
            if !self.content_ctrl.play_mode{
                if dt_md >= self.jmpTimeInterval {
                    if self.content_ctrl.isUserBegin && !self.content_ctrl.isGameOver{
                        self.jump_accordingly()
                        self.jmpTimer = currentTime
                    }
                }
            }
            

            /* lg-tick update*/
            let dt_lg = currentTime - self.gameTickTimer

            if dt_lg >= self.colTimeInterval {
                    self.makeCol()
                    //self.make_cloud()
                    self.gameTickTimer = currentTime
            }
            
            /* xl-tick update*/
            let dt_xl = currentTime - self.cloudTickTimer

            if dt_xl >= self.cloudTimeInterval {
                    self.make_cloud()
                    self.cloudTickTimer = currentTime
            }
        }
        
        /*
            UPDATES *Not Directed* by tick
         */
        
        /*
            **Automatically** Updating game statu
         */
        
        // any time you pressed Reset
        if self.content_ctrl.isReset{
           
            self.reset_accordingly()
        }
        
        // game is over & you opened Auto Loop
        if self.content_ctrl.isGameOver && self.content_ctrl.isLooped && !self.content_ctrl.isGameBegin{
            
            
            // reset logic
            
            if self.content_ctrl.experiment_mode{
                print("reset:C")
                self.experiment_reset()                             // game scene reset (incl. generate stuffs)
            }else if self.content_ctrl.display_mode{
                self.display_reset()
            }
            
            
            // begin logic
            self.content_ctrl.set_game_begin()                  // game begin first
            self.content_ctrl.counting_down_set_user_begin()    // user begin 3 secs later
            self.counting_down_then_set_active()                     // user begin 3 secs later
        }
        
    }
}


//MARK: - Touches logic

extension GameScene{
    
    override func mouseDown(with event: NSEvent){
        
        if self.content_ctrl.experiment_mode{
            self.experiment_touch_logic()
        }else if self.content_ctrl.display_mode{
            self.display_touch_logic()
        }else if self.content_ctrl.play_mode{
            self.play_touch_logic()
        }
    }
    
    
    //Touch Logics ..
    func play_touch_logic(){
        if self.content_ctrl.isUserBegin && !self.content_ctrl.isGameOver{
            // on gaming
            self.touch_jumping()
            
            return
        }
        if self.content_ctrl.isGameBegin && !self.content_ctrl.isGameOver{
            return
        }
        // already tapped
        
        self.play_reset()                             // game scene reset (incl. generate stuffs)
        
        // begin logic
        self.content_ctrl.set_game_begin()
        self.content_ctrl.counting_down_set_user_begin()    // user begin 3 secs later
        self.counting_down_then_set_active()
    }
    func display_touch_logic(){
        if self.content_ctrl.isGameBegin && !self.content_ctrl.isGameOver{
            return
        }
        // already tapped
        if self.content_ctrl.isUserBegin && !self.content_ctrl.isGameOver{
            return
        }
        self.display_reset()                             // game scene reset (incl. generate stuffs)
        
        // begin logic
        self.content_ctrl.set_game_begin()
        self.content_ctrl.counting_down_set_user_begin()    // user begin 3 secs later
        self.counting_down_then_set_active()
    }
    func experiment_touch_logic(){
        
        /*
            **Manually** Updating game statu
         */
        
        
        
        // already tapped OR tapped but gameover
        if self.content_ctrl.isGameBegin && !self.content_ctrl.isGameOver{
            return
        }
        // already tapped
        if self.content_ctrl.isUserBegin && !self.content_ctrl.isGameOver{
            return
        }
        
        // not tapped & not begin & not on setting
        // or Game Over
        
        
        // gameover start
        if self.content_ctrl.isGameOver && !self.content_ctrl.isLooped{
            
            
            // reset logic
            print("reset:B")
            self.experiment_reset()                             // game scene reset (incl. generate stuffs)
            
            // begin logic
            self.content_ctrl.set_game_begin()
            self.content_ctrl.counting_down_set_user_begin()    // user begin 3 secs later
            self.counting_down_then_set_active()                     // user begin 3 secs later
            
            return
        }
        
        
        if true{
        // general start, due to the lazy reset bug, reset needed here
            
            
            // reset logic
            print("reset:A")
            self.experiment_reset()                             // game scene reset (incl. generate stuffs)
            
            // begin logic
            self.content_ctrl.set_game_begin()                  // game begin first
            self.content_ctrl.counting_down_set_user_begin()    // user begin 3 secs later
            self.counting_down_then_set_active()                     // user begin 3 secs later
        }
        
        
        // Tap to begin  ---> begin
    }

    func counting_down_then_set_active(){
        // tap to start

        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(self.content_ctrl.count_down)) {
            for (index, _) in self.content_ctrl.balls.enumerated(){
                
                self.content_ctrl.balls[index].set_active()
                
            }
        }
        
    }
    
    func see_if_we_can_show_the_notice(){
        
        var is_distance_long_enough = false
        for ball in self.content_ctrl.balls{
            if ball.distance_score >= Float(self.content_ctrl.size.width) * 0.8{
                is_distance_long_enough = true
            }
        }
        if is_distance_long_enough && !self.content_ctrl.is_showed_notice {
            withAnimation(){
                self.content_ctrl.is_show_notice = true
            }
                self.content_ctrl.is_showed_notice = true
            
        }
    }
    
    
    override func touchesBegan(with event: NSEvent) {
        //
    }
    override func touchesMoved(with event: NSEvent) {
        //
    }
    override func touchesEnded(with event: NSEvent) {
        //
    }
    
    
}


// MARK: - Resets logics
extension GameScene{
    func experiment_reset() {
        
        // game scene clean
        print("=====================================")
        print("round \(self.content_ctrl.rounds_count)")
        print("=====================================")
        self.removeAllChildren()
        self.onscreen_cols.removeAll()
        
        
        // index clean
        newest_col_index = 0
        colGeneratorTimer = 0.0
        gameTickTimer = 0.0
        jmpTimer = 0.0
        self.currently_focus = 0
        
        self.content_ctrl.experiment_controller_reset()
        
        for birds in self.content_ctrl.balls{
            assert(birds.ball_node.parent == nil, "bird parenting error")
        }
        assert(self.children.count == 0, "children state error")
        
        if self.content_ctrl.rounds_count > 1{
            assert(self.content_ctrl.balls.count == self.content_ctrl.bird_number, "reproduction ball insertion faild, ball number:\(self.content_ctrl.balls.count)")
        }
        
        makeBackgrounds()
        
        // regenerate children
        if self.content_ctrl.rounds_count > 1{
            self.join_balls_accordingly()
            
        }else{
            self.generate_balls_accordingly()
        }
        //self.print_node_obj_info()
    
        self.content_ctrl.isGameOver = false
        // make sure there's n balls
        assert(self.content_ctrl.bird_number == self.content_ctrl.balls.count ,"ball array count error : \(self.children.count) children(s)")
    }
    
    func game_wise_experiment_reset() {
        
        // game scene clean
        //print("DEEP RESET")
        
        self.removeAllChildren()
        self.onscreen_cols.removeAll()
        
        
        // index clean
        newest_col_index = 0
        colGeneratorTimer = 0.0
        gameTickTimer = 0.0
        jmpTimer = 0.0
        self.currently_focus = 0
        
        self.content_ctrl.experiment_game_wise_controller_reset()
        
        for birds in self.content_ctrl.balls{
            assert(birds.ball_node.parent == nil, "bird parenting error")
        }
        assert(self.children.count == 0, "children state error")
        
        if self.content_ctrl.rounds_count > 1{
            assert(self.content_ctrl.balls.count == self.content_ctrl.bird_number, "reproduction ball insertion faild, ball number:\(self.content_ctrl.balls.count)")
        }
        
        makeBackgrounds()
        
    }
    func display_reset(){
        // game scene clean
        self.removeAllChildren()
        self.onscreen_cols.removeAll()
        
        
        // index clean
        newest_col_index = 0
        colGeneratorTimer = 0.0
        gameTickTimer = 0.0
        jmpTimer = 0.0
        self.currently_focus = 0
        self.content_ctrl.display_controller_reset()
        
        for birds in self.content_ctrl.balls{
            assert(birds.ball_node.parent == nil, "bird parenting error")
        }
        assert(self.children.count == 0, "children state error")
        
        makeBackgrounds()
        addChild(self.content_ctrl.balls[0].ball_node)
        
    }
    
    func play_reset(){
        // game scene clean
        self.removeAllChildren()
        self.onscreen_cols.removeAll()
        
        
        // index clean
        newest_col_index = 0
        colGeneratorTimer = 0.0
        gameTickTimer = 0.0
        jmpTimer = 0.0
        self.currently_focus = 0
        self.content_ctrl.play_controller_reset()
        
        for birds in self.content_ctrl.balls{
            assert(birds.ball_node.parent == nil, "bird parenting error")
        }
        assert(self.children.count == 0, "children state error")
        
        makeBackgrounds()
        addChild(self.content_ctrl.balls[0].ball_node)
        
    }
    
    func reset_accordingly(){
        if self.content_ctrl.play_mode{
            self.play_reset()
        }else if self.content_ctrl.display_mode{
            self.display_reset()
        }else if self.content_ctrl.experiment_mode{
            print("reset:D")
            self.experiment_reset()
        }
    }
}

extension NSColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


