//
//  SpeedTheme.swift
//  SpeedNFT
//
//  Created by Dakota Shapiro on 4/8/22.
//

import Foundation
import SwiftUI

class SpeedTheme: ObservableObject {
    
    @Published var fore: Color = Color(0xFCC30F)
    @Published var back: Color = Color(0x442416)
    
    func changeTheme(val: Int){
        switch(val){
        case 0:
            fore = Color(0xFCC30F)
            back = Color(0x442416)
        case 1:
            fore = .yellow
            back = .orange
        case 2:
            fore = .white
            back = .red
        default:
            break
        }
    }
    
}
