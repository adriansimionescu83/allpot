# Allpot
AllPot is a Rails web app created in collaboration with my colleagues Salam Baalbaki and Shuja Khan during the last 2 weeks of Le Wagon bootcamp (https://www.lewagon.com).

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Contributing](#contributing)
- [License](#license)


## Installation
Project specs: 
-  ruby 3.2.0
-  node v16.20.0
-  rails 6.1.7.7

Once you cloned the repo locally make sure to run these commands in your terminal
```bash
  bundle install
  yarn install
  rails db:create
  rails db:migrate
```

## Usage
The purpose of the website is to help reduce food-waste by recommending recipes based on your available ingredients. 
To use it simply go to https://allpot.onrender.com, create a free account, add your available ingredients and then click on 'Cook Something'. 
Once you decide for a recipe you will see the recipes steps, if you have finished the recipe you can add it to the 'Cooked' list in case you liked it and want to try it again. 
You also have the option once you Cook a recipe to select the ingredients that are not in your pantry anymore and that you would like to add in your shopping list. 
When in store, you can mark the shopping list items as bought, and this will move those items back into your pantry. Cool right? You don't need to write the ingredients down every time. They are there always just in a different "bucket".
We also provide some nice info about each recipe like the time needed, number of persons or any dietary info if available on the original recipe. 
Hope you will enjoy it. 
Happy cooking!

## Features
The website uses an api integratio to spoonacular where it fetches the recipes based on the specified ingredients. Good to know that there is a daily limit that once reached will not allow the fetch of new recipes. 
