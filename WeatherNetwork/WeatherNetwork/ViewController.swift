//
//  ViewController.swift
//  WeatherNetwork
//
//  Created by 양수빈 on 2022/11/08.
//

import UIKit

import Alamofire
import SnapKit

class ViewController: UIViewController {
    
    private let currentTempLabel = UILabel()
    private let minTempLabel = UILabel()
    private let maxTempLabel = UILabel()
    private var currentWeatherData: CurrentWeatherEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
//        getCurrentWeather()
        getCurrentWeatherWithAlamofire()
    }

    private func setUI() {
        currentTempLabel.font = .boldSystemFont(ofSize: 24)
    }

    private func setLayout() {
        [currentTempLabel, minTempLabel, maxTempLabel].forEach { view.addSubview($0) }
        
        currentTempLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
        
        minTempLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.top.equalTo(currentTempLabel.snp.bottom).offset(40)
        }
        
        maxTempLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.centerY.equalTo(minTempLabel)
        }
    }
    
    private func setData(current: Double, max: Double, min: Double) {
        currentTempLabel.text = "\(String(current))°C"
        maxTempLabel.text = "\(String(max))°C"
        minTempLabel.text = "\(String(min))°C"
    }
}

// MARK: - Network

extension ViewController {
    func getCurrentWeather() {
        CurrentWeatherService.shared.fetchCurrentWeatherData { response in
            switch response {
            case .success(let data):
                print("✅ getCurrentWeather - ",data)
                self.currentWeatherData = data as? CurrentWeatherEntity
                if let data = data as? CurrentWeatherEntity {
                    // ui 변경은 main queue에서 (서버 통신이 global queue로 넘어가서 진행됨)
                    DispatchQueue.main.async {
                        let tempData = data.main
                        self.setData(current: tempData.temp, max: tempData.tempMax, min: tempData.tempMin)
                    }
                }
            case .failure(let err):
                print("❌ getCurrentWeather - ",err)
            }
        }
    }
    
    func getCurrentWeatherWithAlamofire() {
        CurrentWeatherAlamofireService.shared.fetchCurrentWeatherData { response in
            switch response {
            case .success(let data):
                print("✅ getCurrentWeatherWithAlamofire - ", data)
                if let data = data as? CurrentWeatherEntity {
                    self.currentWeatherData = data
                    DispatchQueue.main.async {
                        let tempData = data.main
                        self.setData(current: tempData.temp, max: tempData.tempMax, min: tempData.tempMin)
                    }
                }
            case .requestErr(let err):
                print("requestErr - \(err)")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
