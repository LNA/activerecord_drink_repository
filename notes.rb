#Put specs in proper order

# Draw diagrams 

# Drinks is the current in memorory persistance layer.  Needs to be replaced with SQLite & AR
# Drink is the object layer; replace w ActiveRecord????


# Need to make sure that the tests know about the database.  Don't need to make new tests
# Might need to tell specs to use SQL and AR.
# Write a configuration for AR to use SQLite3
# Use AR objects in place of the drink objects

# 3 configurations:
# => Telling AR to use SQLite3 and how to do it.  what adapter to use
# => Telling SQLite3 what tables and colums it has
# => Register the AR datastores with the Repository interface/pointer.