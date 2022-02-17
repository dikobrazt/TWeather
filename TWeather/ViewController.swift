//
//  ViewController.swift
//  TWeather
//
//  Created by Vladislav Tuleiko on 14.01.22.
//

import UIKit
import CoreLocation

//GITHUB

//MARK: - Global var

var dataGlobal = WeatherData()//не нравится мне это

//MARK: - Class
class ViewController: UIViewController {
    
    
    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var conditionIW: UIImageView!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBAction func reloladButton(_ sender: Any) {
        startLM()
        // это говно тоже не работает
    }
    
        //MARK: - Making amazing views
    //может этих чуваков через дженерики сделать и что таоке дженерики
    @IBAction func forecastButton(_ sender: Any) {
        
        if let forecastCardView = forecastVC.sheetPresentationController{
            forecastCardView.detents = [.large()]
            forecastCardView.prefersGrabberVisible = true
            forecastCardView.preferredCornerRadius = 25
            //разобраться со всем свойствами
        }
        present(forecastVC, animated: true, completion: nil)
    }
    
    @IBAction func datailedInformation(_ sender: Any) {
        
        if let detailedCardView = detailedVC.sheetPresentationController{
            detailedCardView.detents = [.medium(), .large()]
            detailedCardView.prefersGrabberVisible = true
            detailedCardView.preferredCornerRadius = 25
            }
        present(detailedVC, animated: true)
        
    }
    lazy var detailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VC")
    lazy var forecastVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VC2")
    
    
    let LM = CLLocationManager()
    var net = Networking()
   
    
// MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        net.delegateForData = self
        net.delegateForAlert = self
        startLM()
    }
    
    
// MARK: -LocationManager
    func startLM() {
        LM.requestWhenInUseAuthorization() //запрос на использование локации
        if CLLocationManager.locationServicesEnabled(){
            LM.delegate = self
            LM.desiredAccuracy = kCLLocationAccuracyKilometer
            LM.distanceFilter = 1000
            LM.showsBackgroundLocationIndicator = true
            LM.pausesLocationUpdatesAutomatically = true // прекращение слежения автоматически
            LM.startUpdatingLocation() //запуск поиска местоположения
            
        }else{
            setAlertGeolocation()
            print("Turn on your losation services")
        }
    }
}


//MARK: - LM Delegate ext
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last{
             net.networking(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
                //print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        }else{
            print("Loc")
        }
    }
}


//MARK: - UPD Interface ext
extension ViewController: NetworkingDelegate{
    func updateInterface(_: Networking, with weatherData: WeatherData) {
    
        DispatchQueue.main.async {
            self.countryNameLabel.text = weatherData.city.country
            self.cityNameLabel.text = weatherData.city.name
            self.descriptionLabel.text = weatherData.list.first!.weather.last?.description
            self.tempLabel.text = Int(round(weatherData.list.first!.main.temp - 273)).description + "°C"
        
            switch weatherData.list.first!.weather.last!.id {
            case 200...232:
                self.conditionIW.image = UIImage(systemName: "tropicalstorm")
            case 300...321:
                self.conditionIW.image = UIImage(systemName: "cloud.drizzle")
            case 500...531:
                self.conditionIW.image = UIImage(systemName: "cloud.rain")
            case 600...622:
                self.conditionIW.image = UIImage(systemName: "snow")
            case 701...781:
                self.conditionIW.image = UIImage(systemName: "cloud.fog")
            case 800:
                self.conditionIW.image = UIImage(systemName: "sun.min")
            case 801...804:
                self.conditionIW.image = UIImage(systemName: "cloud")
            default:
                self.conditionIW.image = UIImage(systemName: "questionmark")
            }
        }
    }
}


    //MARK: - Alert Geolocation ext
extension ViewController{
    
    func setAlertGeolocation() {
        
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "Не подмажешь - не поедешь", message: "Включи геолокацию, чел.", preferredStyle: UIAlertController.Style.alert)
            alertVC.addAction(UIAlertAction(title: "Нет", style: UIAlertAction.Style.destructive, handler: nil))
            alertVC.addAction(UIAlertAction(title: "Настройки", style:
            UIAlertAction.Style.cancel, handler: { action in
                
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }))
            
            self.present(alertVC, animated: true, completion: nil)
        }
   }
}


//MARK: - Alert delegate ext
extension ViewController: NetworkingDelegateForAlert{
    func setUpAlert(errorDescription: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "Опять проблемки", message: errorDescription, preferredStyle: UIAlertController.Style.alert)
            alertVC.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.destructive, handler: nil))
            alertVC.addAction(UIAlertAction(title: "Настройки", style:
            UIAlertAction.Style.cancel, handler: { action in
                
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }))
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    
}



