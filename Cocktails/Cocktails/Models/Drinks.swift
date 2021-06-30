//
//  Drinks.swift
//  Cocktails
//
//  Created by Martin on 6/27/21.
//

import Foundation

class Drinks {
    
    struct Returned: Codable {
        var drinks: [Drink]
    }
    
    
    let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=A"
    var drinkArray: [Drink] = []
    
    func getData(completed: @escaping () -> ()) {
        print("We are accesing the url \(urlString)")
        

        // Create the url
        guard let url = URL(string: urlString) else {
            print("ERROR: Coud not create the url \(urlString)")
            completed()
            return
        }
        
        // Create session
        let session = URLSession.shared
        // Get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            
            // Deal with the data
            do {
                
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.drinkArray = returned.drinks
                
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            
            completed()
        }
        
        task.resume()
        
    }
}
