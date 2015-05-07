all:
	elm-make *.elm

docker:
	docker build -t srid/elm-laundrycoins .
