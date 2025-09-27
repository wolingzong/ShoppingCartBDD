# ShoppingCartBDD 示例项目

![Swift](https://img.shields.io/badge/Swift-5.10%2B-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%2017%2B-blue.svg)
![Xcode](https://img.shields.io/badge/Xcode-16%2B-blue.svg)
![Testing](https://img.shields.io/badge/Testing-SwiftTesting-red.svg)

一个使用苹果最新的 `SwiftTesting` 框架，以 BDD (行为驱动开发) 风格实现的 iOS 购物车功能示例项目。

## 📋 项目简介

这个项目不是一个完整的购物 App，而是一个专注于演示如何在 iOS 开发中实践 BDD 的技术 Demo。它展示了如何将自然语言描述的需求（Gherkin 风格）直接转化为可执行、可维护的 Swift 测试代码。

通过这种方式，测试代码本身就成了一份“活文档”，确保业务逻辑始终与产品需求保持一致。

## ✨ 主要特性

*   **行为驱动开发 (BDD)**：使用 `Given`, `When`, `Then` 结构，让测试代码像读故事一样清晰。
*   **最新的测试框架**：完全基于苹果在 WWDC24 推出的现代化 `SwiftTesting` 框架。
*   **清晰的测试组织**：使用 `@Suite` 和 `@Test` 宏来组织测试，其描述直接映射 Gherkin 的 `Feature` 和 `Scenario`。
*   **简洁的断言**：使用 `#expect` 宏进行条件验证。
*   **关注点分离**：业务模型 (`Product`, `ShoppingCart`) 与测试逻辑完全分离。

## 🚀 开始使用

### 环境要求

*   macOS Sonoma 14.5 或更高版本
*   Xcode 16 或更高版本 (因为 `SwiftTesting` 是 Xcode 16 的一部分)

### 安装与设置

1.  **克隆仓库**
    ```bash
    git clone https://github.com/your-username/ShoppingCartBDD.git
    ```

2.  **打开项目**
    ```bash
    cd ShoppingCartBDD
    open ShoppingCartBDD.xcodeproj
    ```

3.  **运行项目**
    项目本身是一个空 App，所有核心逻辑都在测试中验证。

## 🧪 运行测试

这是验证项目功能的核心步骤。

1.  在 Xcode 中，打开测试导航器 (Test Navigator)。
    *   快捷键：`⌘ + 6`
    *   或点击左侧导航栏的菱形图标。

2.  你会看到名为 `ShoppingCartTests` 的测试套件。

3.  点击套件或单个测试用例旁边的**播放按钮**来运行测试。

4.  所有测试通过后，菱形图标会显示为绿色对勾 ✅。

![Xcode Test Navigator](https://developer.apple.com/assets/elements/icons/test-plan/test-plan-96x96.png)

## 💡 BDD 实践：从需求到代码

项目的核心是展示如何将下面的业务需求转化为代码。

### 功能需求 (Gherkin 风格)

```gherkin
Feature: ShoppingCartTests
  As a user, I want to add products to my shopping cart and see the total price update correctly.

  Scenario: 000 Add A Product To An Empty Cart
    Given I am a logged-in user
    And my shopping cart is empty
    When I add the product "iPhone 18" to the cart
    Then I should see "1" item in the cart
    And the total price of the cart should be "1299.00" yuan

  Scenario: 001 Add A Second Product To The Cart
    Given my shopping cart already has "1" item with a total price of "1299.00" yuan
    When I add the product "iPhone 18" to the cart
    Then I should see "2" items in the cart
    And the total price of the cart should be "2598.00" yuan
```

### SwiftTesting 实现

下面的测试代码 (`ShoppingCartBDDTests.swift`) 几乎一字不差地“翻译”了上面的需求。

```swift
import Testing
@testable import ShoppingCartBDD

// 辅助函数，用于模拟 Gherkin 关键字，增强可读性
func given(_ description: String, _ block: () throws -> Void) rethrows { try block() }
func when(_ description: String, _ block: () throws -> Void) rethrows { try block() }
func then(_ description: String, _ block: () throws -> Void) rethrows { try block() }
func and(_ description: String, _ block: () throws -> Void) rethrows { try block() }

@Suite("Feature: ShoppingCartTests\nAs a user, I want to add products to my shopping cart and see the total price update correctly.")
struct ShoppingCartBDDTests {

    let iphone18 = Product(name: "iPhone 18", price: 1299.00)

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

    @Test("Scenario: 001 Add A Second Product To The Cart")
    func addSecondProductToCart() throws {
        var cart: ShoppingCart!

        given("my shopping cart already has \"1\" item with a total price of \"1299.00\" yuan") {
            cart = ShoppingCart()
            cart.addProduct(iphone18)
            #expect(cart.totalItemQuantity == 1)
            #expect(cart.totalPrice == 1299.00)
        }

        when("I add the product \"iPhone 18\" to the cart") {
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
```

## 📂 代码结构

```
ShoppingCartBDD/
├── ShoppingCartBDD/          # 主 App Target
│   ├── Product.swift         # 商品模型
│   └── ShoppingCart.swift    # 购物车核心业务逻辑
│
└── ShoppingCartBDDTests/     # 测试 Target
    └── ShoppingCartBDDTests.swift # BDD 风格的测试用例
```

## 📄 许可证

该项目采用 MIT 许可证。
