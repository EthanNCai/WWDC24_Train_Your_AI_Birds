//
//  ReproductionBirdCard.swift
//  Train your own bird AI!
//
//  Created by 蔡俊志 on 2024/2/14.
//

import SwiftUI

struct ReproductionBirdCard: View {
    var body: some View {
        VStack{
            HStack{
                    
                VStack
                {
                    Image(systemName: "bird.fill")
                    .foregroundColor(.white)
                        .font(.title3)
                        .padding(5)
                        .background(){
                            Circle()
                                .foregroundColor(.red)
                        }
                
                }
                    
                
                HStack{
                    VStack(alignment: .leading,spacing: 5){
                        Image(systemName: "pin")
                        
                        Image(systemName: "ruler.fill")
                       
                    }.fontWeight(.heavy)
                    VStack(alignment: .leading,spacing: 3){
                        Gauge(value: 12, in: 0...50, label: {})
                            .tint(.red)
                        Gauge(value: 37, in: 0...50, label: {})
                            .tint(.blue)
                       
                    }
                    .frame(maxWidth: 35)
                    .fontWeight(.heavy)
                }
                
               
            }
            
        }
            .padding()
            .mask(RoundedRectangle(cornerRadius: 18))
            .overlay(){
                RoundedRectangle(cornerRadius: 18).stroke(lineWidth: 5).fill(.green)
            }
            .padding(10)
            .overlay(){
                HStack{
                    Spacer()
                    VStack{
                        
                        Image(systemName: "checkmark.circle.fill")
                            .background(){
                                Circle()
                            }
                            .font(.largeTitle)
                            .foregroundColor(.green)
                            .overlay(){
                                Image(systemName: "checkmark")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                            }
                        
        
                           
                        Spacer()
                    }
                }
            }
            
    }
}

struct ReproductionBirdCard_Previews: PreviewProvider {
    static var previews: some View {
        ReproductionBirdCard()
    }
}
