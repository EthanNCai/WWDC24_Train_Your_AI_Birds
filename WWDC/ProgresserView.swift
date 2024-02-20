//
//  ProgresserView.swift
//  Train your own bird AI!
//
//  Created by 蔡俊志 on 2024/2/18.
//

import SwiftUI

struct ProgresserView: View {
    @ObservedObject var content_ctrl: PageContentController
    var body: some View {
        ZStack{
            
            VStack(alignment: .leading){
            
                HStack{
                    if content_ctrl.current_milestn == 0{
                        Text("_Dumb Bird_")
                    }else if content_ctrl.current_milestn == 1{
                        Text("_Newbee Bird_")
                    }else if content_ctrl.current_milestn == 2{
                        Text("_Competent Bird_")
                    }else{
                        Text("_Master Bird_")
                    }
                    Image(systemName: content_ctrl.current_milestn <= 0 ? "star" : "star.fill")
                        .foregroundColor(.orange)
                    Image(systemName: content_ctrl.current_milestn <= 1 ? "star" : "star.fill")
                        .foregroundColor(.orange)
                    Image(systemName: content_ctrl.current_milestn <= 2 ? "star" : "star.fill")
                        .foregroundColor(.orange)
                }
                .font(.title)
                if self.content_ctrl.current_milestn >= 3 {
                    Text("congratulations! you took it to a whole new level")
                }else{
                    Text("To fly another \(self.content_ctrl.current_dist_needed) units to get the next title.")
                }
            }
        }
    }
}

