//
//  Weather.swift
//  WeatherApp
//
//  Created by naoki-mrmt on 2020/11/30.
//  Copyright © 2020 naoki-mrmt. All rights reserved.
//

import Foundation

struct OneCallWeather: Decodable {
    
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    
    let current: Current
    
    struct Current: Decodable {
        
        let dt: Int
        let sunrise: Int
        let sunset: Int
        let temp: Double
        let feels_like: Double
        let pressure: Int
        let humidity: Int
        let dew_point: Double
        let clouds: Int
        let visibility: Int
        let wind_speed: Double
        let wind_deg: Int
        
        let weather: [Weather]
        
        struct Weather: Decodable {
            
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
    }
    
    let daily: [Daily]
    
    struct Daily: Decodable {
        
        let temp: Temp
        
        struct Temp: Decodable {
            
            let min: Double
            let max: Double
            
        }
    }
}
