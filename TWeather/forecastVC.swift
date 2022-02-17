//
//  forecastVC.swift
//  TWeather
//
//  Created by Vladislav Tuleiko on 15.02.22.
//

import UIKit

class forecastVC: UIViewController{
    
    var cellID: String = "cellID"
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastTableView.dataSource = self
        forecastTableView.delegate = self
        forecastTableView.register(UINib(nibName: "ForecastTVCell", bundle: nil), forCellReuseIdentifier: cellID)
    }
}

extension forecastVC: UITableViewDataSource, UITableViewDelegate{
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 5
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 39
        //сделать нормально, а не это говно
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ForecastTVCell
        
        let timeTrue = timeFormater(indexPath: indexPath, dataGlobal: dataGlobal)
        let dateTrue = dateFormatter(indexPath: indexPath, globalData: dataGlobal)
        cell.dateLabel.text = dateTrue
        cell.timeLabel.text = timeTrue
        cell.tempLabel.text = Int(round(dataGlobal.list[indexPath.row].main.temp - 273)).description + "°C"
        cell.descriptionLabel.text = dataGlobal.list[indexPath.row].weather.first?.description
        
        switch dataGlobal.list[indexPath.row].weather.last!.id {
        case 200...232:
            cell.imageLabel.image = UIImage(systemName: "tropicalstorm")
        case 300...321:
           cell.imageLabel.image = UIImage(systemName: "cloud.drizzle")
        case 500...531:
            cell.imageLabel.image = UIImage(systemName: "cloud.rain")
        case 600...622:
            cell.imageLabel.image = UIImage(systemName: "snow")
        case 701...781:
            cell.imageLabel.image = UIImage(systemName: "cloud.fog")
        case 800:
            cell.imageLabel.image = UIImage(systemName: "sun.min")
        case 801...804:
            cell.imageLabel.image = UIImage(systemName: "cloud")
        default:
            cell.imageLabel.image = UIImage(systemName: "questionmark")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Хер знает как разделить по дням"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    

    
}


//MARK: - Formatter ext
extension forecastVC {
    
    func timeFormater (indexPath: IndexPath, dataGlobal: WeatherData) -> String {
        let date: String = dataGlobal.list[indexPath.row].dt_txt
        let start = date.index(date.startIndex, offsetBy: 11)
        let end = date.index(date.startIndex, offsetBy: 16)
        let range = start..<end
        return String(date[range])
    }
    
    func dateFormatter(indexPath: IndexPath, globalData: WeatherData) -> String {
        let date: String = dataGlobal.list[indexPath.row].dt_txt
        let start = date.index(date.startIndex, offsetBy: 0)
        let end = date.index(date.endIndex, offsetBy: -9)
        let range = start..<end
        return String(date[range])
    }
    
}


