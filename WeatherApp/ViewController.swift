//
//  ViewController.swift
//  WeatherApp
//
//  Created by naoki-mrmt on 2020/11/30.
//  Copyright © 2020 naoki-mrmt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// 現在地を表示
    @IBOutlet weak var displayCurrentLocation: UILabel!
    /// 天気を表示
    @IBOutlet weak var displayWeather: UILabel!
    /// 天気の画像を表示
    @IBOutlet weak var displayWeatherPicture: UIImageView!
    /// 現在の気温を表示
    @IBOutlet weak var displayCurrentTemperature: UILabel!
    /// 最高気温を表示
    @IBOutlet weak var displayHighTemperature: UILabel!
    /// 最低気温を表示
    @IBOutlet weak var displayLowTemperature: UILabel!
    /// 天気の解説文を表示
    @IBOutlet weak var displayWeatherDescription: UILabel!
    /// 体感温度を表示
    @IBOutlet weak var displaySensoryTemperature: UILabel!
    /// 風速を表示
    @IBOutlet weak var displayWindSpeed: UILabel!
    
    
    let url = "https://api.openweathermap.org/data/2.5/onecall"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard var urlComponents = URLComponents(string: url) else {
            print("エラーの内容")
            return
        }
        
        
        
        
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "35.698965177103844"),
            URLQueryItem(name: "lon", value: "139.69676479999467"),
            URLQueryItem(name: "lang", value: "ja"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: "65c4c350aa9b6f8c1819169cd2675dea")
        ]
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            do {
                let data = try JSONDecoder().decode(OneCallWeather.self, from: data!)
                print(data)
                DispatchQueue.main.async {
                    self.displayCurrentLocation.text = data.timezone
                    self.displayWeather.text = String(data.current.weather[0].main)
                    self.displayCurrentTemperature.text = String(Int(floor(data.current.temp)))
                    self.displayHighTemperature.text = "最高: \(String(Int(floor(data.daily[0].temp.max))))°"
                    self.displayLowTemperature.text = "最低: \(String(Int(floor(data.daily[0].temp.min))))°"
                    self.displayWeatherDescription.text = " 今日: 現在の天気は\(String(data.current.weather[0].description))。最高気温は\(String(Int(floor(data.daily[0].temp.max))))°C。最低気温は\(String(Int(floor(data.daily[0].temp.min))))°C。"
                    self.displaySensoryTemperature.text = " \(String(Int(floor(data.current.feels_like))))°"
                    self.displayWindSpeed.text = " \(String(data.current.wind_speed)) m/s"
                    
                    
                    let imageURL = URL(string: "https://openweathermap.org/img/wn/\(String(data.current.weather[0].icon))@2x.png")
                    if let imageData = try? Data(contentsOf: imageURL!) {
                        self.displayWeatherPicture.image = UIImage(data: imageData)
                    } else {
                        print("ロゴの画像データ取得失敗")
                    }
                    
                    
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
         
    }
   

}
