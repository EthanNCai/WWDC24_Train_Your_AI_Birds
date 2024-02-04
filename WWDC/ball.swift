//
//  ball.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/2.
//
import SpriteKit
import SwiftUI


struct Ball:Identifiable{
    
    var id = UUID()

    
    // ball
    let ballRadius:CGFloat
    var ball_node:SKSpriteNode
    var ball_index:Int
    var distance_score:Float = 0
    var isActive:Bool = true
    
    
    // parameter
    var distance_u:Float = 0.0
    var distance_d:Float = 0.0
    var distance_top:Float = 0.0
    var distance_bottom:Float = 0.0
    var velocity:Float = 0.0
    
    var weights:[Float]
    var bias:[Float]
    
    init(x: CGFloat, y: CGFloat, ball_index:Int, ball_radius: Float, ball_color: Color) {
        
        self.ballRadius = CGFloat(ball_radius)
        self.ball_node = SKSpriteNode(imageNamed: "bird")
        self.ball_node.scale(to: CGSize(width: 38, height: 38))
        self.ball_index = ball_index
        self.ball_node.position = CGPoint(x: x, y: y)
        self.ball_node.name = "ball" + String(ball_index)
        self.ball_node.color = NSColor(ball_color)
        self.weights = (0..<10).map { _ in Float.random(in: 0...1) }
        self.bias = (0..<10).map { _ in Float.random(in: 0...1) }
        
    }
     
    
    func get_dicision_is_jump(scene_size: CGSize) -> Bool{
        
        var jump: Float = 0
        var not_jump: Float = 0
        
        let norm_distance_d =  self.normalization(self.distance_d, lowerLimit: 0, upperLimit: Float(scene_size.height))
        let norm_distance_u = self.normalization(self.distance_u, lowerLimit: 0, upperLimit: Float(scene_size.height))
        let norm_distance_top = self.normalization(self.distance_top, lowerLimit: 0, upperLimit: Float(scene_size.height))
        let norm_distance_bottom = self.normalization(self.distance_bottom, lowerLimit: 0, upperLimit: Float(scene_size.height))
        let norm_velocity = self.normalization(self.distance_top, lowerLimit: -500, upperLimit: 500)
        
        //relu + linear
        jump += max(0.0, (norm_distance_d * self.weights[0] + self.bias[0]))
        jump += max(0.0, (norm_distance_u * self.weights[1] + self.bias[1]))
        jump += max(0.0, (norm_distance_top * self.weights[2] + self.bias[2]))
        jump += max(0.0, (norm_distance_bottom * self.weights[3] + self.bias[3]))
        jump += max(0.0, (norm_velocity * self.weights[4] + self.bias[4]))
        
        //relu + linear
        not_jump += max(0.0, (norm_distance_d * self.weights[5] + self.bias[5]))
        not_jump += max(0.0, (norm_distance_u * self.weights[6] + self.bias[6]))
        not_jump += max(0.0, (norm_distance_top * self.weights[7] + self.bias[7]))
        not_jump += max(0.0, (norm_distance_bottom * self.weights[8] + self.bias[8]))
        not_jump += max(0.0, (norm_velocity * self.weights[9] + self.bias[9]))
        
        //softmax
        let (jump_softmax, not_jump_softmax) = (exp(jump) / (exp(jump) + exp(not_jump)), exp(not_jump) / (exp(jump) + exp(not_jump)))
        
        print("softmax",jump_softmax,not_jump_softmax)
        if jump_softmax > not_jump_softmax && jump_softmax > 0.7{
            return true
        }else{
            return false
        }
    }
    
    func normalization(_ input: Float, lowerLimit: Float = -500, upperLimit: Float = 500) -> Float {
        if input > upperLimit{
            return 1
        }
        if input < upperLimit{
            return 0
        }
        let normalizedData = (input - lowerLimit) / (upperLimit - lowerLimit)
        return max(0, min(1, normalizedData))
    }
    
    
    mutating func set_active(){
        self.ball_node.physicsBody = SKPhysicsBody(circleOfRadius: self.ballRadius)
        self.isActive = true
    }
    
    mutating func set_inactive(){
        self.ball_node.physicsBody = nil
        self.isActive = false
    }
    
    
    func jump(){
        if self.isActive{
            self.ball_node.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 18))
        }
    }
    
    func get_ball_node() -> SKNode{
        return self.ball_node
    }
    
    func print_parameter(){
        
        print("parameter")
    }
    
}
