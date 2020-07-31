//
//  Mission.swift
//  Moonshot
//
//  Created by Gavin Butler on 28-07-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var formattedCrew: String {
        guard crew.count > 0 else { return "" }
        var formatted: [String] = []
        for crewMember in crew {
            formatted.append(crewMember.name.capitalized)
        }
        return formatted.joined(separator: ", ")
    }
    
    struct CrewRole: Codable {
        let name: String
        let role: String
        
        var isCommander: Bool {
            return role == "Commander"
        }
    }
}
