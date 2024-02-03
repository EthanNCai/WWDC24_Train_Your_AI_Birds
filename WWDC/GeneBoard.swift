//
//  ParamVisulizer.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/2.
//

import SwiftUI


struct GeneBoard: View{
    
    var ball:[Ball] = []
    var body: some View{
        
        VStack(spacing: 1){
            

            GeneItem()
            GeneItem()
            GeneItem()
        }
        
    }
}

struct GeneItem: View{
    
    var rank:Int = 1
    
    var body: some View{
        
        HStack(spacing:5){
            

            Text("1 st.")
            ParamVisulizer()
            Image(systemName: "ellipsis")
            Spacer()
            Text("distance")
                .font(.system(size: 8))
            Text("1231.3")
                .font(.system(size: 11))
            
            
        }.padding(1)
        
    }
}

struct ParamVisulizer: View {
    var weights:[Float] = [0.23,-0.1,1.3,-0.5,0.7,0.233,-0.1,1.3,-0.5,0.7]
    var bias:[Float] = [0.23,-0.1,1.3,-0.5,0.7,0.23,-0.1,1.3,-0.5,0.7]
    var body: some View {
        VStack {
            HStack(spacing: 0){
                ForEach(0..<weights.count/2, id: \.self) { index in
                    
                        Text(String(format: "%4.2f",weights[index]))
                            .font(.system(size: 8))
                            .padding(1)
                            .background(weights[index]>0 ? .red.opacity(Double(weights[index])) : .green.opacity(Double(abs(weights[index]))))
                    
                }
            }
        }
    }
}
