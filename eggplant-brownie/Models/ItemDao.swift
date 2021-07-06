
import Foundation

class ItemDao{
    func save(_ items: [Item]){
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
            guard let path = recoverPath() else {return}
            try data.write(to: path)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func recover() -> [Item]{
        do{
            guard let directory = recoverPath() else {return []}
            let data = try Data(contentsOf: directory)
            let savedItems = try
                NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Item]
             return savedItems
        }catch{
            print(error.localizedDescription)
            return []
        }
    }
    
    func recoverPath() -> URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in:
                    .userDomainMask).first else{return nil}
        let path = directory.appendingPathComponent("items")
        
        return path
    }
}
