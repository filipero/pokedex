.DEFAULT_GOAL := help
XCODE_DERIVEDDATA=./DerivedData
BUNDLE=$(if $(rbenv > /dev/null), rbenv exec bundle, bundle)

install:
	make install_bundle

generate:
	xcodegen

generate_open:
	xcodegen && open Pokedex.xcodeproj

setup:
	brew install xcodegen
	brew install asdf
	
	asdf plugin add ruby
	asdf install ruby 3.1.4
	asdf local ruby 3.1.4
	
	gem install bundler

	$(BUNDLE) install
	$(BUNDLE) update --all

	xcodegen
	open Pokedex.xcodeproj

install_bundle:
	$(BUNDLE) install
	$(BUNDLE) update --all

deintegrate:
	rm -rf Pokedex.xcodeproj && rm -rf ${XCODE_DERIVEDDATA}

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
