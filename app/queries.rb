#require_relative '../config'
require_relative 'models/legislator'
require_relative 'models/representative'
require_relative 'models/senator'

class Main
#representative query for state
	def self.state_reps
		print "Enter a state: "
		state = gets.chomp.upcase

		p "Representatives"
				Rep.state_search(state)
		p "-------------------------------------------------------------------------------------"
		p "Senators"
				Sen.state_search(state)
	end	
#gender percentage query
	def self.gen_perc
		print "Enter a gender: "
		gender = gets.chomp.upcase

			if gender == "M"
				@a = "Male"
			else
				@a = "Female"
			end

		p "#{@a} Representatives"
			Rep.gender_perc(gender)

		p "-------------------------------------------------------------------------------------"
		p "#{@a} Senators"
			Sen.gender_perc(gender)
	end

#active statesmen query
	def self.activemen
		state = Legislator.group(:state).order("count_title desc").count("title")

			state.each do |k|
			b = Legislator.where("state = ?",k).group(:title).count(:title)
		end
			p "#{k}: #{b["Sen"]} Senators, #{b["Rep"]} Representative(s)"
		# SELECT state, COUNT title FROM legislator
		# WHERE :in_office = 1
		# ORDER BY (count?) title desc
	end


# 4.
	def self.total_reps
		puts "Representatives: #{Rep.total_persons}"

		puts "Senators: #{Sen.total_persons}"
	end


#5.
	def self.destroy_inactive
		Legislator.destroy_all(in_office:0)
		puts "Representatives: #{Rep.total_persons}"
		puts "Senators: #{Sen.total_persons}"
	end
end

#Main.state_reps
#Main.gen_perc
#Main.total_reps
Main.activemen


