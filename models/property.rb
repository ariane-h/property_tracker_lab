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

end
