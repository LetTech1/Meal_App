
import Foundation

class MealDao{
    
    func save(_ meals: [Meal]){
        guard let path = recoverPath() else {return}
        
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
            try data.write(to: path)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func recover() -> [Meal]{
        guard let path = recoverPath() else {return []}
        
        do{
            let data = try Data(contentsOf: path)
            guard let savedMeals = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as?
                    Array<Meal> else {return []}
          
            return savedMeals
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func recoverPath() -> URL?{
        guard let directory = FileManager.default.urls(for: .documentDirectory, in:
                    .userDomainMask).first else{return nil}
        let path = directory.appendingPathComponent("refeicao")
        
        return path
    }
    
    
}
