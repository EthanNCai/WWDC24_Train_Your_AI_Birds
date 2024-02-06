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
            SidebarCommands() 
        }
    }
}
