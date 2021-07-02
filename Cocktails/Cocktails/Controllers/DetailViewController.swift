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
        createIngredientsList()
        
        guard let url = URL(string: drink.strDrinkThumb ?? "") else { return }
        do {
            let data = try Data(contentsOf: url)
            self.imageView.image = UIImage(data: data)
        } catch {
            print("ERROR: Could not get image for url \(url)")
        }
    }
    
    func addIngredients(measure: String?, ingredient: String?) {
        guard measure != nil else { return }
        ingredientTextView.text += measure!
        guard ingredient != nil else { return }
        ingredientTextView.text += " \(ingredient!)\n"
        
    }
    
    func createIngredientsList() {
        ingredientTextView.text = ""
        addIngredients(measure: drink.strMeasure1, ingredient: drink.strIngredient1)
        addIngredients(measure: drink.strMeasure2, ingredient: drink.strIngredient2)
        addIngredients(measure: drink.strMeasure3, ingredient: drink.strIngredient3)
        addIngredients(measure: drink.strMeasure4, ingredient: drink.strIngredient4)
        addIngredients(measure: drink.strMeasure5, ingredient: drink.strIngredient5)
        addIngredients(measure: drink.strMeasure6, ingredient: drink.strIngredient6)
        addIngredients(measure: drink.strMeasure7, ingredient: drink.strIngredient7)
        addIngredients(measure: drink.strMeasure8, ingredient: drink.strIngredient8)
        addIngredients(measure: drink.strMeasure9, ingredient: drink.strIngredient9)
        addIngredients(measure: drink.strMeasure10, ingredient: drink.strIngredient10)
        addIngredients(measure: drink.strMeasure11, ingredient: drink.strIngredient11)
        addIngredients(measure: drink.strMeasure12, ingredient: drink.strIngredient12)
        addIngredients(measure: drink.strMeasure13, ingredient: drink.strIngredient13)
        addIngredients(measure: drink.strMeasure14, ingredient: drink.strIngredient14)
        addIngredients(measure: drink.strMeasure15, ingredient: drink.strIngredient15)
        if ingredientTextView.text != "" {
            ingredientTextView.text.removeLast()
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
