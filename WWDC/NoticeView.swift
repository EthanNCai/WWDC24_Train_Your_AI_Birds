//
//  NoticeView.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/9.
//

import SwiftUI

struct NoticeView: View {
    @ObservedObject var content_ctrl :PageContentController
    var body: some View {
        HStack{
            VStack{
                VStack{
                    
                    
                    Text("🎉Wow! looks like your bird have already learned to fly a long distance.")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding(4)
                    Text("You can press \"Adjust training settings\" in the upper left corner to go back to the setting page. and adjust the settings To see what happend when increase the difficulty by decreasing the gap between the columns or increasing the speed of the columns. Or, conversely, you can also increase the bird's brain capacity, adjust the number of birds, etc. to see what happens. ")
                }
                .padding()
                .padding()
                
                Button(action: {
                    withAnimation(){
                        self.content_ctrl.is_show_notice = false
                    }}, label: {Text("OK")})
                }
            
                
                .padding()
                .background(.ultraThickMaterial)
                .mask(RoundedRectangle(cornerRadius: 10))
                .padding()
                .padding()
                
                
        }
        
        
    }
        
}


