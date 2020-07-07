
import UIKit

class MarvelSearchViewController: UIViewController {
    
    var marvelService = MarvelService()
    var marvelResponse: [Result] = []
    
    @IBOutlet weak var marvelTableView: UITableView!
    @IBOutlet weak var marvelSearchingBar: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        request()
    }
    
    @IBAction func marvelSearchingButton(_ sender: Any) {
        request()
    }
    
    func request(){
        MarvelURL.idURL = ""
        if marvelSearchingBar.text != ""{
            MarvelURL.parameters = "&nameStartsWith=" + (marvelSearchingBar.text ?? "")
        }
        marvelService.getMarvel { (success, marvelResponseJSON) in
            guard let marvel = marvelResponseJSON else {
                self.presentAlert(message: "Error with the response, please try later")
                print("error")
                return
            }
            self.marvelResponse = marvel.data.results
            self.marvelTableView.reloadData()
        }
    }
}

    // MARK: - Extension UITableViewDatasource
extension MarvelSearchViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "marvelCell", for: indexPath) as? MarvelTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(result: marvelResponse[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marvelResponse.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "marvelDetails"{
            let succesVC = segue.destination as! MarvelDetailsViewController
            guard let indexPath = self.marvelTableView.indexPathForSelectedRow else { return }
            succesVC.marvelDetail = marvelResponse[indexPath.row]
        }
    }
}

extension MarvelSearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



