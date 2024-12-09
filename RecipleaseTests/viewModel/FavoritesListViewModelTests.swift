//
//  FavoritesListViewModelTests.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 15/11/2024.
//

import XCTest
@testable import Reciplease

final class FavoritesListViewModelTests: XCTestCase {
    var viewModel: FavoritesListViewModel!
    var mockDataProvider: RecipeDataProviderMock!
    var testRecipe: RecipeCoreData!
    var coreDataStack: TestCoreDataStack!
    
    override func setUp() {
        super.setUp()
        mockDataProvider = RecipeDataProviderMock()
        viewModel = FavoritesListViewModel(dataProvider: mockDataProvider)
        
        // Initialisation du CoreDataStack de test
        coreDataStack = TestCoreDataStack()
        
        // Création d'une recette de test avec un contexte valide
        let context = coreDataStack.persistentContainer.viewContext
        testRecipe = RecipeCoreData(context: context)
        testRecipe.id = "recipe123"
        testRecipe.url = "testUrl.com"
        testRecipe.label = "Test Recipe"
        testRecipe.imageUrl = "image.jpg"

        // Sauvegarde du contexte
        try? context.save()
    }
    
    override func tearDown() {
        mockDataProvider.reset()
        mockDataProvider = nil
        viewModel = nil
        testRecipe = nil
        coreDataStack = nil
        super.tearDown()
    }
    
    func testAddRecipeToFavorites() {
        // When
        XCTAssertNoThrow(try viewModel.addRecipeToFavorites(recipe: testRecipe))
        
        // Then
        XCTAssertEqual(mockDataProvider.addToFavoritesCallCount, 1)
        XCTAssertTrue(mockDataProvider.isRecipeInFavorites(recipe: testRecipe))
    }
    
    func testAddRecipeToFavoritesWithError() {
        // Given
        mockDataProvider.shouldThrowError = true
        
        // When/Then
        XCTAssertThrowsError(try viewModel.addRecipeToFavorites(recipe: testRecipe)) { error in
            XCTAssertEqual(error as? RecipeDataProviderMock.MockError, .simulatedError)
        }
        XCTAssertEqual(mockDataProvider.addToFavoritesCallCount, 1)
        XCTAssertFalse(mockDataProvider.isRecipeInFavorites(recipe: testRecipe))
    }
    
    func testRemoveRecipeFromFavorites() {
        // Given
        try? mockDataProvider.addRecipeToFavorites(recipe: testRecipe)
        XCTAssertTrue(mockDataProvider.isRecipeInFavorites(recipe: testRecipe))
        
        // When
        viewModel.removeRecipeFromFavorites(recipe: testRecipe)
        
        // Then
        XCTAssertEqual(mockDataProvider.removeFromFavoritesCallCount, 1)
        XCTAssertFalse(mockDataProvider.isRecipeInFavorites(recipe: testRecipe))
    }
    
    func testGetRecipesInFavorite() {
        // Given
        try? mockDataProvider.addRecipeToFavorites(recipe: testRecipe)
        
        // When
        let favorites = viewModel.getRecipesInFavorite()
        
        // Then
        XCTAssertEqual(mockDataProvider.getRecipesInFavoriteCallCount, 1)
        XCTAssertFalse(favorites.isEmpty)
        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites.first?.id, testRecipe.id)
    }
    
    func testGetRecipesInFavoriteWhenEmpty() {
        // When
        let favorites = viewModel.getRecipesInFavorite()
        
        // Then
        XCTAssertEqual(mockDataProvider.getRecipesInFavoriteCallCount, 1)
        XCTAssertTrue(favorites.isEmpty)
    }
}
