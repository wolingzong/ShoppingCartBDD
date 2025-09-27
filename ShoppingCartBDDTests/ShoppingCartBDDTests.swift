// File: ShoppingCartBDDTests.swift
import Testing // 导入新的 SwiftTesting 框架
@testable import ShoppingCartBDD // 导入主 App 模块以访问其代码

// 为了让测试代码更像 Gherkin，我们定义一些辅助函数
// 这些函数本身不做任何事，只是为了代码结构和可读性
func given(_ description: String, _ block: () throws -> Void) rethrows { try block() }
func when(_ description: String, _ block: () throws -> Void) rethrows { try block() }
func then(_ description: String, _ block: () throws -> Void) rethrows { try block() }
func and(_ description: String, _ block: () throws -> Void) rethrows { try block() }

// 定义一个测试套件，对应 Gherkin 的 Feature
@Suite("Feature: ShoppingCartTests\nAs a user, I want to add products to my shopping cart and see the total price update correctly.")
struct ShoppingCartBDDTests {

    let iphone18 = Product(name: "iPhone 18", price: 1299.00)

    // Scenario: 000 Add A Product To An Empty Cart
    @Test("Scenario: 000 Add A Product To An Empty Cart")
    func addFirstProductToEmptyCart() throws {
        var cart: ShoppingCart!

        given("I am a logged-in user and my shopping cart is empty") {
            cart = ShoppingCart()
            #expect(cart.items.isEmpty, "购物车初始应为空")
        }

        when("I add the product \"iPhone 18\" to the cart") {
            cart.addProduct(iphone18)
        }

        then("I should see \"1\" item in the cart") {
            #expect(cart.totalItemQuantity == 1, "购物车总件数应为 1")
        }

        and("the total price of the cart should be \"1299.00\" yuan") {
            #expect(cart.totalPrice == 1299.00, "购物车总价应为 1299.00")
        }
    }
    
    // Scenario: 001 Add A Second Product To The Cart
        @Test("Scenario: 001 Add A Second Product To The Cart")
        func addSecondProductToCart() throws {
            var cart: ShoppingCart!

            given("my shopping cart already has \"1\" item with a total price of \"1299.00\" yuan") {
                // 准备一个已经有一件商品的环境
                cart = ShoppingCart()
                cart.addProduct(iphone18)
                
                // 验证初始状态是否正确
                #expect(cart.totalItemQuantity == 1)
                #expect(cart.totalPrice == 1299.00)
            }

            when("I add the product \"iPhone 18\" to the cart") {
                // 执行与上一个场景相同的动作
                cart.addProduct(iphone18)
            }

            then("I should see \"2\" items in the cart") {
                #expect(cart.totalItemQuantity == 2, "购物车总件数应为 2")
            }

            and("the total price of the cart should be \"2598.00\" yuan") {
                #expect(cart.totalPrice == 2598.00, "购物车总价应为 2598.00")
            }
        }
    
}
