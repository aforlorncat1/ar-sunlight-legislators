require_relative '../../db/config'

class Legislator < ActiveRecord::Base
	#uses values in :title as the inheritance model. The created subclasses must have the same name as the ones in :title
	#i.e. Rep instead of Representative. 
	self.inheritance_column = :title

	def self.state_search(state)
		list = self.where(state:state).order(:lastname)
		list.each do |x|
			p "#{x.title}. #{x.firstname} #{x.middlename} #{x.lastname} (#{x.party})"
		end
	end

	def self.gender_perc(gender)
		gender_total = self.where(gender:gender, in_office: 1).count.to_i
		total = self.where(in_office: 1).count.to_f
		perc = (gender_total/ total * 100).round(2)
			p "#{gender_total} (#{perc}%)"
	end

	def self.active_statesmen
		total_active = self.where(in_office: 1).group(:state).count
		
		# total_active.each do |x|
		# 	print x
			#p "#{x.title}. #{x.firstname} #{x.middlename} #{x.lastname} (#{x.state} (#{x.in_office})"
		
	end

	def self.total_persons
		total = self.count
	end

	def self.delete_inactive
		id_arr = []
		delete_arr = self.where(in_office:0)
		p delete_arr.count
		delete_arr.each do |x|
			id_arr << x.id
		end
		p id_arr
		
	end
end

