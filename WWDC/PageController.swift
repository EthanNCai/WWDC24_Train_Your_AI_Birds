//
//  PageController.swift
//  WWDC
//
//  Created by 蔡俊志 on 2023/11/21.
//
import SwiftUI

enum Page: String, CaseIterable {
    case intro_1_view = "Home"
    case profile = "Profile"
    case new = "this is new"
    case settings = "Settings"
    case help = "Help"
}

extension Page {
    func PageIconFile() -> String {
        switch self {
        case .intro_1_view:
            return "house"
        case .profile:
            return "person"
        case .settings:
            return "gear"
        case .help:
            return "questionmark.circle"
        case .new:
            return "square.and.arrow.up.fill"
        }
    }
}

extension Page {
    func pageTitle() -> String {
        switch self {
        case .intro_1_view:
            return "page1"
        case .profile:
            return "page2"
        case .settings:
            return "page3"
        case .help:
            return "page4"
        case .new:
            return "page5"
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
    @Published var currentPage: Page? = .intro_1_view
}
