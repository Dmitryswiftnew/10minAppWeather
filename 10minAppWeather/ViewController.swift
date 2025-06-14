//
//  ViewController.swift
//  10minAppWeather
//
//  Created by Dmitry on 13.06.25.
//

import UIKit

class ViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "28"
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
        view.addSubview(label)
        view.addSubview(cityLabel)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -5)
        ])
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        DispatchQueue.global().async {
            ApiManager().load() { [weak self] weather in
                guard let weather else { return }
                DispatchQueue.main.async {
                    self?.label.text = "\(weather.main.temp)"
                }
                
            }
        }
        
        
    }


}

