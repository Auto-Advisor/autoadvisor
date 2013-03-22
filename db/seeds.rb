# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cmpsci = Major.create(:degree => "B.Sc", :dept => "CMPSCI", :name => "Computer Science")

time = TimeSlot.create(:beg_hour => 16, :beg_min => 0, :end_hour => 17, :end_min => 15, :days => "TuTh")

section = Section.create(:class_number => 320,
												 :class_string => "CMPSCI320",
												 :dept => "CMPSCI",
												 :description => nil,
												 :instructor => "Yuriy Brun",
												 :name => "Software Engineering",
												 :primary => true,
												 :section_number => "01",
												 :size => 40,
												 :spire_id => 13680,
												 :time_slot => time)

admin = User.new(:email => "autoadvisoraws@gmail.com", :password => "password", :password_confirmation => "password")
admin.admin = true
admin.confirmed_at = DateTime.now
admin.majors << cmpsci
admin.credits << Credit.create(:dept => "CMPSCI",
															 :gpa => 2.65,
															 :name => "Software Engineering",
															 :number => "320",
															 :year => "2010")
admin.save
