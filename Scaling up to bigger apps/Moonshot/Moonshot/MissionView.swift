//
//  MissionView.swift
//  Moonshot
//
//  Created by user on 6/19/2024.
//

import SwiftUI

struct RectangleDivider : View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

struct HorizontalCrewView: View {
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                               .resizable()
                               .frame(width: 104, height: 72)
                               .clipShape(.capsule)
                               .overlay(
                                    Capsule()
                                       .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment:.leading) {
                                Text(crewMember.astronaut.name)
                                   .foregroundStyle(.white)
                                   .font(.headline)
                                   .accessibilityLabel(crewMember.astronaut.name.replacingOccurrences(of: ".", with: " "))
                                
                                Text(crewMember.role)
                                   .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                       .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let crew: [CrewMember]

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .accessibilityLabel("The mission badge for \(mission.displayName)")
                    .accessibilityLabel(mission.badge)
                
                if mission.launchDate != nil {
                    // String(describing:) to silence error because I am already handling nil anyways no need to add a date type as ??
                    Text("Launch date: \(String(describing: mission.formattedLaunchDate))")
                        .padding()
                } else {
                    Text("Launch date: N/A")
                        .padding()
                }
                
                VStack(alignment: .leading) {
                    RectangleDivider()

                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    Text(mission.description)

                    RectangleDivider()

                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)

                HorizontalCrewView(crew: crew)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = FileManager.default.decode("missions.json")
    let astronauts: [String: Astronaut] = FileManager.default.decode("astronauts.json")

    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
