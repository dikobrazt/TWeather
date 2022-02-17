//
//  Networking.swift
//  TWeather
//
//  Created by Vladislav Tuleiko on 19.01.22.
//

import UIKit

// MARK: - Protocols Delegate
protocol NetworkingDelegate: class {     //class значит что только классами будет использоваться этот протокол
    func updateInterface(_: Networking, with weatherData: WeatherData )
}

protocol NetworkingDelegateForAlert: class {
    func setUpAlert(errorDescription: String)
}

//MARK: - Class
class Networking {
    
    weak var delegateForData: NetworkingDelegate?// избавление от сильных ссылок
    weak var delegateForAlert: NetworkingDelegateForAlert?
    //let apiKey: String = "2b90398979bb98df8b2f7e507c32eb0d"
    let apiKey: String = "fb4c711f11bed78b124e2b22d74d9792"
    var weatherData = WeatherData()
    
        func networking(latitude: Double, longitude: Double){
            
            let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude.description)&lon=\(longitude.description)&lang=ru&appid=\(apiKey)")
            
                
            if url != nil{
                let session = URLSession.shared
                let task = session.dataTask(with: url!) { data, response, error in
                    if error == nil{
                        do{
                            self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                            print(self.weatherData)
//MARK: - Data complete
                            self.delegateForData?.updateInterface(self, with: self.weatherData)
                            dataGlobal = self.weatherData
                        }catch{
                            print("Catch error \(error.localizedDescription)")
                            self.delegateForAlert?.setUpAlert(errorDescription: error.localizedDescription)
                        }
                    }else{
                        print("Error DataTask \(String(describing: error?.localizedDescription))")
                        self.delegateForAlert?.setUpAlert(errorDescription: error!.localizedDescription)
                        return
                    }
                }
                task.resume()
            }else{
                print("Incorrect URL")
            }
     }
}



