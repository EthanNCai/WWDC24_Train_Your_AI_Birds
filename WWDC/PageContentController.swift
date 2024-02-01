//
//  PageContentController.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/1/29.
//

import Foundation


class PageContentController: ObservableObject {
    
    
    @Published var isBegin:Bool = false
    @Published var isTapBegin:Bool = false
    @Published var isReset:Bool = false
    
    @Published var size:CGSize = .zero
    @Published var score: Int = 0
    @Published var bannerContent: String = "~ Tap to begin ~"
    @Published var distance_score:Float = 0.123
    @Published var velocity:Float = 1.23
    @Published var current_focus:Int = 1
    @Published var distance_u:Float = 0.123
    @Published var distance_d:Float = 0.123
    
    
    let count_down: Float = 2.0
    
    func reset() {
        isReset = false
        isBegin = false
        isTapBegin = false
        score = 0
        bannerContent = "~ Tap to begin ~"
    }
    
    func startCountingDown() {
        
        let timeToGo = TimeInterval(self.count_down)
        
        self.isTapBegin = true
        DispatchQueue.main.async {
            self.bannerContent = "Counting down 3..."
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
}
