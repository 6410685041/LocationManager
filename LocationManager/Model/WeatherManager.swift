//
//  WeatherManager.swift
//  LocationManager
//
//  Created by นางสาวชลิศา ธรรมราช on 23/2/2567 BE.
//

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) async throws -> ResponseBody {
        guard var url = URL(string: "http://pro.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude),uk&APPID=8018ddb02c3a2d17b83a89b6830b9d3a"
        ) else {
            fatalError("Missing URL")
        }
        // guard is similar to if else - if there is error, it won't do the thing and do another one instead
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
        let decodeData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodeData
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
