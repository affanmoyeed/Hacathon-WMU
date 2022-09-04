//
//  LogView.swift
//  SpeedNFT
//
//  Created by Dakota Shapiro on 4/9/22.
//

import SwiftUI
import MapKit

struct LogView: View {
    @State var logs: [log]
    
    var body: some View {
        ScrollView{
            ForEach(logs){log in
                VStack(alignment: .leading) {
                    Text("\(String(format: "%.2f",log.speed)) mph")
                        .frame(width: 300, height:100)
                        .font(.system(size: 35))
                        
                }
                .background(Color(0x442416))
                .foregroundColor(Color(0xFCC30F))
            }.navigationTitle("Speeding Log")
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView(logs: [log(speed: 0.0)])
    }
}
