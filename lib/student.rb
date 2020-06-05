require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade, :id
  
  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
      id INTEGER, 
      name TEXT, 
      grade INTEGER
      )
        SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
      SQL
    DB[:conn].execute(sql)
  end
  
  def save
    sql = <<-SQL
    INSERT INTO students (name, grade) VALUES (?, ?)
     SQL
    
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn}.execute(SELECT students last_insert_rowid())[0][0]
  end

end
