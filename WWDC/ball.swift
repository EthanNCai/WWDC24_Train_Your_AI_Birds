//
//  ball.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/2.
//
import SpriteKit
import SwiftUI


struct Ball:Identifiable, Hashable{
 
    var id = UUID()

    
    // ball
    let ballRadius:CGFloat
    var ball_node:SKSpriteNode
    var ball_index:Int
    
    var fitness_score:Int = 0
    var isActive:Bool = true
    
    
    // parameter
    var distance_u:Float = 0.0
    var distance_d:Float = 0.0
    var distance_top:Float = 0.0
    var distance_bottom:Float = 0.0
    var velocity:Float = -700
    var is_jumped: Bool = false
    var fly_probability: Float = 0.0
    var mlp:SimpleNeuralNetwork
    let color: Color
    
    //score
    var distance_score:Float = 0
    var avg_gap_dist_score: Float = 0
    var avg_gap_dist_score_list:[Float] = []
    
    var norm_avg_gap_dist_score: Float = 0
    var norm_distance_score:Float = 0
    
    
    init(x: CGFloat, y: CGFloat, ball_index:Int, ball_radius: Float, ball_color: Color, gene_len: Int) {
        
        self.ballRadius = CGFloat(ball_radius)
        self.ball_node = SKSpriteNode(imageNamed: "bird")
        self.ball_node.scale(to: CGSize(width: 50, height: 50))
        self.ball_index = ball_index
        self.ball_node.position = CGPoint(x: x, y: y)
        self.ball_node.name = "ball" + String(ball_index)
        self.color = Color.random()
        self.ball_node.color = NSColor(self.color)
        self.ball_node.colorBlendFactor = 0.5
        self.ball_node.zPosition = -2
        self.mlp = SimpleNeuralNetwork(hidden_layer_len: 18)

        
    }
    init(x: CGFloat, y: CGFloat, ball_index:Int, ball_radius: Float, ball_color: Color, mlp: SimpleNeuralNetwork) {
        
        self.ballRadius = CGFloat(ball_radius)
        self.ball_node = SKSpriteNode(imageNamed: "bird")
        self.ball_node.scale(to: CGSize(width: 50, height: 50))
        self.ball_index = ball_index
        self.ball_node.position = CGPoint(x: x, y: y)
        self.ball_node.zPosition = -2
        self.ball_node.name = "ball" + String(ball_index)
        self.color = Color.random()
        self.ball_node.color = NSColor(self.color)
        self.ball_node.colorBlendFactor = 0.5
        
        self.mlp = mlp
        
    }
    
   
     
    
    func get_dicision_is_jump(scene_size: CGSize) -> (Float,Bool){
        
        let norm_distance_d =  self.normalization(self.distance_d, lowerLimit: 0, upperLimit: Float(scene_size.height))
        let norm_distance_u = self.normalization(self.distance_u, lowerLimit: 0, upperLimit: Float(scene_size.height))
        let norm_velocity = self.normalization(self.velocity, lowerLimit: -330, upperLimit: 330)
        
        let input_tensor:[Float] = Array([norm_distance_d,norm_distance_u,norm_velocity])
        
        let result = self.mlp.forward(input: input_tensor)
  
        let jump_softmax = result[0]
        let not_jump_softmax = result[1]

        if jump_softmax > not_jump_softmax {
            return (jump_softmax,true)
        }else{
            return (jump_softmax,false)
        }
    }
    
    func normalization(_ input: Float, lowerLimit: Float, upperLimit: Float) -> Float {
        if input > upperLimit{
            return 1
        }
        if input < lowerLimit{
            return 0
        }
        let normalizedData = (input - lowerLimit) / (upperLimit - lowerLimit)
        return max(0, min(1, normalizedData))
    }
    
    
    mutating func set_active(){
        self.ball_node.physicsBody = SKPhysicsBody(circleOfRadius: self.ballRadius)
        self.ball_node.physicsBody?.collisionBitMask = 0
        self.isActive = true
    }
    
    mutating func set_inactive(){
        self.ball_node.physicsBody = nil
        self.isActive = false
    }
    
    mutating func set_fly_probability(fly_probability: Float){
        self.fly_probability = fly_probability
    }
    
    
    func jump(){
        if self.isActive{
            self.ball_node.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 35))
        }
    }
    
    func human_jump(){
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

extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        
        return Color(red: red, green: green, blue: blue)
    }
}
