//
//  ViewController.swift
//  ApıProject
//
//  Created by Akdag on 28.02.2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var models = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       fetch()
    }
    
    func fetch(){
        
        
        let url = "https://gist.githubusercontent.com/ashwini9241/6e0f26312ddc1e502e9d280806eed8bc/raw/7fab0cf3177f17ec4acd6a2092fc7c0f6bba9e1f/saltside-json-data"
        
        
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data , error == nil {
                    do{
                        let jsonData = try JSONDecoder().decode([Model].self, from: data)
                       
                        DispatchQueue.main.async {
                            self.models = jsonData
                            self.tableView.reloadData()
                            
                        }
                      
                    }catch{
                        print(error)
                    }
                }
            }.resume()
        }
        
        
        
    }


}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let model = models[indexPath.row]
        
        cell.titleLabel.text = model.title
        cell.DescriptionLabel.text = model.description
        cell.imageview.contentMode = .scaleAspectFill
        cell.imageview.sd_setImage(with: URL(string: model.image))
        
        
        
        return cell
    }
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "detail") as? DetailViewController else {return}
        let model = models[indexPath.row]
        vc.selectedModel = model
        
        navigationController?.pushViewController(vc, animated: true)
     
    }
}

