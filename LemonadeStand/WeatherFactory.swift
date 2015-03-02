//
//  WeatherFactory.swift
//  LemonadeStand
//
//  Created by Kyle Cabigon on 2/24/15.
//  Copyright (c) 2015 Kyle Cabigon. All rights reserved.
//

import Foundation
import UIKit

class WeatherFactory {
    
    class func randomizeWeather() -> Weather {
        
        var randomNumber = arc4random_uniform(UInt32(3))
        
        var todaysWeather: Weather
        
        switch randomNumber {
        case 0:
            todaysWeather = Weather(weather: "mild", temperature: 0, image: UIImage(named: "mild"))
        case 1:
            todaysWeather = Weather(weather: "warm", temperature: 4, image: UIImage(named: "warm"))
        case 2:
            todaysWeather = Weather(weather: "cold", temperature: (-3), image: UIImage(named: "cold"))
        default:
            todaysWeather = Weather(weather: "mild", temperature: 0, image: UIImage(named: "mild"))
        }
        return todaysWeather
    }
    
}