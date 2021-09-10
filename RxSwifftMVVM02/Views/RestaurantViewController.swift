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
    
    private var restaurantsListViewModel: RestaurantsListViewModel = RestaurantsListViewModel()
    
    @IBOutlet weak var restaurantTableView: UITableView! {
        didSet {
            restaurantTableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Restaurants"
        
        /// tương đương UITableVIewDataSource
        /*
             func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = viewModel.displayText
                return cell
             }
         */
        restaurantsListViewModel
            .fetchRestaurantViewModels()
            .bind(to:
                    restaurantTableView
                    .rx
                    .items(cellIdentifier: "cell")) { index, viewModel, cell in
                cell.textLabel?.text = viewModel.displayText
            }
            .disposed(by: disposeBag)
        
        /// tương đương UITableViewDelegate
        /*
             func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as! RestaurantDetailViewController
         viewController.title = restaurentObject.displayText
                self.navigationController?.pushViewController(viewController, animated: true)
             }
         */
        restaurantTableView
            .rx
            .modelSelected(RestaurantViewModel.self)
            .subscribe(onNext: { [weak self] restaurentObject in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as! RestaurantDetailViewController
                viewController.title = restaurentObject.displayText
                self?.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

