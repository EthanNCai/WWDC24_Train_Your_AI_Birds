//
//  SoundPlayer.swift
//  Train your own bird AI!
//
//  Created by 蔡俊志 on 2024/2/19.
//

import AudioToolbox
func playsound(){
    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_UserPreferredAlert))
}
