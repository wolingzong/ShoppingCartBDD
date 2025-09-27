// File: Product.swift
import Foundation

struct Product: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let price: Decimal // 使用 Decimal 处理货币以避免浮点数精度问题
}
