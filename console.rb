require('pry-byebug')
require_relative('models/property.rb')

Property.delete_all

property1 = Property.new({'address' => '1 Morrison Street', 'value' => 200000, 'year_built' => 1901, 'for_sale' => true})
property2 = Property.new({'address' => '3 Miller Place', 'value' => 350000, 'year_built' => 1889, 'for_sale' => true})
property3 = Property.new({'address' => '49 Buccleuch Street', 'value' => 160000, 'year_built' => 1980, 'for_sale' => false})

property1.save
property2.save
property3.save

property3.address = "56 Buccleuch Street"
property3.update
