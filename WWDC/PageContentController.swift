//
//  PageContentController.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//

import Foundation


class PageContentController: ObservableObject {
    @Published var size:CGSize = .zero
    @Published var isBegin:Bool = false
    @Published var isTapBegin:Bool = false
    @Published var score: Int = 0
    @Published var bannerContent: String = "Tap to begin :3"
    let count_down: Float = 1.3
    
    func reset() {
        size = .zero
        isBegin = false
        isTapBegin = false
        score = 0
        bannerContent = "Tap to begin :3"
    }
    
    func startCountingDown() {
        
        let timeToGo = TimeInterval(self.count_down)
        
        self.isTapBegin = true
        DispatchQueue.main.async {
            self.bannerContent = "Counting down 3..."
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (timeToGo / 3)) {
            self.bannerContent = "Counting down 2..."
            DispatchQueue.main.asyncAfter(deadline: .now() + (timeToGo / 3)) {
                self.bannerContent = "Counting down 1..."
                DispatchQueue.main.asyncAfter(deadline: .now() + timeToGo / 3) {
                    self.isBegin = true
                }
            }
        }
        
        
        
        
    }
}
