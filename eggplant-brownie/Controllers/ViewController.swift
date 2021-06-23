
import UIKit

protocol AdicionaRefeicaoDelegate {
    func adicionar(refeicao: Refeicao)
}

class ViewController: UIViewController {
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet weak var felicidadeTextField: UITextField?

    var delegate: AdicionaRefeicaoDelegate?
    
    @IBAction func adicionar(_ sender: Any) {
        
        
        guard let nomeDaRefeicao = nomeTextField?.text else {
            return
        }
        
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade)
        
        print("comi \(refeicao.nome) e fiquei com felicidade: \(refeicao.felicidade)")

        delegate?.adicionar(refeicao: refeicao)

        navigationController?.popViewController(animated: true)
    }
}

