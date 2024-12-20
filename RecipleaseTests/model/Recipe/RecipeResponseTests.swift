//
//  RecipeResponseTests.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 20/12/2024.
//

import XCTest
@testable import Reciplease

final class RecipeResponseTests: XCTestCase {

    func testDecodingRecipeResponse() {
        let json = """
        {
            "hits": [
                {
                    "recipe": {
                        "id": "1",
                        "label": "Pasta",
                        "image": "pasta.png",
                        "url": "http://example.com/pasta",
                        "ingredients": [],
                        "totalTime": 30
                    }
                }
            ]
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(RecipeResponse.self, from: json)
            XCTAssertEqual(response.hits.count, 1)
            XCTAssertEqual(response.hits[0].recipe.id, "1")
            XCTAssertEqual(response.hits[0].recipe.label, "Pasta")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}

final class HitTests: XCTestCase {

    func testHitDecoding() {
        let json = """
        {
            "recipe": {
                "id": "1",
                "label": "Pasta",
                "image": "pasta.png",
                "url": "http://example.com/pasta",
                "ingredients": [],
                "totalTime": 30
            }
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let hit = try decoder.decode(Hit.self, from: json)
            XCTAssertEqual(hit.recipe.id, "1")
            XCTAssertEqual(hit.recipe.label, "Pasta")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}

final class RecipeTests: XCTestCase {

    func testRecipeDecoding() {
        let json = """
        {
            "id": "1",
            "label": "Pasta",
            "image": "pasta.png",
            "url": "http://example.com/pasta",
            "ingredients": [],
            "totalTime": 30
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        do {
            let recipe = try decoder.decode(Recipe.self, from: json)
            XCTAssertEqual(recipe.id, "1")
            XCTAssertEqual(recipe.label, "Pasta")
            XCTAssertEqual(recipe.totalTime, 30)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func testFromCoreData() {
        let mockRecipeCoreData = RecipeCoreData()
        mockRecipeCoreData.id = "1"
        mockRecipeCoreData.label = "Pasta"
        mockRecipeCoreData.imageUrl = "pasta.png"
        mockRecipeCoreData.url = "http://example.com/pasta"
        mockRecipeCoreData.cookingTime = 30
        mockRecipeCoreData.ingredients = ["Tomato", "Basil"]

        let recipe = Recipe.fromCoreData(recipe: mockRecipeCoreData)

        XCTAssertEqual(recipe.id, "1")
        XCTAssertEqual(recipe.label, "Pasta")
        XCTAssertEqual(recipe.totalTime, 30)
        XCTAssertTrue(recipe.ingredients.count > 0)
    }

    func testInsertIntoCoreData() {
        let context = TestCoreDataStack().persistentContainer.viewContext
        let recipe = Recipe(
            id: "1",
            label: "Pasta",
            image: "pasta.png",
            url: "http://example.com/pasta",
            ingredients: [],
            totalTime: 30,
            isFavorite: false
        )

        let recipeCoreData = recipe.insert(into: context)

        XCTAssertNotNil(recipeCoreData)
        XCTAssertEqual(recipeCoreData.id, "1")
        XCTAssertEqual(recipeCoreData.label, "Pasta")
        XCTAssertEqual(recipeCoreData.cookingTime, 30)
    }
}
