
import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate {

    var refeicoes = [Refeicao(nome: "Beringela", felicidade: 5),
                     Refeicao(nome: "Macarrão", felicidade: 3)]

    func adicionar(refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Adicionar"{
            if let view = segue.destination as? ViewController{
                view.delegate = self
            }
        }
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let linha = indexPath.row

        let refeicao = refeicoes[linha]

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = refeicao.nome

        return cell
    }
}
