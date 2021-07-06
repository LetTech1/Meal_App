
import UIKit

class MealsTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    
    // MARK: - Atributos

    var meals: [Meal] = []
    
    override func viewDidLoad() {
        meals = MealDao().recover()
    }

    func add(meal: Meal) {
        meals.append(meal)
        tableView.reloadData()
        MealDao().save(meals)
    }
    
    @objc func showDetails(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began{
            let cell = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: cell) else {return}
            let meal = meals[indexPath.row]
            
            RemoveMealViewController(controller: self).show(meal, handler: {alert in
                self.meals.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
            
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Adicionar"{
            if let view = segue.destination as? ViewController{
                view.delegate = self
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let line = indexPath.row

        let meal = meals[line]

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = meal.name
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDetails(_:)))
        cell.addGestureRecognizer(longPress)

        return cell
    }
    
    
}
