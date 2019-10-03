//
//  DatabaseProtocol.swift
//  2019S1 Lab 3
//
//  Created by Michael Wybrow on 22/3/19.
//  Copyright © 2019 Michael Wybrow. All rights reserved.
//

import Foundation

enum DatabaseChange {
    case add
    case remove
    case update
}

enum ListenerType {
    //case team
    case records
    case all
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    //func onTeamChange(change: DatabaseChange, teamHeroes: [SuperHero])
    func onRecordListChange(change: DatabaseChange, records: [SensorData])
}

protocol DatabaseProtocol: AnyObject {
    //var defaultTeam: Team {get}
    
    //func addSuperHero(name: String, abilities: String) -> SuperHero
    //func addTeam(teamName: String) -> Team
    //func addHeroToTeam(hero: SuperHero, team: Team) -> Bool
    func deleteSensorData(record: SensorData)
    //func deleteTeam(team: Team)
    //func removeHeroFromTeam(hero: SuperHero, team: Team)
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
