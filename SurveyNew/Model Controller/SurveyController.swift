//
//  EmojiController.swift
//  SurveyNew
//
//  Created by Sam Bryson on 10/5/17.
//  Copyright © 2017 SamuelGBryson. All rights reserved.
//

import Foundation


class SurveyController {
    
    static let shared = SurveyController()
    
    // Source of truth
    
    var surveys: [Survey] = []
    
    // The empty completion is a great way to notify the caller of the function that you are done running the code. You can complete with an object or an array of objects when the caller needs to acceess them. Both options give you the benefit of knowing exactly when that function is done running. This is always nice when you are running a synchronous code. Because you don't know how long it will take.
    
    private let baseURL = URL(string: "https://emojisurvey-a9298.firebaseio.com/")
    
    func putSurvey(with name: String, emoji: String, completion: @escaping(_ success: Bool) -> Void ) {
        
        // Create and instance of Survey
        
        let survey = Survey(name: name, emoji: emoji)
        
        guard let url = baseURL else { fatalError("BAD URL")}
        
        // Build the URL
        
        let requestURL = url.appendingPathComponent(survey.identifier.uuidString).appendingPathExtension("json")
        
        // Create a Request
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.httpBody = survey.jsonData
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            var success = false
            
            defer { completion(success) }
            
            
            // Error handling
            
            if let error = error {
                print("Request was fucced \(error.localizedDescription) \(#function) \(#file)")
                
            }
            
            guard let data = data,
                let responseDataString = String(data: data, encoding: .utf8) else { return }
            if let error = error {
                print("Error: \(error.localizedDescription) \(#function)")
            } else {
                print("Successfully saved the data to endpoint \(responseDataString)")
            }
            
            // Add survey to our source of truth
            
            self.surveys.append(survey)
            
            success = true
            
            }.resume()
        
    }
    
    func fetchEmoji(completion: @escaping () -> Void) {
        
        guard let url = baseURL?.appendingPathExtension("json") else {
            print("Bad baseURL")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error fetching \(error.localizedDescription) \(#function) \(#file)")
            }
            
            guard let data = data else {
                print("No data returned from data task")
                completion()
                return
            }
            
            // Serialize the Data
            
            guard let surveyDictionaries = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: String]]) else {
                print("Fetching from JSONObject")
                completion()
                return
            }
            
            guard let surveys = surveyDictionaries?.flatMap({Survey(dictionary: $0.value, identifier: $0.key )}) else { return }
            
            
            self.surveys = surveys
            completion()
            
            }.resume()
        
    }
    
    
}
