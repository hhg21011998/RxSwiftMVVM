//
//  RestaurantViewController.swift
//  RxSwifftMVVM02
//
//  Created by MacOS on 09/09/2021.
//

import UIKit
import RxCocoa
import RxSwift

class RestaurantViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    private var viewModel: RestaurantsListViewModel = RestaurantsListViewModel()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Restaurants"
        
        // tương đương UITableVIewDataSource
        /*
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = viewModel.displayText
            return cell
         }
         */
        viewModel
            .fetchRestaurantViewModels()
            .bind(to: tableView.rx.items(cellIdentifier: "cell"))
            { index, viewModel, cell in
                cell.textLabel?.text = viewModel.displayText
            }.disposed(by: disposeBag)

        
        // tương đương UITableViewDelegate
        /*
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as! RestaurantDetailViewController
            vc.title = restaurentObject.displayText
            self.navigationController?.pushViewController(vc, animated: true)
         }
         */
        tableView
            .rx.modelSelected(RestaurantViewModel.self)
            .subscribe(onNext: { restaurentObject in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as! RestaurantDetailViewController
                vc.title = restaurentObject.displayText
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

