//
//  LocationManager.swift
//  LocationDemo
//
//  Created by Siwon Kim on 12/29/23.
//

import Foundation
import CoreLocation

@MainActor
final class LocationManager: NSObject, ObservableObject {
    let locationManager = CLLocationManager()
//    var authStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.checkIsEnabledUserDeviceLocation()
    }
    
    func checkIsEnabledUserDeviceLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            // 시스템 설정으로 유도하는 커스텀 얼럿
            print("설정에서 위치허용해주세요.")
            return
        }
//        authStatus = locationManager.authorizationStatus
        
        checkIsUserEnabledAppAuthorization(locationManager.authorizationStatus)
    }
    
    func checkIsUserEnabledAppAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // 사용자가 권한설정 하지않은 상태 -> 앱의 위치정보접근 권한 설정 부탁
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // 사용자가 권한 거부한 상태 -> 시스템 설정으로 유도하여, 앱의 위치정보접근 권한 설정 부탁
            print("앱의 위치정보접근 권한 설정 부탁해야함")
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            // 사용자가 권한 허용한 상태
            locationManager.startUpdatingLocation() // 위치 지속적으로 가져오기 -> 나중에 stopUpdatingLocation()으로 불필요한 위치 업데이트 멈추기
//            locationManager.requestLocation() // 위치 한번만 가져오기
        default:
            break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    // 사용자의 위치를 성공적으로 가져왔을 때 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 위치 정보를 배열로 입력받는데, 마지막 index값이 가장 정확하다고 한다.
        if let coordinate = locations.last?.coordinate {
            // ⭐️ 사용자 위치 정보 사용
            print(coordinate)
        }
        
        // startUpdatingLocation()을 사용하여 사용자 위치를 가져왔다면
        // 불필요한 업데이트를 방지하기 위해 stopUpdatingLocation을 호출
        locationManager.stopUpdatingLocation()
    }
}
