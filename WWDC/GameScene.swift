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
    @ObservedObject var pageContentController: PageContentController
    
    //  hyper-params
    var difficulty_index: CGFloat = 0.3
    var speed_index: CGFloat = 0.005
    var colTimeInterval: Double = 3.0
    var gameTickInterval: Double = 0.02
    var ballRadius:CGFloat = 15.0
    var colDistanceInterval: CGFloat {
        
        return CGFloat((colTimeInterval / gameTickInterval) * speed_index) * self.size.width
    }
    var ballXPosition: CGFloat {
        return self.size.width*(1/5)
    }
    
    // on-going variables
    var colGeneratorTimer: TimeInterval = 0.0
    var gameTickTimer: TimeInterval =  0.0
    var onscreen_cols: [Int] = []
    var newest_col_index = 0
    var currently_focus = 0
    var is_on_restricted_area = false
   
    
    init(viewController: PageContentController) {
        self.pageContentController = viewController
        super.init(size: viewController.size)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        makeBackgrounds()
        makeBall()
        
    }
    
    func checkRestrictedZone() {
        
        
    }
    
    
    func updateCollisionStatus() {
        let ball = self.pageContentController.balls[0]
        let ball_node = ball.ball_node
        
        // check for cell and floor
        
        let y = ball.ball_node.position.y
        let y_lower_boundary = 0 + ball.ballRadius + 4
        let y_higher_boundary = self.size.height - ball.ballRadius - 4
        
        if y < y_lower_boundary || y > y_higher_boundary{
            self.pageContentController.balls[0].isActive = false
        }
        
        // check for column
    }
    
    func makeBall(){
        
        self.pageContentController.balls.removeAll()
        self.pageContentController.balls.append(Ball(x: self.ballXPosition, y: self.size.height/2, ball_index: 1, ball_radius: 15.0, ball_color: .red))
        let ball_node = self.pageContentController.balls[0].ball_node
        addChild(ball_node)
    }
    
    func makeBackgrounds(){
        let background = SKSpriteNode(color: .gray, size: self.size)
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        addChild(background)
    }
    
    func updateBallDistScore(){
        self.pageContentController.balls[0].distance_score += Float(self.speed_index * self.size.width)
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
    
    
    
    func updateFocusIndex(){
        for col_index in self.onscreen_cols{
            let col_name = "cold" + String(col_index)
            let col_node = self.childNode(withName: col_name)!
            if col_node.position.x > self.ballXPosition{
                self.currently_focus =  col_index
                self.pageContentController.current_focus = col_index
                return
            }
        }
        self.currently_focus =  0
        self.pageContentController.current_focus = 0
    }
    
    func updateColDistance() {
        
        
        let colu_index = self.currently_focus
        
        if colu_index == 0{
            self.pageContentController.balls[0].set_distance(distance_u: -1, distance_d: -1)
            return
        }
        let colu_name = "colu" + String(colu_index)
        let colu = self.childNode(withName: colu_name)!
        
        // ball x,y
        let ball_x = self.pageContentController.balls[0].ball_node.position.x
        let ball_y = self.pageContentController.balls[0].ball_node.position.y
        // upper x,y
        let colu_x = colu.position.x
        let colu_y = colu.position.y
        // downer x,y
        let cold_x = colu_x
        let cold_y = colu_y - self.size.height * self.difficulty_index
        
        let ball_cold_distance = Float(sqrt(pow(ball_x - cold_x, 2) + pow(ball_y - cold_y, 2)))
        let ball_colu_distance = Float(sqrt(pow(ball_x - colu_x, 2) + pow(ball_y - colu_y, 2)))
    
        self.pageContentController.balls[0].set_distance(distance_u: ball_colu_distance, distance_d: ball_cold_distance)
        
    }
    
    func cleanOutedBirds() {
        if !self.pageContentController.balls.isEmpty && !self.pageContentController.balls[0].isActive {
            let ball_node = self.pageContentController.balls[0].ball_node
            let scaleAction = SKAction.scale(to: 0.0, duration: 0.2)
            let removeAction = SKAction.removeFromParent()
            let sequence = SKAction.sequence([scaleAction, removeAction])
            ball_node.run(sequence)
        }
    }
}



// MARK: - Utilities

extension GameScene{
    func resetGame() {
        
        self.pageContentController.reset()
        self.onscreen_cols.removeAll()
        self.removeAllChildren()
        newest_col_index = 0
        colGeneratorTimer = 0.0
        gameTickTimer = 0.0
        
        makeBackgrounds()
        makeBall()
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
        let dt_sm = currentTime - self.colGeneratorTimer
        
        
        if self.pageContentController.isTapBegin{
            
            /* tick update*/
            if dt_sm >= self.gameTickInterval {
                
                // update col position
                self.shiftColLeft()
                
                // update ball distance
                self.updateBallDistScore()
                
                // update focus to *game scene*
                self.updateFocusIndex()
                
                // update distance to *ball matrics*
                self.updateColDistance()
                
                // check restricted zone
                self.checkRestrictedZone()
                
                // update is_active statu
                self.updateCollisionStatus()
                
                // clean birds
                self.cleanOutedBirds()
                
                // get jump prob
                _ = self.pageContentController.balls[0].get_dicision_is_jump()
                
                // apply jump
                
                
                
                // reset time
                self.colGeneratorTimer = currentTime
            }
            

            /* non-tick update*/
            let dt_lg = currentTime - self.gameTickTimer

            if dt_lg >= self.colTimeInterval {
                    makeCol()
                    self.gameTickTimer = currentTime
            }
        }
        if self.pageContentController.isReset{
            resetGame()
        }

        
    }
}


//MARK: - Touches logic

extension GameScene{
    
    override func mouseDown(with event: NSEvent) {
        countingDown()
        jump()
        
    }
    func jump(){
        // tap to fly
        if self.pageContentController.isBegin {
            self.pageContentController.balls[0].jump()
        }
    }
    func countingDown(){
        // tap to start
        if self.pageContentController.isTapBegin == false{
            self.pageContentController.startCountingDown()
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(self.pageContentController.count_down)) {
                self.pageContentController.balls[0].set_active()
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

