//
//  Round.swift
//  Train your own bird AI!
//
//  Created by 蔡俊志 on 2024/2/16.
//

import Foundation

struct Round: Identifiable{
    var id = UUID()
    var round: Int
    var best_distance_score: Int
    var score_trend: Int
    init(avg_distance_score: Int, score_trend: Int, round:Int) {
        self.best_distance_score = avg_distance_score
        self.score_trend = score_trend
        self.round = round
    }
}
