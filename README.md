# Pokedex

## Description
The Pokedex app uses the [PokeAPI](https://pokeapi.co/) to display a list of pokemons, by tapping on a specific pokemon you can see the details of that pokemon, through the button on the top right of the list it is possible to filter the list by pokemon type.

### Light Theme
| Video | Pokemon List | Details Screen | Filter Screen |
| ------------- | ------------- | ----------- | ----------- | 
| <img src="https://github.com/filipero/pokedex/assets/28496460/2889c595-ba5b-4915-a358-bf17486f1418" width="300"> | <img src="https://github.com/filipero/pokedex/assets/28496460/1570f99d-06c9-47c7-a70b-7bb2915806a9" width="300"> | <img src="https://github.com/filipero/pokedex/assets/28496460/30c9610e-a876-4c86-a7cb-d16317c308e4" width="300"> | <img src="https://github.com/filipero/pokedex/assets/28496460/003850c7-c9b2-4686-bed2-4dff7fb9463d" width="300"> |

### Dark Theme
| Video | Pokemon List | Details Screen | Filter Screen |
| ------------- | ------------- | ----------- | ----------- | 
| <img src="https://github.com/filipero/pokedex/assets/28496460/f4454bdf-98aa-4e3c-bc11-765012ead318" width="300"> | <img src="https://github.com/filipero/pokedex/assets/28496460/a42e60cc-2ed8-4c44-bbc2-24524ad3f4ab" width="300"> | <img src="https://github.com/filipero/pokedex/assets/28496460/783ff526-aeda-4b54-8ae2-491b9b280c71" width="300"> | <img src="https://github.com/filipero/pokedex/assets/28496460/dc49475e-a651-4e39-92f2-fcc90b6dcf89" width="300"> |


### Instalation

This project was made using **Xcode 14.0**, Swift and UIKit, XCodeGen and the following SPM Packages: 
- [NetworkManager](https://github.com/filipero/NetworkManager.git) - A simple Network Manager package I created. 
- [TinyConstraints](https://github.com/roberthein/TinyConstraints.git) - Used to define constraints in a simpler and less verbose way.
Ruby 3.0.0 or higher required

On the Project Root, run:

```$ make setup```

### Architecture
The Project was made utilizing MVVM and coordinators
  * Project
    * Modules
      * Module_1
        * Presentation
          * ViewController
          * ViewModel
          * View
        * Data
          * Model
          * Request
    * Navigation (Navigation stuff that doesn't really fit into any module)
    * Utils (Shared extensions and Components)

## Unit Testing

Unit tests were made using the default `XCTest` framework and contains usage of Depedency Injections and Dependency Inversion to use tecnhiques like **Stubs** and **Spys** to create mocks.
