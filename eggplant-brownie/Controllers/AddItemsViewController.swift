
import UIKit

protocol AddItemsDelegate {
    func add(_ item: Item)
}

class AddItemsViewController: UIViewController {
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    
    // MARK: - Atributos
    
    var delegate: AddItemsDelegate?
    
    init(delegate: AddItemsDelegate) {
        super.init(nibName: "AddItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - IBAction
    
    @IBAction func addItem(_ sender: Any) {
        guard let name = nameTextField.text, let calories = caloriesTextField.text else{
            return
        }
        
        if let numberOfCalories = Double(calories){
            let item = Item(name: name, calories: numberOfCalories)
            delegate?.add(item)
            navigationController?.popViewController(animated: true)
        }
        
        
    }
    

 
}
