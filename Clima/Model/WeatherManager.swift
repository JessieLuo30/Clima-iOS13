//
//  Weather.swift
//  Clima
//
//  Created by Jessie Luo on 7/11/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

//protocol WeatherManagerDelegate {
////    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
////    func didFailWithError(error: Error)
//}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=962a6c248cbed93d8db97e0f6b2d7b28"
    
//    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }

//    func fetchWeather(latitude: CLLocationDegrees, longitute: CLLocationDegrees) {
//        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
//        performRequest(with: urlString)
//    }

    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            print("1")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(safeData)
                }
            }
            task.resume()
        } else {
            print("2")
        }
    }
    
    func parseJSON(_ weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
        } catch {
            print(error)
        }
    }
    
//    func parseJSON(_ weatherData: Data) {
//            let decoder = JSONDecoder()
//            do {
//                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//                let id = decodedData.weather[0].id
//                let temp = decodedData.main.temp
//                let name = decodedData.name
//
//                let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
//                return weather
//
//            } catch {
//                delegate?.didFailWithError(error: error)
//                return nil
//            }
//        }

    
}
