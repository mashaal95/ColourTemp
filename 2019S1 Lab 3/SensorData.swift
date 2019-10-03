//
//  SensorData.swift
//  2019S1 Lab 3
//
//  Created by Mashaal on 30/9/19.
//  Copyright © 2019 Michael Wybrow. All rights reserved.
//

import Foundation

class SensorData: Equatable {
    static func == (lhs: SensorData, rhs: SensorData) -> Bool {
        return true
    }
    

    var id: String = " "
    var red: Int = 255
    var blue: Int = 255
    var green: Int = 255
    var temp: Double = 22
    var timeStamp: String = " "
    var lux: Double = 22
    
}
