//
//  detailedVC.swift
//  TWeather
//
//  Created by Vladislav Tuleiko on 18.01.22.
//

import UIKit

//MARK: - Class
class DetailedVievContrroller: UIViewController{
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var humidityTLabbel: UILabel!
    
    @IBOutlet weak var minTempTLabbel: UILabel!
    
    @IBOutlet weak var maxTempTLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var compassGegLabel: UILabel!
    
    @IBOutlet weak var sunSetLabel: UILabel!
    
    @IBOutlet weak var sunRiseLabel: UILabel!
    
   
//MARK: - VDL
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInterface(weatherData: dataGlobal)
        setCityLabel()
        
        
     }
    
    func setCityLabel() {
        cityLabel.numberOfLines = 1
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.minimumScaleFactor = 0.5
    }
    
    
}





//MARK: - UPD Interface ext
extension DetailedVievContrroller{
    
    func updateInterface(weatherData: WeatherData){
        DispatchQueue.main.async{
            self.cityLabel.text = weatherData.city.name
            self.tempLabel.text = "| " + Int(round(weatherData.list.first!.main.temp - 273)).description + "°"
            self.windSpeedLabel.text = weatherData.list.first!.wind.speed.description + " m/s"
            self.humidityTLabbel.text = weatherData.list.first!.main.humidity.description
            self.minTempTLabbel.text = Int(round(weatherData.list.first!.main.temp_min - 273)).description
            self.maxTempTLabel.text = Int(round(weatherData.list.first!.main.temp_max - 273)).description
            self.pressureLabel.text = weatherData.list.first!.main.pressure.description
            self.compassGegLabel.text = weatherData.list.first!.wind.deg.description
        
        }
    }
}


    

