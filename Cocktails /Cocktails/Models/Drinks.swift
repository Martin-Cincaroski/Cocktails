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
     
    let alphabet = ["A", "B", "C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var alphabetIndex = 0
    
    let urlBase = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
    var urlString = ""
    var drinkArray: [Drink] = []
    var isFetching = false
    
    func getData(completed: @escaping () -> ()) {
        guard !isFetching else {
            print("<><><> didn't call getDatagere becouse we hadn't fetched data. " )
            completed()
            return
        }
        
        isFetching = true
        
        urlString = urlBase + alphabet[alphabetIndex]
        print("We are accesing the url \(urlString)")
        alphabetIndex += 1

        // Create the url
        guard let url = URL(string: urlString) else {
            print("ERROR: Coud not create the url \(urlString)")
            isFetching = false
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
                self.drinkArray = self.drinkArray + returned.drinks
                
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            self.isFetching = false
            completed()
        }
        
        task.resume()
        
    }
}

