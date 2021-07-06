
import UIKit

class Item: NSObject, NSCoding {
    
    // MARK: - Atributos
    
    let name: String
    let calories: Double
    
    // MARK: - Init
    
    init(name: String, calories: Double) {
        self.name = name
        self.calories = calories
    }
    
    // MARK: - NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(calories, forKey: "calories")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        calories = coder.decodeDouble(forKey: "calories")
    }
}
