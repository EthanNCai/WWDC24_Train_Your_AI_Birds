//
//  WWDCApp.swift
//  WWDC
//
//  Created by 蔡俊志 on 2023/11/20.
//

import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            StageView()
                
        }
        .commands {
            SidebarCommands() // 添加一些默认的侧边栏命令，例如“显示/隐藏侧边栏”
        }
    }
}
