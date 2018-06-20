//
//  ProductsListViewController.swift
//  CASHU-Sample
//
//  Created by Ahmed Abd El-Samie on 6/6/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    @IBOutlet weak var productsTableView: UITableView!
    var productList : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsTableView.rowHeight = UITableViewAutomaticDimension
        productsTableView.estimatedRowHeight = 96
        
        self.configureData()
        self.productsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Products"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func configureData(){
        let product = Product()
        product.name = "Transformer"
        product.priceText = "1000$"
        product.decimalPrice = 1000
        productList.append(product)
        let product2 = Product()
        product2.name = "Puppet"
        product2.priceText = "1$"
        product2.decimalPrice = 1
        productList.append(product2)
        let product3 = Product()
        product3.name = "Pokemon"
        product3.priceText = "2$"
        product3.decimalPrice = 2
        productList.append(product3)
        
        self.productsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showPaymentMethods"){
            if let paymentMethodsViewController = segue.destination as? PaymentMethodsViewController {
                paymentMethodsViewController.product = sender as? Product
            }
            
        }
    }
}

extension ProductsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell") as! ProductListTableViewCell
        cell.cellIndex = indexPath.row
        cell.delegate = self
        
        let product = self.productList[indexPath.row]
        cell.productNameLabel.text = product.name
        cell.productPriceLabel.text = product.priceText
        cell.productImageView.image = UIImage(named: product.name)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension ProductsListViewController : ProductListTableViewCellDelegate{
    func didTapOnPaymentButtonForCellWithIndex(cellIndex: Int) {
        self.performSegue(withIdentifier: "showPaymentMethods", sender: self.productList[cellIndex])
    }
}
