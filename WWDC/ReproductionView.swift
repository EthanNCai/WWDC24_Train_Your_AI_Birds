//
//  ReproductionView.swift
//  Train your own bird AI!
//
//  Created by 蔡俊志 on 2024/2/14.
//

import SwiftUI

struct ReproductionView: View {
    var body: some View {
        VStack{
            Text("Round 1 is over! Now, generate the birds for next round")
                .font(.title)
            Text("Please select the best 2-4 birds you think suitable for breeding the next generation\n based on the below two scores")
                .font(.title2)
                .padding()
                .padding(.horizontal)
            
            HStack{
                VStack{
                    
                    Image(systemName: "pin")
                        .fontWeight(.heavy)
                    Image(systemName: "ruler.fill")
                        .fontWeight(.heavy)
                }
                VStack(alignment: .leading){
                    
                    Text("=  Bird's total distance")
                        .fontWeight(.heavy)
                    Text("=  Bird's average distance to gap")
                        .fontWeight(.heavy)
                    
                }
                
            }
            
            VStack{
                HStack{
                    ReproductionBirdCard()
                    ReproductionBirdCard()
                    ReproductionBirdCard()
                    ReproductionBirdCard()
                }
                HStack{
                    ReproductionBirdCard()
                    ReproductionBirdCard()
                    ReproductionBirdCard()
                    ReproductionBirdCard()
                }
                HStack{
                    ReproductionBirdCard()
                    ReproductionBirdCard()
                    ReproductionBirdCard()
                    ReproductionBirdCard()
                }
                
            }
            Text("Breed and go to the next round")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding(10)
                .background(.green)
                .mask(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 3)
                
        }.frame(width: 900,height: 700)
        
        
    }
}

struct ReproductionView_Previews: PreviewProvider {
    static var previews: some View {
        ReproductionView()
    }
}
