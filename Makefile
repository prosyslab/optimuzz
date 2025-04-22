all:
	npx @tailwindcss/cli -i themes/blank/assets/css/style.css -o themes/blank/static/css/style.css
	hugo -d docs

dev:
	npx @tailwindcss/cli -i themes/blank/assets/css/style.css -o themes/blank/static/css/style.css
	hugo serve

.PHONY: all dev