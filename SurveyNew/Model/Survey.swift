//
//  Survey.swift
//  SurveyNew
//
//  Created by Sam Bryson on 10/5/17.
//  Copyright © 2017 SamuelGBryson. All rights reserved.
//

import Foundation


struct Survey {
    
    
    // KEYS
    
    private let nameKey = "name"
    private let emojiKey = "emoji"
    private let uuidKey = "uuid"
    
    
    // Properties
    
    let identifier: UUID // like a timestamp. right then and there
    let name: String
    let emoji: String
    
    
    
    
    // Memberwise init
    
    init(name: String, emoji: String, identifier: UUID = UUID()) {
        
        self.name = name
        self.emoji = emoji
        self.identifier = identifier
    }
    
    
    
    
    // MARK Failable init Use failables when we are getting data from the internet
    
    init?(dictionary: [String: Any], identifier: String) {
        
        guard let name = dictionary[nameKey] as? String,
            let emoji = dictionary[emojiKey] as? String,
            let identifier = UUID(uuidString: identifier) else { return nil }
        
        self.name = name
        self.emoji = emoji
        self.identifier = identifier
        
        
    }
    
    // Dictionary Representation
    
    var dictionaryRep: [String: Any] {
        
        let dictionary: [String: Any] = [
            nameKey: name,
            emojiKey: emoji,
            uuidKey: identifier.uuidString
        ]
        return dictionary
    }
    // Turn or serialize dictionaryRep into Data
        
        
        
        
    // Return JSON data from our object
    
    
    // PUT to JSON
    
        var jsonData: Data? {
            
            return try? JSONSerialization.data(withJSONObject: dictionaryRep, options: .prettyPrinted)
            
            
            
        }
    
    
}
