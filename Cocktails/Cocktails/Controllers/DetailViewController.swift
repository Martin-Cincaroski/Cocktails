//
//  DetailViewController.swift
//  Cocktails
//
//  Created by Martin on 6/26/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var alcoholLabel: UILabel!
    @IBOutlet weak var glassLabel: UILabel!
    @IBOutlet weak var ingredientTextView: UITextView!
    @IBOutlet weak var recipeTextView: UITextView!
    
    var drink: Drink!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if drink == nil {
            drink = Drink()
        }
     
        updateUserIterface()
        
    }
    
    func updateUserIterface() {
        drinkLabel.text = drink.strDrink
        alcoholLabel.text = "Yes"
        if drink.strAlcoholic != "Alcoholic" {
            alcoholLabel.text = "No"
        }
        glassLabel.text = drink.strGlass
        recipeTextView.text = drink.strInstructions
        
        guard let url = URL(string: drink.strDrinkThumb ?? "") else { return }
        do {
            let data = try Data(contentsOf: url)
            self.imageView.image = UIImage(data: data)
        } catch {
            print("ERROR: Could not get image for url \(url)")
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode{
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
  

}
