//
//  PageController.swift
//  WWDC
//
//  Created by 蔡俊志 on 2023/11/21.
//
import SwiftUI

enum Page: String, CaseIterable {
    case introduction_page = "1.What's this app for?"
    case flappybird_page = "2.FlappyBrid"
    case neural_network_page = "3.Neural Networks"
    case ga_page = "4.Genetic Algorithms"
    case experiment_page = "5.🔬Experiment!"
    
}

extension Page {
    func PageIconFile() -> String {
        switch self {
        case .introduction_page:
            return "questionmark"
        case .flappybird_page:
            return "bird.fill"
        case .neural_network_page:
            return "brain"
        case .ga_page:
            return "atom"
        case .experiment_page:
            return "hammer.fill"
        }
    }
}

extension Page {
    func pageTitle() -> String {
        switch self {
        case .introduction_page:
            return "APP Introduction"
        case .flappybird_page:
            return "How to play FlappyBird"
        case .neural_network_page:
            return "Learn about Neural Network"
        case .ga_page:
            return "Learn about Genetic Algorithms"
        case .experiment_page:
            return "Experiment"
        }
    }
}

//  page flip control
extension Page {
    
    func next() -> Page? {
        guard let currentIndex = Page.allCases.firstIndex(of: self) else { return nil }
        let nextIndex = currentIndex + 1
        if nextIndex < Page.allCases.count {
            return Page.allCases[nextIndex]
        } else {
            return nil
        }
    }
    
    func previous() -> Page? {
        guard let currentIndex = Page.allCases.firstIndex(of: self) else { return nil }
        let previousIndex = currentIndex - 1
        if previousIndex >= 0 {
            return Page.allCases[previousIndex]
        } else {
            return nil
        }
    }
    
    func isFirstPage() -> Bool {
            guard let currentIndex = Page.allCases.firstIndex(of: self) else { return false }
            return currentIndex == 0
        }

        func isLastPage() -> Bool {
            guard let currentIndex = Page.allCases.firstIndex(of: self) else { return false }
            return currentIndex == Page.allCases.count - 1
        }
}

class PageController: ObservableObject {
    @Published var currentPage: Page? = .introduction_page
    @Published var window_width: CGFloat = 0
    @Published var window_height: CGFloat = 0
}
