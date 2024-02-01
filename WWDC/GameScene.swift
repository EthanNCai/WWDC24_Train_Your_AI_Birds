//
//  GameScene.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene{
    
    @ObservedObject var pageContentController: PageContentController
    var colGeneratorTimer: TimeInterval = 0.0
    var gameTickTimer: TimeInterval =  0.0
    var onscreen_cols: [Int] = []
    var newest_col_index = 0
    var currently_focus = 1
    var ball:[Ball] = []
    
    //  indexs
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
        //generateDefaultCol()
        //generateNewCol(col_index: 1)
    }
    
    
    func checkForCollision() {
           
    }
    
    
    func makeBall(){
        
        self.ball.removeAll()
        self.ball.append(Ball(x: self.ballXPosition, y: self.size.height/2, ball_index: 1, ball_radius: 15.0, ball_color: .red))
        let ball_node = self.ball[0].ball_node
        addChild(ball_node)
    }
    func makeBackgrounds(){
        let background = SKSpriteNode(color: .gray, size: self.size)
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        addChild(background)
    }
    
    
    func moveColLeft() {
            
        self.pageContentController.distance_score += Float(self.speed_index * self.size.width)
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
    
    
    func generateNewCol(provided_position: CGFloat = -1){
        
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
        //colu.physicsBody = SKPhysicsBody(rectangleOf: colu.size)
        //colu.physicsBody?.isDynamic = false
        colu.name = "colu" + String(col_index)
        
        addChild(colu)
        
        
        let cold = SKSpriteNode(color: .red, size: CGSize(width: colwidth, height: colheight))
        cold.anchorPoint = CGPoint.zero
        cold.position = CGPoint(x: position , y: self.size.height * pos_index_d)
        //cold.physicsBody = SKPhysicsBody(rectangleOf: cold.size)
        //cold.physicsBody?.isDynamic = false
        cold.name = "cold" + String(col_index)
        
        addChild(cold)
        
        self.onscreen_cols.append(col_index)
        
    }
    func colPositionIndexGenerator() -> (CGFloat, CGFloat) {
        let iu = CGFloat.random(in: (self.difficulty_index*1.1)...1)
        let id = iu - (1+self.difficulty_index)
        return (iu, id)
    }
    
    func getFocusIndex() -> Int{
        for col_index in self.onscreen_cols{
            let col_name = "cold" + String(col_index)
            let col_node = self.childNode(withName: col_name)!
            if col_node.position.x > self.ballXPosition{
                return col_index
            }
        }
        return 0
    }
    
    func get_distance() -> (Float, Float) {
        
        let ball = self.ball[0].get_ball_node()
        let colu_index = self.pageContentController.current_focus
        
        if colu_index == 0{
            return (99999,99999)
        }
        let colu_name = "colu" + String(colu_index)
        let colu = self.childNode(withName: colu_name)!
        
        // ball x,y
        let ball_x = ball.position.x
        let ball_y = ball.position.y
        // upper x,y
        let colu_x = colu.position.x
        let colu_y = colu.position.y
        // downer x,y
        let cold_x = colu_x
        let cold_y = colu_y - self.size.height * self.difficulty_index
        
        let ball_cold_distance = Float(sqrt(pow(ball_x - cold_x, 2) + pow(ball_y - cold_y, 2)))
        let ball_colu_distance = Float(sqrt(pow(ball_x - colu_x, 2) + pow(ball_y - colu_y, 2)))
    
        return (ball_colu_distance, ball_cold_distance)
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
                moveColLeft()
                
                // check collision
                checkForCollision()
                
                // get focus
                self.pageContentController.current_focus = self.getFocusIndex()
                
                // get distance
                let (distance_u, distance_d) = self.get_distance()
                self.pageContentController.distance_u = distance_u
                self.pageContentController.distance_d = distance_d
                
                // reset time
                self.colGeneratorTimer = currentTime
            }

            /* non-tick update*/
            let dt_lg = currentTime - self.gameTickTimer

            if dt_lg >= self.colTimeInterval {
                    generateNewCol()
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
        fly()
        
    }
    func fly(){
        // tap to fly
        if self.pageContentController.isBegin {
            self.ball[0].jump()
        }
    }
    func countingDown(){
        // tap to start
        if self.pageContentController.isTapBegin == false{
            self.pageContentController.startCountingDown()
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(self.pageContentController.count_down)) {
                self.ball[0].set_active()
            }
        }
    }
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

