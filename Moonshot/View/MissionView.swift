//
//  MissionView.swift
//  Moonshot
//
//  Created by Gavin Butler on 29-07-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    let showCommander: Bool
    let commander: String
    
    let cornerRadius: CGFloat = 5
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    if self.showCommander {
                        HStack {
                            Text("Commander: ")
                                .font(.headline)
                            Text("\(self.commander)")
                            .padding()
                        }
                    }
                    HStack {
                        Text("Launched: ")
                            .font(.headline)
                        Text("\(self.mission.formattedLaunchDate)")
                            .padding()
                    }
                        
                    Text(self.mission.description)
                    .padding()
                    
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: self.cornerRadius))
                                    .overlay(RoundedRectangle(cornerRadius: self.cornerRadius).stroke(Color.primary, lineWidth: 1))
                            
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        var showCommander = false
        var commander = ""
        
        for member in mission.crew {
            if let match = astronauts.first(where: {
                $0.id == member.name
            }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
                if member.isCommander {
                    showCommander = true
                    commander = match.name
                }
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
        self.showCommander = showCommander
        self.commander = commander
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
    }
}
