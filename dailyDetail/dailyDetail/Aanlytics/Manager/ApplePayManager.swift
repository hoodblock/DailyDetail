//
//  ApplePayManager.swift
//  dailyDetail
//
//  Created by nan on 2025/9/21.
//

import Foundation
import StoreKit
import UIKit

public enum PayStatus {
    case unpaid
    case purchasing
    case purchased(String)   // 收据
    case failed(PayError)
    case restored
}

public enum PayError: Error {
    case productNotFound
    case paymentCancelled
    case paymentFailed(Error?)
    case receiptMissing
    case unknown
}

final class ApplePayManager: NSObject {
    static let shared = ApplePayManager()
    
    public var onStatusChanged: ((PayStatus) -> Void)?
    
    private override init() {
        super.init()
        if #unavailable(iOS 15.0) {
            SKPaymentQueue.default().add(self)
        }
    }
    
    deinit {
        if #unavailable(iOS 15.0) {
            SKPaymentQueue.default().remove(self)
        }
    }
    
    // MARK: - 统一购买入口
    public func purchase(productId: String) {
        if #available(iOS 15.0, *) {
            purchaseSK2(productId: productId)
        } else {
            purchaseSK1(productId: productId)
        }
    }
    
    // MARK: - 恢复购买
    public func restorePurchases() {
        if #available(iOS 15.0, *) {
            restorePurchasesSK2()
        } else {
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
    
    // MARK: - StoreKit 2 购买
    @available(iOS 15.0, *)
    private func purchaseSK2(productId: String) {
        Task {
            do {
                let products = try await Product.products(for: [productId])
                guard let product = products.first else {
                    dispatchStatus(.failed(.productNotFound))
                    return
                }
                
                let result = try await product.purchase()
                switch result {
                case .success(let verification):
                    switch verification {
                    case .unverified(_, let error):
                        dispatchStatus(.failed(.paymentFailed(error)))
                    case .verified(let transaction):
                        await transaction.finish()
                        if let receipt = await self.fetchReceipt() {
                            dispatchStatus(.purchased(receipt))
                        } else {
                            dispatchStatus(.failed(.receiptMissing))
                        }
                    }
                case .userCancelled:
                    dispatchStatus(.failed(.paymentCancelled))
                case .pending:
                    dispatchStatus(.purchasing)
                @unknown default:
                    dispatchStatus(.failed(.unknown))
                }
            } catch {
                dispatchStatus(.failed(.paymentFailed(error)))
            }
        }
    }
    
    // MARK: - StoreKit 2 恢复
    @available(iOS 15.0, *)
    private func restorePurchasesSK2() {
        Task {
            for await verification in Transaction.currentEntitlements {
                switch verification {
                case .verified(let transaction):
                    await transaction.finish()
                    if let receipt = await fetchReceipt() {
                        dispatchStatus(.restored)
                        dispatchStatus(.purchased(receipt))
                    }
                case .unverified(_, let error):
                    dispatchStatus(.failed(.paymentFailed(error)))
                }
            }
        }
    }
    
    // MARK: - StoreKit 1 购买
    private func purchaseSK1(productId: String) {
        guard SKPaymentQueue.canMakePayments() else {
            dispatchStatus(.failed(.unknown))
            return
        }
        let request = SKProductsRequest(productIdentifiers: [productId])
        request.delegate = self
        request.start()
    }
    
    // 获取收据
    private func fetchReceipt() async -> String? {
        guard let receiptURL = Bundle.main.appStoreReceiptURL,
              let data = try? Data(contentsOf: receiptURL) else {
            return nil
        }
        return data.base64EncodedString()
    }
    
    private func dispatchStatus(_ status: PayStatus) {
        DispatchQueue.main.async {
            self.onStatusChanged?(status)
        }
    }
}

// MARK: - StoreKit 1 delegate
extension ApplePayManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard let product = response.products.first else {
            dispatchStatus(.failed(.productNotFound))
            return
        }
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

extension ApplePayManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                dispatchStatus(.purchasing)
            case .purchased:
                if let receipt = try? Data(contentsOf: Bundle.main.appStoreReceiptURL!).base64EncodedString() {
                    dispatchStatus(.purchased(receipt))
                } else {
                    dispatchStatus(.failed(.receiptMissing))
                }
                queue.finishTransaction(transaction)
            case .restored:
                if let receipt = try? Data(contentsOf: Bundle.main.appStoreReceiptURL!).base64EncodedString() {
                    dispatchStatus(.restored)
                    dispatchStatus(.purchased(receipt))
                }
                queue.finishTransaction(transaction)
            case .failed:
                let error = transaction.error
                if (error as? SKError)?.code == .paymentCancelled {
                    dispatchStatus(.failed(.paymentCancelled))
                } else {
                    dispatchStatus(.failed(.paymentFailed(error)))
                }
                queue.finishTransaction(transaction)
            default: break
            }
        }
    }
}
