//
//  Location.swift
//  SpeedNFT
//
//  Created by Dakota Shapiro & Affan Moyeed on 4/8/22.
//

import Foundation
import CoreLocation
import Combine
import MapKit
import SwiftUI
import AVFoundation


struct log: Identifiable{
    var id: UUID
    var speed: Double
    
    
    init(id: UUID = UUID(), speed:Double){
        self.id = id
        self.speed = speed
    }
}

struct point: Identifiable{
    var id: UUID
    var lat: Double
    var lon: Double
    
    init(id: UUID = UUID(), lat: Double, lon: Double){
        self.id = id
        self.lat = lat
        self.lon = lon
    }
    
    var coordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
    }
}


class LocationManager: NSObject,CLLocationManagerDelegate, ObservableObject {
//code here
    @Published var region = MKCoordinateRegion()
    @Published var speed = ""
    @Published var speedI = 0.0
    @Published var speedTheme = SpeedTheme()
    @Published var start:Bool = true
    @Published var word = "Start"
    @Published var sysIm = "play"
    @Published var tracking = " "
    @Published var logs: [log] = []
    
    @Published var points: [point] = []
    var options = ["0", "1", "2", "3", "4"]
    

    var audioPlayer: AVAudioPlayer?
    
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func toggleState(){
        self.start = !self.start
        
        if(self.start){
            self.word = "Start"
            self.tracking = " "
            self.sysIm = "play"
        }else{
            self.word = "Stop"
            self.tracking = "Tracking..."
            self.sysIm = "stop"
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        /*
        locations.last.map {
            manager.stopUpdatingLocation()
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
            
            dump($0.speed)
        }
         */
        
        let location = locations[0]
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
        speedI = location.speed
        if(location.speed <= -1){
            speedI = location.speed+1
        }
        
        speed = "\(String(format: "%.2f", speedI)) mph"
        
        
        let path = Bundle.main.path(forResource: options[Int.random(in: 0...options.count-1)], ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        
        if(speedI > 30){
            if(!start){
                logs.append(log(speed:speedI))
                points.append(point(lat:location.coordinate.latitude, lon:location.coordinate.longitude))
                
                do{
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.play()
                }catch{
                    
                }
            }
            speedTheme.changeTheme(val: 2)
        }
        else if(speedI <= 30 && speedI >= 27){
            speedTheme.changeTheme(val: 1)
        }
        else{
            speedTheme.changeTheme(val: 0)
        }
    }
    
}
