//
//  DataModel.swift
//  TWeather
//
//  Created by Vladislav Tuleiko on 16.01.22.
//

import Foundation

struct Weather: Codable{
    var id: Int
    var main: String
    var description: String
}
// добавить два параматра рассвет и закат время
struct Main: Codable{
    var temp: Double = 0.0
    var temp_min: Double = 0.0
    var temp_max: Double = 0.0
    var pressure: Int = 0
    var humidity: Int = 0
}

struct Wind: Codable{
    var speed: Double = 0.0
    var deg: Int = 0
    var gust: Double = 0.0
}

struct City: Codable{
    var name: String = " "
    var country: String = " "
}

//MARK: - Main struct
struct List: Codable {
    var weather:[Weather] = []
    var main: Main = Main()
    var wind: Wind = Wind()
    var dt_txt: String = " "
    
}

struct WeatherData: Codable{
    var list: [List] = []
    var city: City = City()
}




//
//struct Weather: Codable{
//    var id: Int
//    var main: String
//    var description: String
//}
//// добавить два параматра рассвет и закат время
//struct Main: Codable{
//    var temp: Double = 0.0
//    var temp_min: Double = 0.0
//    var temp_max: Double = 0.0
//    var pressure: Int = 0
//    var humidity: Int = 0
//}
//
//struct Wind: Codable{
//    var speed: Double = 0.0
//    var deg: Int = 0
//    var gust: Double = 0.0
//}
//
////MARK: - Main struct
//struct List: Codable {
//    var weather:[Weather] = []
//    var main: Main = Main()
//    var wind: Wind = Wind()
//    var name: String = " "
//}
//
//struct WeatherData: Codable{
//    let list: [List]
//}


