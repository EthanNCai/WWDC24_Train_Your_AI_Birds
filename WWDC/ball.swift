//
//  ball.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/2.
//
import SpriteKit
import SwiftUI


class Ball{
    
    // ball
    let ballRadius:CGFloat
    var ball_node:SKShapeNode
    
    var focus:Int = 3
    var distance_score:Float = 0.12
    var isActive:Bool = false
    
    
    // parameter
    var distance_u:Float = 0.1
    var distance_d:Float = 0.1
    var distance_top:Float = 0.1
    var distance_bottom:Float = 0.1
    var velocity:Float = 0.1
    
    
    init(x: CGFloat, y: CGFloat, ball_index:Int, ball_radius: Float, ball_color: Color) {
        
        self.ballRadius = CGFloat(ball_radius)
        self.ball_node = SKShapeNode(circleOfRadius: 15)
        self.ball_node.position = CGPoint(x: x, y: y)
        self.ball_node.name = "ball" + String(ball_index)
        self.ball_node.fillColor = NSColor(ball_color)
        
    }
     
    
    func get_dicision_is_jump()->Bool{
        
        // forward
        
        
        return false
    }
    
    func set_active(){
        self.ball_node.physicsBody = SKPhysicsBody(circleOfRadius: self.ballRadius)
        self.isActive = true
    }
    
    func set_inactive(){
        self.ball_node.physicsBody = nil
        self.isActive = false
    }
    
    func jump(){
        assert(self.isActive == true,"inactive ball jump ERROR")
        self.ball_node.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 18))
    }
    
    func get_ball_node() -> SKNode{
        return self.ball_node
    }
    
}
