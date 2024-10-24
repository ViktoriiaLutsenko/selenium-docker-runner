@echo off

REM Start the grid with 2 chrome containers
docker-compose -f grid.yaml up --scale chrome=2 -d

REM Run test suites with chrome
set BROWSER=chrome
docker-compose -f selenium.yaml up

REM Stop chrome and run firefox containers
docker-compose -f grid.yaml up --scale firefox=2 -d

REM Run test suites with firefox
set BROWSER=firefox
docker-compose -f selenium.yaml up

REM Bring down all
docker-compose -f grid.yaml down
docker-compose -f selenium.yaml down