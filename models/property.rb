require('pg')

class Property

attr_accessor :address, :value, :year_built, :for_sale
attr_reader :id

  def initialize ( properties )
    @id = properties['id'].to_i if properties['id']
    @address = properties['address']
    @value = properties['value'].to_i
    @year_built = properties['year_built'].to_i
    @for_sale = properties['for_sale']
  end

  def save
    db = PG.connect( {dbname:'property_agency', host: 'localhost'} )
    sql = "INSERT INTO properties (address, value, year_built, for_sale)
          VALUES ($1, $2, $3, $4) RETURNING *"
    values = [@address, @value, @year_built, @for_sale]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close
  end

  def delete
    db = PG.connect( {dbname: 'property_agency', host: 'localhost'} )
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close
  end

  def update
    db = PG.connect( {dbname: 'property_agency', host: 'localhost'} )
    sql = "UPDATE properties SET ( address,
                                  value,
                                  year_built,
                                  for_sale)
                              = ($1, $2, $3, $4)
                              WHERE id = $5"
    values = [@address, @value, @year_built, @for_sale, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def Property.delete_all
    db = PG.connect( {dbname: 'property_agency', host: 'localhost'} )
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close
  end

end
