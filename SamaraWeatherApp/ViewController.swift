//
//  ViewController.swift
//  SamaraWeatherApp
//
//  Created by Nikita on 20/11/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var imageView: UIImageView!
    @IBAction func getWeather() {
        activityIndicator.startAnimating()
        let url = URL(string: "https://api.darksky.net/forecast/7f7f9257c94ae6fcc422381fb2e0ab30/50.221245,53.241505?units=si")!
       
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any?] else{
                return
            }
            
            guard let currently = json["currently"] as? [String:Any] else {return}
            guard let temp = currently["temperature"] as? Double else {return}
            guard let description = currently["summary"] as? String else {return}
            
            DispatchQueue.main.async {
                self.tempLabel.text = String(temp) + "℃"
                self.descLabel.text = description
                self.activityIndicator.stopAnimating()
                if temp > 0 {
                    self.view.backgroundColor = UIColor.green
                } else {
                    self.view.backgroundColor = UIColor.systemBlue
                }
                if description == "Clear" {
                    self.imageView.image = UIImage(named: "sun")
                }
                

            }
          
        }.resume()
    }
    
}
