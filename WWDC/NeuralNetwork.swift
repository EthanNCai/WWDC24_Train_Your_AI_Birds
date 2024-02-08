import Foundation

struct SimpleNeuralNetwork:Hashable{
    
    let input_len = 3
    let output_len = 2
    var hidden_len: Int
    
    // len
    var w1_len: Int
    var w2_len: Int
    var b1_len: Int
    var b2_len: Int
    
    // parameters
    var weights_layer1:[Float]
    var bias_layer1:[Float]
    var weights_layer2:[Float]
    var bias_layer2:[Float]
    
    
    init(hidden_layer_len:Int){
    
        // calculate all layer lengths
        self.hidden_len = hidden_layer_len
        self.w1_len = self.input_len * hidden_layer_len
        self.b1_len = hidden_layer_len
        self.w2_len = self.output_len * hidden_layer_len
        self.b2_len = self.output_len
        
        // ramdom initialize weights and bias
        self.weights_layer1 = (0..<w1_len).map { _ in Float.random(in: -5...5) }
        self.weights_layer2 = (0..<w2_len).map { _ in Float.random(in: -5...5) }
        self.bias_layer1 = (0..<b1_len).map { _ in Float.random(in: 0...0.1) }
        self.bias_layer2 = (0..<b2_len).map { _ in Float.random(in: 0...0.1) }
        
    }
    
    init(w1:[Float],w2:[Float],b1:[Float],b2:[Float]){
        self.weights_layer1 = w1
        self.weights_layer2 = w2
        self.bias_layer1 = b1
        self.bias_layer2 = b2
        let hidden_layer_len = b1.count
        self.hidden_len = hidden_layer_len
        self.w1_len = self.input_len * hidden_layer_len
        self.b1_len = hidden_layer_len
        self.w2_len = self.output_len * hidden_layer_len
        self.b2_len = self.output_len
    }
    
    func feed_forward1(input_tensor:[Float])->[Float]{
        
        assert(input_tensor.count == self.input_len, "input len incorrect expected\(self.input_len), but got \(input_tensor.count)")
        let input_tensor = Array(input_tensor)
        var hidden_tensor:[Float] = Array(repeating: 0, count: self.hidden_len)
        for input_index in 0..<self.input_len{
            for hidden_index in 0..<self.hidden_len{
                let weight_index = input_index * self.hidden_len + hidden_index
                hidden_tensor[hidden_index] += (self.weights_layer1[weight_index] * input_tensor[input_index] + self.bias_layer1[hidden_index])
            }
        }

        return hidden_tensor
    }
    
    func feed_forward2(hidden_tensor:[Float])->[Float]{
        assert(hidden_tensor.count == self.hidden_len, "input len incorrect expected\(self.hidden_len), but got \(hidden_tensor.count)")
        let hidden_tensor = Array(hidden_tensor)
        var output_tensor:[Float] = Array(repeating: 0, count: self.output_len)
        for hidden_index in 0..<self.hidden_len{
            for output_index in 0..<self.output_len{
                let weight_index = hidden_index * self.output_len + output_index
                output_tensor[output_index] += (self.weights_layer2[weight_index] * hidden_tensor[hidden_index] + self.bias_layer2[output_index])
            }
        }
        return output_tensor
    }
    
    func ReLU(input_tensor:[Float])->[Float] {
        var output_tensor:[Float] = Array(repeating: 0, count: input_tensor.count)
        for (index,value_) in input_tensor.enumerated(){
            output_tensor[index] = max(0,value_)
        }
        return output_tensor
    }
    
    func softmax(input_tensor:[Float])->[Float]{
        
        let jump = input_tensor[0]
        let not_jump = input_tensor[1]
        let output_tensor:[Float] = [exp(jump) / (exp(jump) + exp(not_jump)), exp(not_jump) / (exp(jump) + exp(not_jump))]
        return output_tensor
    }
    
    func forward(input: [Float]) -> [Float]{
    
        let x1 = self.feed_forward1(input_tensor: input)
        let x2 = self.ReLU(input_tensor: x1)
        let x3 = self.feed_forward2(hidden_tensor: x2)
        let x4 = self.softmax(input_tensor: x3)
        return x4
    }
    
}
