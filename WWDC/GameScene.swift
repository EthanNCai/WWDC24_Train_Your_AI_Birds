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
    var difficulty_index: CGFloat = 0.45
    var speed_index: CGFloat = 0.005
    var colTimeInterval: Double = 3.0
    var jmpTimeInterval: Double = 0.2
    var gameTickInterval: Double = 0.02
    var ballRadius:CGFloat = 15.0
    var outed_tolerance: CGFloat = 5
    var colDistanceInterval: CGFloat {
        
        return CGFloat((colTimeInterval / gameTickInterval) * speed_index) * self.size.width
    }
    var ballXPosition: CGFloat {
        return self.size.width*(1/5)
    }
    
    // on-going variables
    var jmpTimer: TimeInterval = 0.0
    var colGeneratorTimer: TimeInterval = 0.0
    var gameTickTimer: TimeInterval =  0.0
    var onscreen_cols: [Int] = []
    var newest_col_index = 0
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
    
    
    func updateCollisionStatus() {
        for (index, ball) in self.content_ctrl.balls.enumerated(){
            
            // check for cell and floor
            
            let y = ball.ball_node.position.y
            let y_lower_boundary = 0 + ball.ballRadius + outed_tolerance
            let y_higher_boundary = self.size.height - ball.ballRadius - outed_tolerance
            
            if y < y_lower_boundary || y > y_higher_boundary{
                self.content_ctrl.balls[index].isActive = false
            }
            
            // check for column
            
            if self.is_on_restricted_area {
                if self.currently_focus == 0{
                    return
                }
                let colu = childNode(withName: "colu" + String(self.currently_focus))!
                let col_upper_bounds = colu.position.y
                let col_lower_bounds = col_upper_bounds - self.size.height * self.difficulty_index
                
                if y < col_lower_bounds || y > col_upper_bounds{
                    self.content_ctrl.balls[index].isActive = false
                }
            }
        }
    }
    
    
    func makeBackgrounds(){
        let background = SKSpriteNode(color: NSColor(Color.blue.opacity(0.6)), size: self.size)
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        addChild(background)
    }
    
    func updateBallDistScore(){
        for (index, ball) in self.content_ctrl.balls.enumerated(){
            if ball.isActive {
                self.content_ctrl.balls[index].distance_score += Float(self.speed_index * self.size.width)
            }
        }
        
    }
    
    func shiftColLeft() {

        for col_index in self.onscreen_cols {
            if let col = childNode(withName: "colu" + String(col_index)) as? SKSpriteNode {
                col.position.x -= self.speed_index * self.size.width
                if col.position.x < -col.size.width-10 {
                    self.removeCol(col_index: col_index)
                }
            }
            
            if let col = childNode(withName: "cold" + String(col_index)) as? SKSpriteNode {
                col.position.x -= self.speed_index * self.size.width
                    
                if col.position.x < -col.size.width-10 {
                    self.removeCol(col_index: col_index)
                    
                }
            }
        }
    }
    
    
    func makeCol(provided_position: CGFloat = -1){
        
        self.newest_col_index += 1
        let col_index = newest_col_index
        let (pos_index_u,pos_index_d) = colPositionIndexGenerator()
        let colwidth: CGFloat = 8.0
        let colheight: CGFloat = self.size.height
        var position: CGFloat {
            if(provided_position != -1){
                return provided_position
            }else{
                return self.size.width
            }
        }
        
        let colu = SKSpriteNode(color: .green, size: CGSize(width: colwidth, height: colheight))
        colu.anchorPoint = CGPoint.zero
        colu.position = CGPoint(x: position , y: self.size.height * pos_index_u)
        colu.name = "colu" + String(col_index)
        addChild(colu)
        
        let cold = SKSpriteNode(color: .red, size: CGSize(width: colwidth, height: colheight))
        cold.anchorPoint = CGPoint.zero
        cold.position = CGPoint(x: position , y: self.size.height * pos_index_d)
        cold.name = "cold" + String(col_index)
        
        
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
            if col_node.position.x > self.ballXPosition{
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
            let cold_y = colu_y - self.size.height * self.difficulty_index
            
            let ball_cold_distance = Float(sqrt(pow(ball_x - cold_x, 2) + pow(ball_y - cold_y, 2)))
            let ball_colu_distance = Float(sqrt(pow(ball_x - colu_x, 2) + pow(ball_y - colu_y, 2)))
            
            self.content_ctrl.balls[index].distance_d = ball_cold_distance
            self.content_ctrl.balls[index].distance_u = ball_colu_distance
        }
    }
    
    func cleanOutedBirds() {
        
        for (_, ball) in self.content_ctrl.balls.enumerated(){
            if !self.content_ctrl.balls.isEmpty && !ball.isActive && ball.ball_node.parent != nil{
                let ball_node = ball.ball_node
                let scaleAction = SKAction.scale(to: 0.0, duration: 0.2)
                let removeAction = SKAction.removeFromParent()
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
        self.content_ctrl.set_game_over_flags()
        self.content_ctrl.set_game_over_banner()
        
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
        
        for ball in self.content_ctrl.balls{
            if ball.isActive && ball.get_dicision_is_jump(scene_size: self.size)
            {
                ball.jump()
            }
        }
        
    }
}


// MARK: - Initialize

extension GameScene{
    func generate_balls_accordingly(){
        //print("hi")
        //print("child_num",self.children.count)
        assert(self.content_ctrl.balls.count == 0 , "balls.count error: \(self.content_ctrl.balls.count)")
        print("+ newly generated - bird child adding")
        for i in 0..<self.content_ctrl.bird_number{
            self.content_ctrl.balls.append(Ball(x: self.ballXPosition, y: self.size.height/2, ball_index: i, ball_radius: 15.0, ball_color: .red))
            let ball_node = self.content_ctrl.balls[i].ball_node
            assert(ball_node.parent == nil, "bird parent error")
            addChild(ball_node)
        }
        print("> children.count \(self.children.count)")
        print("> balls.count \(self.content_ctrl.balls.count)")
        //print("child_num",self.children.count)
    }
    func join_balls_accordingly(){
        //print("hi")
        //print("child_num",self.children.count)
        print("+ parent generated - bird child adding")
        for bird in self.content_ctrl.balls{
            let bird_node = bird.ball_node
            assert(bird_node.parent == nil, "bird parent error")
            addChild(bird_node)
        }
        print("> children.count \(self.children.count)")
        print("> balls.count \(self.content_ctrl.balls.count)")
        //print("child_num",self.children.count)
    }
}


// MARK: - Utilities

extension GameScene{
    func reset_everything() {
        
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
        
        self.content_ctrl.controller_reset()
        
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
        
        // make sure there's n + 1 children
        assert(self.content_ctrl.bird_number + 1 == self.children.count ,"children number error : \(self.children.count) children(s)")
        // make sure there's n balls
        assert(self.content_ctrl.bird_number == self.content_ctrl.balls.count ,"ball array count error : \(self.children.count) children(s)")
    }
    
    func colPositionIndexGenerator() -> (CGFloat, CGFloat) {
        let iu = CGFloat.random(in: (self.difficulty_index*1.1)...1)
        let id = iu - (1+self.difficulty_index)
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
    
    

}


//MARK: - Update

extension GameScene{
    override func update(_ currentTime: TimeInterval) {
        
        /*
            UPDATES *Directed* by tick
         */
        let dt_sm = currentTime - self.colGeneratorTimer
        if  !self.content_ctrl.isGameOver{
            
            /* sm-tick update*/
            if dt_sm >= self.gameTickInterval {
                
                if self.content_ctrl.isGameBegin{
                    
                    // update col position
                    self.shiftColLeft()
                    
                }
                
                if self.content_ctrl.isUserBegin{
                    
                    //
                    //self.check_node_unique()
                    
                    
                    // update ball distance
                    self.updateBallDistScore()
                    
                    // update focus to *game scene*
                    self.updateFocusIndex()
                    
                    // update distance to *ball matrics*
                    self.updateColDistance()
                    
                    // update distance to *ball matrics*
                    self.update_velocity()
                    
                    // check restricted zone
                    self.checkRestrictedZone()
                    
                    // update is_active statu
                    self.updateCollisionStatus()
                    
                    // update birds remaining
                    self.content_ctrl.update_birds_remaining()
                    
                    // clean birds
                    self.cleanOutedBirds()
                    
                    // check game over, find the best bird
                    self.checkGameOver()
                }
                
                
                
                // reset time
                self.colGeneratorTimer = currentTime
            }
            
            /* md-tick update*/
            let dt_md = currentTime - self.jmpTimer
            
            if dt_md >= self.jmpTimeInterval {
                if self.content_ctrl.isUserBegin && !self.content_ctrl.isGameOver{
                    self.jump_accordingly()
                    self.jmpTimer = currentTime
                }
            }

            /* lg-tick update*/
            let dt_lg = currentTime - self.gameTickTimer

            if dt_lg >= self.colTimeInterval {
                    makeCol()
                    self.gameTickTimer = currentTime
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
            print("reset buttom start")
            self.reset_everything()
        }
        
        // game is over & you opened Auto Loop
        if self.content_ctrl.isGameOver && !self.content_ctrl.isReset && self.content_ctrl.isLooped{
            
            
            print("+ gameover start automatically")
            // reset logic
            self.reset_everything()                             // game scene reset (incl. generate stuffs)
            
            // begin logic
            self.content_ctrl.set_game_begin()                  // game begin first
            self.content_ctrl.counting_down_set_user_begin()    // user begin 3 secs later
            self.counting_down_set_active()                     // user begin 3 secs later
        }
        
    }
}


//MARK: - Touches logic

extension GameScene{
    
    override func mouseDown(with event: NSEvent){
        
        /*
            **Manually** Updating game statu
         */
        
        
        // on setting
        if self.content_ctrl.isOnSetting{
            return
        }
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
            
            print("+ gameover start")
            
            // reset logic
            self.reset_everything()                             // game scene reset (incl. generate stuffs)
            
            // begin logic
            self.content_ctrl.set_game_begin()
            self.content_ctrl.counting_down_set_user_begin()    // user begin 3 secs later
            self.counting_down_set_active()                     // user begin 3 secs later
            
            return
        }
        
        
        if true{
        // general start, due to the lazy reset bug, reset needed here
            
            
            print("+ general_starting")
            // reset logic
            self.reset_everything()                             // game scene reset (incl. generate stuffs)
            
            // begin logic
            self.content_ctrl.set_game_begin()                  // game begin first
            self.content_ctrl.counting_down_set_user_begin()    // user begin 3 secs later
            self.counting_down_set_active()                     // user begin 3 secs later
        }
        
        
        // Tap to begin  ---> begin
        
        
    }

    func counting_down_set_active(){
        // tap to start

        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(self.content_ctrl.count_down)) {
            for (index, _) in self.content_ctrl.balls.enumerated(){
                
                self.content_ctrl.balls[index].set_active()
                
            }
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

