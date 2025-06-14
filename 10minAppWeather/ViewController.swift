//
//  ViewController.swift
//  10minAppWeather
//
//  Created by Dmitry on 13.06.25.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        
        return label
    }()
    
    
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "London"
        cityLabel.font = .boldSystemFont(ofSize: 24)
        cityLabel.textColor = .black
        
        return cityLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        view.addSubview(tempLabel)
        view.addSubview(cityLabel)
        
        setupConstraints()
        
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        load()
        
        
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: tempLabel.topAnchor, constant: -5)
        ])
    }
    
    
    private func load() {
        
        ApiManager().load() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    if let weather {
                        DispatchQueue.main.async {
                            self?.tempLabel.text = "\(weather.main.temp)"
                        }
                    } else {
                        self?.show(error: nil)
                    }
                case .failure(let error):
                    self?.show(error: error)
                }
                
            }
            
        }
        
    }
    
    
    private func show(error: Error?) {
        let message = error == nil ? "Data is empty" : error?.localizedDescription
        let controller = UIAlertController(title: "Error",
                                           message: message,
                                           preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK", style: .default))
        present(controller, animated: true)
        
        
    }
    
}
