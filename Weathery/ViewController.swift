//
//  ViewController.swift
//  Weathery
//
//  Created by Gerasim Israyelyan on 1/21/19.
//  Copyright © 2019 Gerasim Israyelyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var places: [Region] = [Region(name: "Yerevan", latitude: 40.1535005, longitude: 44.4185271),
                            Region(name: "Aragatsotn", latitude: 40.481378, longitude: 43.8135773),
                            Region(name: "Ararat", latitude: 39.9520157, longitude: 44.435802),
                            Region(name: "Armavir", latitude: 40.1590152, longitude: 44.0075393),
                            Region(name: "Gegharkunik", latitude: 40.3010835, longitude: 44.8339823),
                            Region(name: "Kotayk", latitude: 40.4087447, longitude: 44.4405217),
                            Region(name: "Lori", latitude: 40.982811, longitude: 43.9295877),
                            Region(name: "Shirak", latitude: 40.8103599, longitude: 43.5465633),
                            Region(name: "Syunik", latitude: 39.342143, longitude: 45.6090432),
                            Region(name: "Tavush", latitude: 40.9755753, longitude: 44.9006949),
                            Region(name: "Vayots Dzor", latitude: 39.7582171, longitude: 45.1660169)]

    @IBOutlet weak var placePicker: UIPickerView!
    @IBOutlet weak var regionName: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        placePicker.delegate = self
        placePicker.dataSource = self
        
        let forecastService = ForecastService(APIKey: [API-KEY])
        forecastService.getForecast(latitude: 40.1535005, longitudude: 44.4185271) { (currentWeather) in
            DispatchQueue.main.sync {
                self.regionName.text = self.places[0].name
                if let data = currentWeather?.temperature! {
                    self.temperatureLabel.text = "\(String(data)) ℃"
                }
            }
            
        }
        
    }


}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return places.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel: UILabel? = UILabel()

        pickerLabel?.font = UIFont(name: pickerLabel!.font.fontName, size: 30)
        pickerLabel?.textAlignment = .center
        pickerLabel?.text = places[row].name
        pickerLabel?.textColor = UIColor.white
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(integerLiteral: 40)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        regionName.text = places[row].name
        let forecastService = ForecastService(APIKey: "34419891dfa33243b41e4e137395649f")
        forecastService.getForecast(latitude: places[row].latitude , longitudude: places[row].longitude) { (currentWeather) in
            
            DispatchQueue.main.async {

                    if let data = currentWeather?.temperature! {
                        self.temperatureLabel.text = "\(String(data)) ℃"
                    }                
            }
            
        }
    }
    
    
    
}

