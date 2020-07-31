//
//  ContentView.swift
//  Moonshot
//
//  Created by Gavin Butler on 27-07-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showDate = true
    private var navButtonTitle: String {
        showDate ? "Crew" : "Date"
    }
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                    .resizable()
                    .scaledToFit()  //Exactly equal to using .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                        .font(.headline)
                        Text(self.missionDetail(for: mission))
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:Button(action: {
                self.showDate.toggle()
            }) {
                HStack {
                    Text(navButtonTitle)
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 60, height: 30)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            })
        }
    }
    
    func missionDetail(for mission: Mission) -> String {
        showDate ? mission.formattedLaunchDate : mission.formattedCrew
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//JSON Decoding (nested types):
/*struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

struct ContentView: View {
    
    let input = """
    {
        "name": "Taylor Swift",
        "address": {
            "street": "555 Taylor Swift Ave",
            "city" : "Nashville"
        }
    }
    """
    
    var body: some View {
        Button("Decode JSON") {
            let data = Data(self.input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.city)
            }
        }
    }
}*/

//NavigationLink and List:
/*struct ContentView: View {
    var body: some View {
        NavigationView {
            List(0..<10) { row in
                NavigationLink(destination: Text("Detail \(row)")) {
                    Text("Row: \(row)")
                }
            }
        .navigationBarTitle("SwiftUI")
        }
    }
}*/

//Simple NavigationLink:
/*struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("Detail View")) {
                    Text("SwiftUI")
                }
            }
        .navigationBarTitle("SwiftUI")
        }
    }
}*/

//ScrollView - note this creates all the views immediately.
/*struct CustomText: View {
    var text: String
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating new custom text: \(text)")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item: \($0)")   //Note that this will create all 100 views immediately - it won't wait for the user to scroll, like "List" does
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity) //Don't need to scroll over the exact location of the text now
        }
    }
}*/

//Image Resizing - fixed size:
/*VStack {
    Image("test")
    .resizable()
    .aspectRatio(contentMode: .fill)    //or .fit
    .frame(width: 300, height: 300, alignment: .center)
}*/
