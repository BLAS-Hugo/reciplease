//
//  IngredientListTests.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 20/12/2024.
//

import XCTest
@testable import Reciplease

final class IngredientListTests: XCTestCase {
    var ingredientList: IngredientList!

    override func setUp() {
        super.setUp()
        ingredientList = IngredientList.shared
        ingredientList.clear() // Ensure the list is empty before each test
    }

    override func tearDown() {
        ingredientList.clear() // Clean up after each test
        ingredientList = nil
        super.tearDown()
    }

    func testAddIngredient() {
        // Given
        let ingredient = "Tomato"

        // When
        ingredientList.add(ingredient: ingredient)

        // Then
        XCTAssertTrue(ingredientList.contains(ingredient: ingredient), "Ingredient should be added to the list.")
    }

    func testAddDuplicateIngredient() {
        // Given
        let ingredient = "Tomato"
        ingredientList.add(ingredient: ingredient)

        // When
        ingredientList.add(ingredient: ingredient)

        // Then
        XCTAssertEqual(ingredientList.getAllIngredients().count, 1, "Duplicate ingredient should not be added.")
    }

    func testClearIngredients() {
        // Given
        ingredientList.add(ingredient: "Tomato")
        ingredientList.add(ingredient: "Onion")

        // When
        ingredientList.clear()

        // Then
        XCTAssertTrue(ingredientList.getAllIngredients().isEmpty, "Ingredient list should be empty after clearing.")
    }

    func testContainsIngredient() {
        // Given
        let ingredient = "Tomato"
        ingredientList.add(ingredient: ingredient)

        // When
        let contains = ingredientList.contains(ingredient: ingredient)

        // Then
        XCTAssertTrue(contains, "Ingredient list should contain the added ingredient.")
    }

    func testGetAllIngredients() {
        // Given
        ingredientList.add(ingredient: "Tomato")
        ingredientList.add(ingredient: "Onion")

        // When
        let ingredients = ingredientList.getAllIngredients()

        // Then
        XCTAssertEqual(ingredients.count, 2, "Should return all added ingredients.")
        XCTAssertTrue(ingredients.contains("Tomato"), "Should contain Tomato.")
        XCTAssertTrue(ingredients.contains("Onion"), "Should contain Onion.")
    }

    func testGetAllIngredientsWhenEmpty() {
        // When
        let ingredients = ingredientList.getAllIngredients()

        // Then
        XCTAssertTrue(ingredients.isEmpty, "Should return an empty array when no ingredients are added.")
    }
}
