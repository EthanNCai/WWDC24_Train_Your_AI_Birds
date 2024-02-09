//
//  NoticeView.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/9.
//

import SwiftUI

struct NoticeView: View {
    var body: some View {
        HStack{
            VStack{
                VStack{
                    
                    
                    Text("🎉Wow! looks like your bird have already learned to fly a long distance.")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding(4)
                    Text(" You can press \"Back\" in the upper left corner to go back to the setting page. and adjust the settings To see what happend when increase the difficulty by decreasing the gap between the columns or increasing the speed of the columns. Or, conversely, you can also increase the bird's brain capacity, adjust the number of birds, etc. to see what happens. ")
                }
                .padding()
                .padding()
                
                Button(action: {}, label: {Text("OK")})
            }
            
                
                .padding()
                .background(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 10))
                .padding()
                .padding()
                
                
        }.frame(width: 800,height: 600)
        .background(.blue)
        
    }
        
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView()
    }
}
