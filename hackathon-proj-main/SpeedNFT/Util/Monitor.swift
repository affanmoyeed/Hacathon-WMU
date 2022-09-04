//
//  Monitor.swift
//  SpeedNFT
//
//  Created by Dakota Shapiro on 4/9/22.
//

import Foundation
import SwiftUI

class Monitor: ObservableObject{
    
    @Published var start:Bool = true
    @Published var word = "Start"
    @Published var tracking = ""

    
    func toggleState(){
        self.start = !self.start
        
        if(self.start){
            self.word = "Start"
            self.tracking = ""
        }else{
            self.word = "Stop"
            self.tracking = "Tracking..."
        }
        
    }
    
    func checkSpeed(_ speed: Double){
        
    }
    
}
