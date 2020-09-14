########################################################
# Step 1: Establish the layers

# layer one "rides" 
# layer two "driver ID"
# layer three "date"
# layer four "cost"
# layer five "rider ID"
# layer six "rating for the ride"

########################################################
# Step 2: Assign a data structure to each layer

# layer one "rides" 
#       an array with the number of the ride (organized by date) corresponding to the hash containing the info on the ride
# # layer two "driver ID"
#       driver id is a symbol with the id corresponding as a value pair String
# # layer three "date"
#           date is a symbol with a string for the date (may need to be changed to specify by month?)
# # layer four "cost"
#         cost is a symbol with an integer for the value pair
# # layer five "rider ID"
#         rider id is a symbol and value pair is a string for the id
# # layer six "rating for the ride"
#         rating is a key symbol and the actual rating is an integer

#######################################################
data = [
  {driver_id: "DR0004", date: "3rd Feb 2016", cost: 5, rider_id: "RD0022", rating: 5},
  {driver_id: "DR0001", date: "3rd Feb 2016", cost: 10, rider_id: 	"RD0003", rating: 3}, 
  {driver_id: "DR0002", date: "3rd Feb 2016", cost: 25, rider_id: "RD0073", rating: 5},
  {driver_id: "DR0001", date: "3rd Feb 2016", cost: 30, rider_id: "RD0015", rating: 4},
  {driver_id: "DR0003", date: "4th Feb 2016", cost: 5, rider_id: "RD0066", rating: 5},
  {driver_id: "DR0004", date: "4th Feb 2016", cost: 10, rider_id: "RD0022", rating: 4},
  {driver_id: "DR0002", date: "4th Feb 2016", cost: 15, rider_id: "RD0013", rating: 1}, 
  {driver_id: "DR0003", date: "5th Feb 2016", cost: 50, rider_id: "RD0003", rating: 2},
  {driver_id: "DR0002", date: "5th Feb 2016", cost: 35, rider_id: "RD0066", rating: 3}, 
  {driver_id: "DR0004", date: "5th Feb 2016", cost: 20, rider_id: "RD0073", rating: 5}, 
  {driver_id: "DR0001", date: "5th Feb 2016", cost: 45, rider_id: "RD0003", rating: 2}]

driver_ids = []
data.each do |hash|
  hash.each do |key, value|
    if key == :driver_id
      driver_ids << value
    end
  end
end 
driver_ids = driver_ids.uniq.sort

  #average ratings driver one = 3 driver two = 3 driver 3 = 3 driver_4 = 4
########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# Use an iteration blocks to print the following answers:
# - the number of rides each driver has given
# - the total amount of money each driver has made
# - the average rating for each driver
# - Which driver made the most money?
# - Which driver has the highest average rating?
def rides_per_driver(rides)
  dr_one_trips = 0
  dr_two_trips = 0
  dr_three_trips = 0
  dr_four_trips = 0
  
  rides.each do |hash|
    hash.each do |key, value|
      if value == "DR0001"
        dr_one_trips = dr_one_trips + 1
      elsif value == "DR0002"
        dr_two_trips = dr_two_trips + 1
      elsif value == "DR0003"
        dr_three_trips = dr_three_trips + 1
      elsif value == "DR0004"
        dr_four_trips = dr_four_trips + 1
      end
    end
  end
  
  driver_trips = [dr_one_trips, dr_two_trips, dr_three_trips, dr_four_trips]
  
  puts "Driver DR0001 drove #{dr_one_trips} trips"
  puts "Driver DR0002 drove #{dr_two_trips} trips"
  puts "Driver DR0003 drove #{dr_three_trips} trips"
  puts "Driver DR0004 drove #{dr_four_trips} trips"

  return driver_trips
end

driver_trips = rides_per_driver(data)

def total_money(rides, drivers)
  dr_one_money = 0 
  dr_two_money = 0
  dr_three_money = 0
  dr_four_money = 0
  money_totals = []
  
  rides.each do |hash|
    hash.each do |key, value|
      if value == drivers[0]
        dr_one_money = dr_one_money + hash.fetch(:cost)
      elsif value == drivers[1]
        dr_two_money = dr_two_money + hash.fetch(:cost)
      elsif value == drivers[2]
        dr_three_money = dr_three_money + hash.fetch(:cost)
      elsif value == drivers[3]
        dr_four_money = dr_four_money + hash.fetch(:cost)
      end
    end
  end
  
  money_totals = [{driver_id: drivers[0], total: dr_one_money}, {driver_id: drivers[1], total: dr_two_money}, {driver_id: drivers[2], total: dr_three_money}, {driver_id: drivers[3], total: dr_four_money}]
  
  puts "Driver DR0001 made a total of $#{dr_one_money}"
  puts "Driver DR0002 made a total of $#{dr_two_money}"
  puts "Driver DR0003 made a toal of $#{dr_three_money}"
  puts "Driver DR0004 made a total of $#{dr_four_money}"
  
  return money_totals
end

driver_money = total_money(data, driver_ids)

def rating_average(rides, driver_trips, drivers)
  dr_one_sum = 0
  dr_two_sum = 0
  dr_three_sum = 0
  dr_four_sum = 0
  
  driver_sums = []
 
  rides.each do |hash|
    hash.each do |key, value|
      if value == drivers[0]
        dr_one_sum += hash.fetch(:rating)
      elsif value == drivers[1]
        dr_two_sum += hash.fetch(:rating)
      elsif value == drivers[2]
        dr_three_sum += hash.fetch(:rating)
      elsif value == drivers[3]
        dr_four_sum += hash.fetch(:rating)
      end
    end
  end
  
  driver_sums = [dr_one_sum, dr_two_sum, dr_three_sum, dr_four_sum]
  driver_avgs = []
  i = 0
  driver_trips.each do 
    driver_avgs << driver_sums[i] / driver_trips[i]
    i = i + 1
  end
   
  driver_avg_hash = [{driver_id: drivers[0], avg: driver_avgs[0] }, {driver_id: drivers[1], avg: driver_avgs[1] }, {driver_id: drivers[2], avg: driver_avgs[2] }, {driver_id: drivers[3], avg: driver_avgs[3] }]

  4.times do |i|
    puts "Driver #{drivers[i]}'s rating average was #{driver_avgs[i]}"
  end

  return driver_avg_hash
end

avgs_rating = rating_average(data, driver_trips, driver_ids)

def max_money(totals)
  max_total = totals.max_by {  |k| k[:total] }[:total]
  max_driver = totals.max_by { |k| k[:total]}[:driver_id]

puts "The driver that made the most money was #{max_driver}. They made $#{max_total}" 
  
end

max_money(driver_money)

def max_rating_avg(rating)
  max_rating = rating.max_by {|k| k[:avg]}[:avg]
  max_driver = rating.max_by{|k| k[:avg]}[:driver_id]

  puts "The driver with the highest average rating was #{max_driver} with #{max_rating} out of 5 stars"
end

max_rating_avg(avgs_rating)
