//
//  BirdCapsuleTest.swift
//  Train your own bird AI!
//
//  Created by 蔡俊志 on 2024/2/14.
//

import SwiftUI

struct BirdCapsuleTest: View {
    var body: some View {
        VStack(alignment: .leading) {
                HStack {
                    
                    
                    VStack(spacing: 4) {
                        Text("Alive")
                            .fontWeight(.heavy)
                        HStack(spacing:0){
                            VStack{
                                Image(systemName: "pin")
                                Image(systemName: "ruler.fill")
                            }
                            VStack{
                                Text(String(format: ":%8.0f", 123.2))
                                    .font(.caption2)
                                    .fontWeight(.heavy)
                                Text(String(format: ":%8.0f", 123.2))
                                    .font(.caption2)
                                    .fontWeight(.heavy)
                            }
                        }
                    }
                }
            }
            .padding(10)
            
            .mask(RoundedRectangle(cornerRadius: 15))
            .overlay(){
                // jump indicator
                true ?
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(false ? Color.orange.opacity(0.9) : Color.clear, lineWidth: 10) :
                    RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.clear, lineWidth: 410)
            }
            .overlay(){
                // alive indicator
                true ?
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(true ? Color.green.opacity(0.9) : Color.red.opacity(0.9), lineWidth: 5) :
                    RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.clear, lineWidth: 410)
            }
            .padding(10)
            .overlay(){
                HStack{
                    Spacer()
                    VStack{
                        Image(systemName: "bird.fill")
                            .foregroundColor(.white)
                            .padding(3)
                            .background(){
                                Circle().fill(.red)
                            }
                        Spacer()
                    }
                    
                }
            }
        }
    }


struct BirdCapsuleTest_Previews: PreviewProvider {
    static var previews: some View {
        BirdCapsuleTest()
    }
}
