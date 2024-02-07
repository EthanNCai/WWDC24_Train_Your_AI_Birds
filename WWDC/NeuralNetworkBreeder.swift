class NNBreader{
    
    static func weight_fusion(nn1:SimpleNeuralNetwork, nn2:SimpleNeuralNetwork, mutate_probability:Float) -> SimpleNeuralNetwork{
        
//      let input_len = 3
//      let output_len = 2
//      let hidden_len: Int = nn1.hidden_len
        let w1_len = nn1.w1_len
        let w2_len = nn1.w2_len
        let b1_len = nn1.b1_len
        let b2_len = nn1.b2_len
        assert(nn1.hidden_len == nn2.hidden_len, "hidden layer length incorporate")
        
        // randomly generate break point
        
        let w1_break_point = Int.random(in: 1..<(w1_len-1))
        let w2_break_point = Int.random(in: 1..<(w2_len-1))
        let b1_break_point = Int.random(in: 1..<(b1_len-1))
        let b2_break_point = Int.random(in: 0..<(b2_len))
        
        // make weight_layer1
        var new_w1 = Array(nn1.weights_layer1.prefix(w1_break_point) + nn2.weights_layer1.suffix(from: w1_break_point))
        
        // make weight_layer2
        var new_w2 = Array(nn1.weights_layer2.prefix(w2_break_point) + nn2.weights_layer2.suffix(from: w2_break_point))
        
        // make bias_layer1
        var new_b1 = Array(nn1.bias_layer1.prefix(b1_break_point) + nn2.bias_layer1.suffix(from: b1_break_point))
        
        // make bias_layer2
        var new_b2 = Array(nn1.bias_layer2.prefix(b2_break_point) + nn2.bias_layer2.suffix(from: b2_break_point))
        
        // mutate
        let w1_flip_digits = Int(Float(w1_len) * mutate_probability)
        let w2_flip_digits = Int(Float(w2_len) * mutate_probability)
        let b1_flip_digits = Int(Float(b1_len) * mutate_probability)
        
        for _ in 0...w1_flip_digits{
            let mutate_point = Int.random(in: 1..<(w1_len-1))
            let mutate_value = Float.random(in: -1...1)
            new_w1[mutate_point] = mutate_value
        }
        for _ in 0...w2_flip_digits{
            let mutate_point = Int.random(in: 1..<(w2_len-1))
            let mutate_value = Float.random(in: -1...1)
            new_w2[mutate_point] = mutate_value
        }
        for _ in 0...b1_flip_digits{
            let mutate_point = Int.random(in: 1..<(b1_len-1))
            let mutate_value = Float.random(in: -1...1)
            new_b1[mutate_point] = mutate_value
        }
        
        let nn_new = SimpleNeuralNetwork(w1: new_w1, w2: new_w2, b1: new_b1, b2: new_b2)
        
        return nn_new
    }
    
    
}
