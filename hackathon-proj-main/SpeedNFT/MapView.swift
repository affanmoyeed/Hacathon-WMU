//
//  MapView.swift
//  SpeedNFT
//
//  Created by Dakota Shapiro on 4/8/22.
//

import SwiftUI
import MapKit
import CoreLocationUI
import Combine



struct MapView: View {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    @StateObject var manager = LocationManager()
    
    @State var polyline = MKPolyline()
    
    
    @State var tracking:MapUserTrackingMode = .follow
    

    var body: some View {
        ZStack{
            
            Map(
               coordinateRegion: $manager.region,
               interactionModes: MapInteractionModes.all,
               showsUserLocation: true,
               userTrackingMode: $tracking,
               annotationItems: manager.points,
               annotationContent: {point in
                   MapPin(coordinate: point.coordinate, tint: .red)
               }
            )
            .ignoresSafeArea()
            
            HStack(){
                Label("**\(manager.speed)**",systemImage: "bolt")
                    .padding()
                    .foregroundColor(manager.speedTheme.fore)
                    
            }
            .background(manager.speedTheme.back)
            .clipShape(Capsule())
            .position(x: screenSize.width/2, y: -30)
            
            
            
            VStack{
                Text("\(manager.tracking)")
                
                HStack{
                    Button(action: manager.toggleState){
                        Label("\(manager.word)", systemImage: manager.sysIm)
                            .padding()
                            .foregroundColor(Color(0xFCC30F))
                            .frame(width: 150)
                            .background(Color(0x442416))
                            .clipShape(Capsule())
                    }.padding()
                    Spacer()
                    NavigationLink(destination: LogView(logs:manager.logs)){
                        Label("Logs", systemImage: "book.fill")
                            .padding()
                            .foregroundColor(Color(0xFCC30F))
                            .frame(width: 150)
                            .background(Color(0x442416))
                            .clipShape(Capsule())
                        
                    }.padding()
                }
                
               
                    
            }
            .position(x: screenSize.width/2, y: screenSize.height/1.3)
            
                
                
        }
        
        
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
