import XCTest
@testable import Reciplease

final class RecipeTests: XCTestCase {
    func testFromCoreData() {
        // Given
        let expectedRecipe = Recipe(
            id: "test_id",
            label: "Test Recipe",
            image: "test_image_url",
            url: "test_url",
            ingredients: [
                Ingredient(
                    text: "Ingredient 1",
                    quantity: 0,
                    measure: nil,
                    food: "Ingredient 1",
                    weight: 0,
                    foodCategory: "",
                    foodID: "",
                    image: nil),
                Ingredient(
                    text: "Ingredient 2",
                    quantity: 0,
                    measure: nil,
                    food: "Ingredient 2",
                    weight: 0,
                    foodCategory: "",
                    foodID: "",
                    image: nil)
            ],
            totalTime: 30,
            isFavorite: true
        )
        let context = TestCoreDataStack().persistentContainer.viewContext
        let mockRecipeCoreData = RecipeCoreData(context: context)
        mockRecipeCoreData.setValue("test_id", forKey: "id")
        mockRecipeCoreData.setValue("Test Recipe", forKey: "label")
        mockRecipeCoreData.setValue("test_image_url", forKey: "imageUrl")
        mockRecipeCoreData.setValue("test_url", forKey: "url")
        mockRecipeCoreData.setValue(30, forKey: "cookingTime")
        mockRecipeCoreData.setValue(["Ingredient 1", "Ingredient 2"], forKey: "ingredients")

        // When
        let recipe = Recipe.fromCoreData(recipe: mockRecipeCoreData)

        // Then
        XCTAssertEqual(recipe.id, expectedRecipe.id)
        XCTAssertEqual(recipe.label, expectedRecipe.label)
        XCTAssertEqual(recipe.image, expectedRecipe.image)
        XCTAssertEqual(recipe.url, expectedRecipe.url)
        XCTAssertEqual(recipe.totalTime, expectedRecipe.totalTime)
        XCTAssertEqual(recipe.ingredients.count, expectedRecipe.ingredients.count)
        XCTAssertTrue(recipe.isFavorite)
    }

    func testFromCoreDataWithEmptyData() {
        // Given
        let expectedRecipe = Recipe(
            id: "test_id",
            label: "",
            image: "",
            url: "",
            ingredients: [],
            totalTime: 0,
            isFavorite: true
        )
        let context = TestCoreDataStack().persistentContainer.viewContext
        let mockRecipeCoreData = RecipeCoreData(context: context)
        mockRecipeCoreData.setValue("test_id", forKey: "id")

        // When
        let recipe = Recipe.fromCoreData(recipe: mockRecipeCoreData)

        // Then
        XCTAssertEqual(recipe.id, expectedRecipe.id)
        XCTAssertEqual(recipe.label, expectedRecipe.label)
        XCTAssertEqual(recipe.image, expectedRecipe.image)
        XCTAssertEqual(recipe.url, expectedRecipe.url)
        XCTAssertEqual(recipe.totalTime, expectedRecipe.totalTime)
        XCTAssertEqual(recipe.ingredients.count, expectedRecipe.ingredients.count)
        XCTAssertTrue(recipe.isFavorite)
    }

    func testInsert() {
        // Given
        let context = TestCoreDataStack().persistentContainer.viewContext
        let recipe = Recipe(
            id: "test_id",
            label: "Test Recipe",
            image: "test_image_url",
            url: "test_url",
            ingredients: [
                Ingredient(
                    text: "Ingredient 1",
                    quantity: 0,
                    measure: nil,
                    food: "Ingredient 1",
                    weight: 0,
                    foodCategory: "",
                    foodID: "",
                    image: nil)
            ],
            totalTime: 30,
            isFavorite: true
        )

        // When
        let recipeCoreData = recipe.insert(into: context)

        // Then
        XCTAssertNotNil(recipeCoreData)
        XCTAssertEqual(recipeCoreData.id, recipe.id)
        XCTAssertEqual(recipeCoreData.label, recipe.label)
        XCTAssertEqual(recipeCoreData.imageUrl, recipe.image)
        XCTAssertEqual(recipeCoreData.url, recipe.url)
        XCTAssertEqual(recipeCoreData.cookingTime, Int16(recipe.totalTime))
        XCTAssertEqual(recipeCoreData.ingredients, ["Ingredient 1"])
    }
}
