//
//  FirebaseController .swift
//  2019S1 Lab 3
//
//  Created by Laveeshka Mahadea on 30/9/19.
//  Copyright © 2019 Michael Wybrow. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore




class FirebaseController: NSObject, DatabaseProtocol {
    
    var listeners = MulticastDelegate<DatabaseListener>()
    var authController: Auth
    var database: Firestore
    var recordsRef: CollectionReference?
    var recordList: [SensorData]

    

    
    
    override init() {
        // To use Firebase in our application we first must run the FirebaseApp configure method
        FirebaseApp.configure()
        // We call auth and firestore to get access to these frameworks
        authController = Auth.auth()
        database = Firestore.firestore()
        recordList = [SensorData]()

        
        super.init()
        
        // This will START THE PROCESS of signing in with an anonymous account
        // The closure will not execute until its recieved a message back which can be any time later
        
        authController.signInAnonymously() { (authResult, error) in
        guard authResult != nil else {
            fatalError("Firebase authentication failed")
        }
            
        // Once we have authenticated we can attach our listeners to the firebase firestore
        self.setUpListeners()
    }
}
    
    func setUpListeners() {
        recordsRef = database.collection("ColourTempDB")
        recordsRef?.addSnapshotListener(includeMetadataChanges: true) { querySnapshot, error in
            guard querySnapshot != nil else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            self.parseRecordsSnapshot(snapshot: querySnapshot!) }
        //teamsRef = database.collection("teams")
//        teamsRef?.whereField("name", isEqualTo: DEFAULT_TEAM_NAME).addSnapshotListener { querySnapshot, error in
//            guard let documents = querySnapshot?.documents else {
//                print("Error fetching teams: \(error!)")
//                return
//            }
//            self.parseTeamSnapshot(snapshot: documents.first!)
//
//        }
    }
    
    func parseRecordsSnapshot(snapshot: QuerySnapshot!) { snapshot.documentChanges.forEach { change in

        let documentRef = change.document.documentID
        
//        let blue = change.document.didChangeValue(forKey: "blue")
//                let red = change.document.didChangeValue(forKey: "red")
//                let green = change.document.didChangeValue(forKey: "green") as String
        
        if change.document.data()["blue"] as? Int == nil
        {
            return
        }
        
        let blue = change.document.data()["blue"] as! Int
        let green = change.document.data()["green"] as! Int
        let red = change.document.data()["red"] as! Int
        let temp = change.document.data()["temp"] as! Double
        let timeStamp = change.document.data()["time"] as! String
        let lux = change.document.data()["lux"] as! Double
        
        

        
            print("New Record: \(change.document.data())")
            let newRecord = SensorData()
            newRecord.red = red
            newRecord.blue = blue
            newRecord.green = green
            newRecord.temp = temp
            newRecord.timeStamp = timeStamp
            newRecord.lux = lux
            newRecord.id = documentRef
            recordList.append(newRecord)
            PerpetualReadings.allReadings.append(newRecord)
        
        if PerpetualReadings.allReadings.count > 0 {
            PerpetualReadings.latestReadings = PerpetualReadings.allReadings.last!
        }
        
//        if change.type == .modified {
//            print("Updated Record: \(change.document.data())")
//            let index = getRecordIndexByID(reference: documentRef)!
//            recordList[index].red = red
//                        recordList[index].green = green
//                        recordList[index].blue = blue
//                        recordList[index].temp = temp
//
//            recordList[index].id = documentRef
//        }
//        if change.type == .removed {
//            print("Removed Record: \(change.document.data())")
//            if let index = getRecordIndexByID(reference: documentRef) {
//                recordList.remove(at: index) }
//        }
//

        }
        listeners.invoke { (listener) in
            if listener.listenerType == ListenerType.records || listener.listenerType == ListenerType.all {
                listener.onRecordListChange(change: .update, records: recordList) }
        }
        
    }
    
//    func parseTeamSnapshot(snapshot: QueryDocumentSnapshot) { defaultTeam = Team()
//        defaultTeam.name = (snapshot.data()["name"] as! String)
//        defaultTeam.id = snapshot.documentID
//        if let heroReferences = snapshot.data()["heroes"] as? [DocumentReference] { // If the document has a "heroes" field, add heroes.
//            for reference in heroReferences {
//                let hero = getHeroByID(reference: reference.documentID)
//                guard hero != nil else {
//                    continue
//                }
//                defaultTeam.heroes.append(hero!) }
//        }
//        listeners.invoke { (listener) in
//            if listener.listenerType == ListenerType.team || listener.listenerType == ListenerType.all {
//                listener.onTeamChange(change: .update, teamHeroes: defaultTeam.heroes)
//
//            }
//        }
//    }
    
    
    func getRecordIndexByID(reference: String) -> Int? {
        for record in recordList {
        if(record.id == reference) {
            return recordList.firstIndex(of: record)
        }
        }
        return nil
    }
    
    func getRecordByID(reference: String) -> SensorData? {
        for record in recordList {
        if(record.id == reference) { return record
        }
            
        }
        return nil
    }
    
//    func addSuperHero(name: String, abilities: String) -> SuperHero {
//        let hero = SuperHero()
//        let id = heroesRef?.addDocument(data: ["name" : name, "abilities" : abilities])
//        hero.name = name
//        hero.abilities = abilities
//        hero.id = id!.documentID
//        return hero }
//
//
//    func addTeam(teamName: String) -> Team {
//        let team = Team()
//        let id = teamsRef?.addDocument(data: ["name" : teamName, "heroes": []])
//        team.id = id!.documentID
//        team.name = teamName
//        return team }
//
//    func addHeroToTeam(hero: SuperHero, team: Team) -> Bool {
//        guard let hero = getHeroByID(reference: hero.id), team.heroes.count < 6 else {
//            return false
//        }
//        team.heroes.append(hero)
//        let newHeroRef = heroesRef!.document(hero.id)
//        teamsRef?.document(team.id).updateData(["heroes" : FieldValue.arrayUnion([newHeroRef])])
//        return true
//    }
    
    func deleteSensorData(record: SensorData) {
        recordsRef?.document(record.id).delete()
    }
    
//    func deleteTeam(team: Team) {
//        teamsRef?.document(team.id).delete()
//    }
//
//    func removeHeroFromTeam(hero: SuperHero, team: Team) {
//        let index = team.heroes.index(of: hero)
//        let removedHero = team.heroes.remove(at: index!)
//        let removedRef = heroesRef?.document(removedHero.id)
//        teamsRef?.document(team.id).updateData(["heroes": FieldValue.arrayRemove([removedRef!])]) }
//
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
//        if listener.listenerType == ListenerType.team || listener.listenerType == ListenerType.all { listener.onTeamChange(change: .update, teamHeroes: defaultTeam.heroes)
//        }
        if listener.listenerType == ListenerType.records || listener.listenerType == ListenerType.all { listener.onRecordListChange(change: .update, records: recordList)
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }




}

