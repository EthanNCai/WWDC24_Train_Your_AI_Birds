//
//  PageController.swift
//  WWDC
//
//  Created by 蔡俊志 on 2023/11/21.
//
import SwiftUI

enum Page: String, CaseIterable {
    case home = "Home"
    case profile = "Profile"
    case settings = "Settings"
    case help = "Help"
    
    // 定义下一个页面
    func next() -> Page? {
        guard let currentIndex = Page.allCases.firstIndex(of: self) else { return nil }
        let nextIndex = currentIndex + 1
        if nextIndex < Page.allCases.count {
            return Page.allCases[nextIndex]
        } else {
            return nil
        }
    }
    
    // 定义前一个页面
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

        // 判断当前页面是否是最后一个页面
        func isLastPage() -> Bool {
            guard let currentIndex = Page.allCases.firstIndex(of: self) else { return false }
            return currentIndex == Page.allCases.count - 1
        }
}

extension Page {
    func systemImageName() -> String {
        switch self {
        case .home:
            return "house"
        case .profile:
            return "person"
        case .settings:
            return "gear"
        case .help:
            return "questionmark.circle"
        }
    }
}

class PageController: ObservableObject {
    @Published var currentPage: Page? = .home
}
