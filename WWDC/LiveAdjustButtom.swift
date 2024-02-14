//
//  LiveAdjustButtom.swift
//  Train your own bird AI!
//
//  Created by 蔡俊志 on 2024/2/14.
//

import SwiftUI

struct LiveAdjustButtom: View {
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "minus.circle.fill")
                    .font(.title2)
                    Spacer()
                    Text("Column Speed")
                    Spacer()
                    Button(action: {}){
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }.buttonStyle(.plain)
                    
                        
                }
                
                
                HStack {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                    Spacer()
                    Text("Column Gap Size")
                    Spacer()
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                    
                }
                
            }
            .padding()
        }.frame(width: 200,height: 60)
        
    }
}

struct LiveAdjustButtom_Previews: PreviewProvider {
    static var previews: some View {
        LiveAdjustButtom()
    }
}
