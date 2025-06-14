//
//  API.swift
//  10minAppWeather
//
//  Created by Dmitry on 13.06.25.
//

import Foundation


final class ApiManager {
    private let apiKey = "a0effe66d2d34c198eacd1c5f19aa736"
    
    func load(completion: @escaping (Weather?) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(apiKey)") else { return }
        let session = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data else { return }
            
            let weather = try? JSONDecoder().decode(Weather.self, from: data)
            
            completion(weather)
        }
        
        session.resume()
    }
}
