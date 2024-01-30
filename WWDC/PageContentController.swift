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
}
