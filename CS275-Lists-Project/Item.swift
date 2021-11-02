//
//  Item.swift
//  CS275-Lists-Project
//
//  Created by Sam Pitonyak on 10/20/21.
//

import UIKit

class Item: Equatable, Codable {
    var teamName: String
    var record: String
    var division: String
    var established: String //Used to be Int
    var schedule = [String]()
    
    init(teamName: String, record: String, division: String, established: String, schedule: [String]) {
        self.teamName = teamName
        self.record = record
        self.division = division
        self.established = established
        self.schedule = schedule
    }
    
    convenience init(random: Bool = false) {
        if random {
            let names = ["Philadelphia Eagles", "New England Patriots", "Baltimore Ravens", "Arizona Cardinals"]
            let records = ["2-4-0", "2-4-0", "5-1-0", "6-0-0"]
            let divisions = ["NFC East", "AFC East", "AFC North", "NFC West"]
            let establishDate = ["1933", "1960", "1996", "1898"]
            let schedules = ["Eagles vs. Falcons : 32-6", "Dolphins vs. Patriots : 17-16", "Ravens vs. Raiders : 27-33", "Cardinals vs. Titans : 38-13"]
            
            let randomVal = Int.random(in: 0..<4)
            let randomTeam = names[randomVal]
            let randomRecord = records[randomVal]
            let randomDivision = divisions[randomVal]
            let randomEstablish = establishDate[randomVal]
            let randomSchedule:[String] = [schedules[randomVal]]
            
            self.init(teamName: randomTeam,
                      record: randomRecord,
                      division: randomDivision,
                      established: randomEstablish,
                      schedule: randomSchedule)
        } else {
            self.init(teamName: "UVM", record: "3-0-1", division: "America East", established: "1791", schedule: ["UVM vs. Penn State : 63-0"])
        }
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.teamName == rhs.teamName
        && lhs.record == rhs.record
        && lhs.division == rhs.division
        && lhs.established == rhs.established
        && lhs.schedule == rhs.schedule
    }
}
