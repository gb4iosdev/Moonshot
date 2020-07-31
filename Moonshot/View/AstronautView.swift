//
//  AstronautView.swift
//  Moonshot
//
//  Created by Gavin Butler on 30-07-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions:")
                        .padding()
                        .font(.headline)
                    ForEach(self.missions) { mission in
                        HStack {
                            Image(mission.image)
                            .resizable()
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                            Text(mission.displayName)
                            
                            Spacer()
                        }
                    .padding()
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        var matches = [Mission]()
        
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        for mission in missions {
            for crewRole in mission.crew {
                if crewRole.name ==  self.astronaut.id {
                    matches.append(mission)
                    break
                }
            }
        }
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let index = astronauts.firstIndex { $0.id == "young" } ?? 1
    static var previews: some View {
        return AstronautView(astronaut: astronauts[index])
    }
}
