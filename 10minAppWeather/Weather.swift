//
//  Weather.swift
//  10minAppWeather
//
//  Created by Dmitry on 13.06.25.
//

import Foundation

struct Weather: Codable {
    let main: Main
    
}

struct Main: Codable {
    let temp: Double
}
