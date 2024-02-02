//
//  ParamVisulizer.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/2.
//

import SwiftUI

struct ParamVisulizer: View {
    var weights:[Float] = [0.23,-0.1,1.3,-0.5,0.7,0.233,-0.1,1.3,-0.5,0.7]
    var bias:[Float] = [0.23,-0.1,1.3,-0.5,0.7,0.23,-0.1,1.3,-0.5,0.7]
    var body: some View {
        VStack {
            HStack(spacing: 0){
                ForEach(0..<weights.count/2, id: \.self) { index in
                    
                        Text(String(format: "%8.2f",weights[index]))
                            .font(.system(size: 10))
                            .padding(2)
                            .background(weights[index]>0 ? .red.opacity(Double(weights[index])) : .green.opacity(Double(abs(weights[index]))))
                    
                }
            }
        }
    }
}

struct ParamVisulizer_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            VStack{
                
                HStack{
                    Image(systemName: "bird.fill")
                    Text("Rank.3")
                    Text("Distance: 102.21")
                    HStack{
                        Image(systemName: "waveform.path.ecg")
                        Text("Alive")
                    }
                    .padding(2)
                    .background(.green.opacity(0.6))
                    .mask(RoundedRectangle(cornerRadius: 3))
                }
                HStack{
                    Text("Gene:")
                    ParamVisulizer()
                    Image(systemName: "ellipsis")
                }
                
            }
            Divider()
            
            VStack{
                
                HStack{
                    Image(systemName: "bird.fill")
                    Text("Rank.1")
                    Text("Distance: 102.21")
                    HStack{
                        Image(systemName: "waveform.path.ecg")
                        Text("Alive")
                    }
                    .padding(2)
                    .background(.green.opacity(0.6))
                    .mask(RoundedRectangle(cornerRadius: 3))
                }
                HStack{
                    Text("Gene:")
                    ParamVisulizer()
                    Image(systemName: "ellipsis")
                }
                
            }
            Divider()
            
            VStack{
                
                HStack{
                    Image(systemName: "bird.fill")
                    Text("Rank.2")
                    Text("Distance: 102.21")
                    HStack{
                        Image(systemName: "waveform.path.ecg")
                        Text("Alive")
                    }
                    .padding(2)
                    .background(.green.opacity(0.6))
                    .mask(RoundedRectangle(cornerRadius: 3))
                }
                HStack{
                    Text("Gene:")
                    ParamVisulizer()
                    Image(systemName: "ellipsis")
                }
                
            }
        }
        .padding()
        
    }
}
