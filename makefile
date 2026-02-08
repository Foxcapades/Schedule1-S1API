VERSION := $(shell grep -Eo '<Version>(.+)</Version>' S1API/S1API.csproj | sed 's/<Version>\(.\+\)<\/Version>/\1/')
.ONESHELL:

.PHONY: default
default:
	@echo "No"

.PHONY: release
release: S1API-RC-$(VERSION).zip

S1API-RC-$(VERSION).zip: S1API/bin/Il2CppMelon/net6.0/S1API.dll S1API/bin/MonoMelon/netstandard2.1/S1API.dll S1APILoader/bin/MonoMelon/netstandard2.1/S1APILoader.dll
	@set -ex
	mkdir -p release/Mods release/Plugins
	cp S1API/bin/Il2CppMelon/net6.0/S1API.dll release/Mods/S1API.Il2Cpp.MelonLoader.dll
	cp S1API/bin/MonoMelon/netstandard2.1/S1API.dll release/Mods/S1API.Mono.MelonLoader.dll
	cp S1APILoader/bin/MonoMelon/netstandard2.1/S1APILoader.dll release/Plugins/S1APILoader.MelonLoader.dll
	cd release
	zip -r9 release.zip Mods Plugins
	mv release.zip ../$@
	rm -rf $$PWD
