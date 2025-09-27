// File: ShoppingCart.swift
import Foundation

struct CartItem: Identifiable {
    // 改为计算属性，直接从 product 获取 id
    var id: UUID { product.id }
    
    let product: Product
    var quantity: Int

    var totalPrice: Decimal {
        return product.price * Decimal(quantity)
    }
}

// 购物车模型
struct ShoppingCart {
    private(set) var items: [CartItem] = []

    // 购物车中的商品种类数量
    var uniqueItemCount: Int {
        return items.count
    }

    // 购物车中所有商品的总件数
    var totalItemQuantity: Int {
        return items.reduce(0) { $0 + $1.quantity }
    }

    // 购物车总价
    var totalPrice: Decimal {
        return items.reduce(0) { $0 + $1.totalPrice }
    }

    // 添加商品的核心方法
    mutating func addProduct(_ product: Product) {
        if let index = items.firstIndex(where: { $0.id == product.id }) {
            // 如果商品已存在，则数量加一
            items[index].quantity += 1
        } else {
            // 如果是新商品，则添加新条目 (注意这里的初始化方法已经改变)
            let newItem = CartItem(product: product, quantity: 1)
            items.append(newItem)
        }
    }
}
