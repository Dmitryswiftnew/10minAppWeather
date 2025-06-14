//
//  API.swift
//  10minAppWeather
//
//  Created by Dmitry on 13.06.25.
//

import Foundation


final class ApiManager {
    private let apiKey = "a0effe66d2d34c198eacd1c5f19aa736"
    
    func load(city: String = "Minsk", completion: @escaping (Result<Weather?, Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)") else { return }
        let session = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            // проверяем HTTP статус-код
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                // Пробуем получить текст ошибки из JSON
                if let data = data,
                   let errorResponse = try? JSONDecoder().decode(OpenWeatherError.self, from: data) {
                    completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])))
                } else {
                    completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Unknown server error"])))
                }
                return
            }
            
            if let data = data {
                // пробуем декодировать Weather
                if let weather = try? JSONDecoder().decode(Weather.self, from: data) {
                    completion(.success(weather))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                }
                
            }
            
            
            
            
        }
        
        session.resume()
    }
}


// модель ошибки
struct OpenWeatherError: Decodable  {
    let cod: String
    let message: String
}
