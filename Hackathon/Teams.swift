//
//  Teams.swift
//  Hackathon
//
//  Created by John Gallaugher on 4/22/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import Firebase

class Teams {
    var teamArray: [Team] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    // Can be reused. Only thing that may change for new apps are
    //   - # of parameters in loadData (if it is being called by a
    //     value that helps find a document location),
    //   - you'll need to create a convenience initializer in the singular class (Spot, below) that accepts
    //     a dictionary and returns an instance of the singular class,
    //   - and change anything that begins with the word "spot"/"Spot" to the new class names
    func loadData(completed: @escaping () -> ())  {
        db.collection("teams").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.teamArray = []
            // there are querySnapshot!.documents.count documents in teh spots snapshot
            for document in querySnapshot!.documents {
                // You'll have to be sure you've created an initializer in the singular class (Spot, below) that acepts a dictionary.
                let team = Team(dictionary: document.data())
                team.documentID = document.documentID
                self.teamArray.append(team)
            }
            completed()
        }
    }
}
