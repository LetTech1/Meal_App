
import UIKit

protocol AdicionaRefeicaoDelegate {
    func add(meal: Meal)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddItemsDelegate {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    // MARK: - Atributos
    
    var delegate: AdicionaRefeicaoDelegate?
    var items: [Item] = []
    var selectedItem: [Item] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet var nameTextField: UITextField?
    @IBOutlet weak var happinessTextField: UITextField?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        let buttonAddItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(addItems))
        navigationItem.rightBarButtonItem = buttonAddItem
        recoverItem()
    }
    
    func recoverItem(){
        items = ItemDao().recover()
    }
    
    @objc func addItems(){
        let addItemsViewController = AddItemsViewController(delegate: self)
        navigationController?.pushViewController(addItemsViewController, animated: true)
    }
    
    
    func add(_ item: Item) {
        items.append(item)
        ItemDao().save(items)
        if let tableView = itemsTableView{
            tableView.reloadData()
        }else {
            Alert(controller: self).show(message: "Não foi possível atualizar a tabela")
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            
        let tableRow = indexPath.row
        let item = items[tableRow]
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    // MARK - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.accessoryType == .none{
            cell.accessoryType = .checkmark
            let tableRow = indexPath.row
            selectedItem.append(items[tableRow])
        } else{
            cell.accessoryType = .none
            
            let item = items[indexPath.row]
            if let position = selectedItem.index(of: item){
                selectedItem.remove(at: position)
                
            }
        }
        
    }
    
    func retrieveFormMeal() -> Meal?{
        guard let nameOfTheMeal = nameTextField?.text else {
            return nil
        }
        
        guard let happinessOfTheMeal = happinessTextField?.text, let happiness = Int(happinessOfTheMeal) else {
            return nil
        }
        
        let meal = Meal(name: nameOfTheMeal, happiness: happiness, items: selectedItem)
        
        return meal
    }

    // MARK: - IBActions
    
    @IBAction func add(_ sender: Any) {
        if let meal = retrieveFormMeal(){
            delegate?.add(meal: meal)
            navigationController?.popViewController(animated: true)
        } else{
            Alert(controller: self).show(message: "Erro ao ler dados do formulário")
        }
    }
}

