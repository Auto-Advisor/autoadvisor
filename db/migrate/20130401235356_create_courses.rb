class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.integer :number
      t.string :name
      t.string :dept
    end

    change_table :sections do |t|
      t.references :course
    end

    Section.find(:all).each do |section|
      course = Course.where('number == (?) AND dept == (?)', section.class_number, section.dept).first
      if course.nil?
        course = Course.new
        course.number = section.class_number
        course.dept = section.dept
        course.name = section.name
        course.save
      end
      section.course = course
      section.save
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
