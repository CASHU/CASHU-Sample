//
//  PaymentMethodsViewController.swift
//  CASHU-Sample
//
//  Created by Ahmed Abd El-Samie on 6/6/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit
import CASHU

class PaymentMethodsViewController: UIViewController {
    
    @IBOutlet weak var paymentMethodsTableView: UITableView!
    var paymentMethodsList : [PaymentMethod] = []
    
    var product : Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentMethodsTableView.rowHeight = UITableViewAutomaticDimension
        paymentMethodsTableView.estimatedRowHeight = 96
        
        self.configureData()
        self.paymentMethodsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Payment Method"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func configureData(){
        let paymentMethod = PaymentMethod()
        paymentMethod.name = "CASHU English"
        paymentMethodsList.append(paymentMethod)
        let paymentMethod2 = PaymentMethod()
        paymentMethod2.name = "CASHU Arabic"
        paymentMethodsList.append(paymentMethod2)
        let paymentMethod3 = PaymentMethod()
        paymentMethod3.name = "Other"
        paymentMethodsList.append(paymentMethod3)
        
        self.paymentMethodsTableView.reloadData()
    }
}

extension PaymentMethodsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethodsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodsTableViewCell") as! PaymentMethodsTableViewCell
        
        let paymentMethod = self.paymentMethodsList[indexPath.row]
        cell.paymentMethodLabel.text = paymentMethod.name
        cell.paymentMethodImageView.image = UIImage(named: paymentMethod.name)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            //******* Setup CASHU Configurations
            let cashuConfigurations : CASHUConfigurations = CASHUConfigurations()
            cashuConfigurations.clientID = "CLIENT_ID_PROD-07BFE10888B0DE6010A8049A0B2E87DD"
            //MERCHANT REFERENCE SHOULD BE UNIQUE, THIS IS TOTALY USED BY YOU
            cashuConfigurations.merchantReference = "cu\(Date().timeIntervalSince1970)"
            cashuConfigurations.environment = .prod
            cashuConfigurations.deviceID = "Unique device ID"
            
            // Initializing Product Details
            let productDetails : ProductDetails = ProductDetails()
            productDetails.currency = .usd
            productDetails.productName = product?.name ?? ""
            productDetails.price = product?.decimalPrice ?? 0.0
            productDetails.productImage = UIImage(named: product?.name ?? "")
            cashuConfigurations.productDetails = productDetails
            
            cashuConfigurations.presentingMethod = .push
            cashuConfigurations.language = .english
            cashuConfigurations.isLoggingEnabled = true
            //**************
            
            CASHUServices.initiateProductPaymentInParent(self, configurations: cashuConfigurations)
        }else if(indexPath.row == 1){
            //******* Setup CASHU Configurations
            let cashuConfigurations : CASHUConfigurations = CASHUConfigurations()
            cashuConfigurations.clientID = "CLIENT_ID_PROD-07BFE10888B0DE6010A8049A0B2E87DD"
            //MERCHANT REFERENCE SHOULD BE UNIQUE, THIS IS TOTALY USED BY YOU
            cashuConfigurations.merchantReference = "cu\(Date().timeIntervalSince1970)"
            cashuConfigurations.environment = .prod
            cashuConfigurations.deviceID = "Unique device ID"
            
            // Initializing Product Details
            let productDetails : ProductDetails = ProductDetails()
            productDetails.currency = .usd
            productDetails.productName = product?.name ?? ""
            productDetails.price = product?.decimalPrice ?? 0.0
            productDetails.productImage = UIImage(named: product?.name ?? "")
            cashuConfigurations.productDetails = productDetails
            
            cashuConfigurations.presentingMethod = .push
            cashuConfigurations.language = .arabic
            cashuConfigurations.isLoggingEnabled = true
            //**************
            
            CASHUServices.initiateProductPaymentInParent(self, configurations: cashuConfigurations)
        }
    }
    
}
