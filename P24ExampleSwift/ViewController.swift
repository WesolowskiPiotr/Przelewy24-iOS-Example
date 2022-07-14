//
//  ViewController.swift
//  P24ExampleSwift
//
//  Created by Arkadiusz Macudziński on 12.02.2016.
//  Copyright © 2016 DialCom24. All rights reserved.
//

import UIKit
import P24

class ViewController: UIViewController, P24TransferDelegate, P24RegisterCardDelegate {
   
    let merchantId = Int32(XXX)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        P24SdkConfig.setCertificatePinningEnabled(true);
        P24SdkConfig.setExitOnBackButtonEnabled(false)
    }

    func getCrc() -> String {
        return "XXX"
    }
    
    func sessionId() -> String {
        let alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
        var sId = "";
        
        for _ in 0...25 {
            let r = (Int) (arc4random() % 62);
            
            let c = alphabet[alphabet.index(alphabet.startIndex, offsetBy: r)];
            sId.append(c);
        }
        
        print("Session id: \(sId)");
        return sId;
    }
    
    @IBAction func trnDirectClicked(_ sender: Any) {
        startTrnDirect()
    }

    func startTrnDirect() {
        let params = P24TrnDirectParams.init(transactionParams: getTransactionParams())!
        params.sandbox = true
        P24.startTrnDirect(params, in: self, delegate: self)
    }
    
    func getTransactionParams() -> P24TransactionParams {
    
        let transaction = P24TransactionParams()
        transaction.merchantId = merchantId
        transaction.crc = getCrc()
        transaction.sessionId = sessionId()
        transaction.address = "Test street"
        transaction.amount = 1
        transaction.city = "Poznań"
        transaction.zip = "61-600"
        transaction.client = "John Smith"
        transaction.country = "PL"
        transaction.language = "pl"
        transaction.currency = "PLN"
        transaction.email = "test124@test.pl"
        transaction.phone = "1223134134"
        transaction.desc = "description"
//        transaction.method = 181;
        
        return transaction
    }
    
    // MARK: P24TransferDeleagate
    func p24TransferOnSuccess() {
        print("Transaction success")
    }
    
    func p24TransferOnCanceled() {
        print("Transaction cancelled")
    }
    
    func p24Transfer(onError errorCode: String!) {
        print("Transaction error \(String(describing: errorCode))")
    }
    
    // MARK: P24RegisterCardDelegate
    func p24RegisterCardError(_ errorCode: String!) {
        print("Transaction error \(String(describing: errorCode))")
    }
    
    func p24RegisterCardCancel() {
        print("Transaction cancelled")
    }
    
    func p24RegisterCardSuccess(_ p24RegisterCardResult: P24RegisterCardResult!) {
        print("Card registered \(p24RegisterCardResult.cardToken!)")
    }

}




