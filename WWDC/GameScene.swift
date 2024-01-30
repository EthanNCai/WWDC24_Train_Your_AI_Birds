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
    var speed_index: CGFloat = 0.005
    
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
        //generateDefaultCols
        //generateNewCol(col_index: 1)
    }
    
    
    func checkForCollision() {
           
    }
    
    
    func makeBall(){
        let ballRadius: CGFloat = 15.0
        let ball = SKShapeNode(circleOfRadius: ballRadius)
        ball.fillColor = .red
        ball.position = CGPoint(x: self.size.width*(1/5), y: self.size.height - (ballRadius + 5))
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ball.name = "ba0"
        addChild(ball)
    }
    func makeBackgrounds(){
        let background = SKSpriteNode(color: .gray, size: self.size)
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        addChild(background)
    }
    func generateDefaultCol(){
        
    }
    
    func moveColLeft() {
            
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
    
    func generateNewCol(){
        
        self.newest_col_index += 1
        let col_index = newest_col_index
        let (iu,id) = colPositionGenerator()
        let colwidth: CGFloat = 8.0
        let colheight: CGFloat = self.size.height
        
        let colu = SKSpriteNode(color: .green, size: CGSize(width: colwidth, height: colheight))
        colu.anchorPoint = CGPoint.zero
        colu.position = CGPoint(x: self.size.width*(4/5) , y: self.size.height * iu)
        //colu.physicsBody = SKPhysicsBody(rectangleOf: colu.size)
        //colu.physicsBody?.isDynamic = false
        colu.name = "colu" + String(col_index)
        
        addChild(colu)
        
        
        let cold = SKSpriteNode(color: .red, size: CGSize(width: colwidth, height: colheight))
        cold.anchorPoint = CGPoint.zero
        cold.position = CGPoint(x: self.size.width*(4/5) , y: self.size.height * id)
        //cold.physicsBody = SKPhysicsBody(rectangleOf: cold.size)
        //cold.physicsBody?.isDynamic = false
        cold.name = "cold" + String(col_index)
        
        addChild(cold)
        
        self.onscreen_cols.append(col_index)
        
    }
    func colPositionGenerator() -> (CGFloat, CGFloat) {
        let iu = CGFloat.random(in: 0.25...1)
        let id = iu - 1.2
        return (iu, id)
    }
}



//MARK: - Update

extension GameScene{
    override func update(_ currentTime: TimeInterval) {
        let dt = currentTime - self.colGeneratorTimer

            if dt >= 0.02 {
                moveColLeft()
                checkForCollision()
                self.colGeneratorTimer = currentTime
            }

        let dtCol = currentTime - self.gameTickTimer

            if dtCol >= 3.0 {
                generateNewCol()
                self.gameTickTimer = currentTime
            }
    }
}


//MARK: - Touches logic

extension GameScene{
    
    override func mouseDown(with event: NSEvent) {
        let ball = self.childNode(withName: "ba0")
        ball?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 18))
    }
    override func touchesBegan(with event: NSEvent) {
        let ball = self.childNode(withName: "ba0")
        ball?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 18))
    }
    override func touchesMoved(with event: NSEvent) {
        //
    }
    override func touchesEnded(with event: NSEvent) {
        //
    }
    
}
