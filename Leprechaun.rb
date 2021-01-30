ul = "____________________________________________________________\n" # underline

print "\n"
5.times do
  print "*"
  sleep(0.05)
  print "$"
  sleep(0.05)
end
print " LEPRECHAUN "
sleep(0.05)
5.times do
  print "*"
  sleep(0.05)
  print "$"
  sleep(0.05)
end
print "\n          version 0.4b
             coded by Milo_Draco\n"
sleep(1)

loop do

print "
____________________________
 1. SIMPLE SYSTEM           |
 2. DELTA SYSTEM            |
 3. SMART ANALYSIS SYSTEM   |
 4. LEPRECHAUN SYSTEM       |
============================|
 5. CHECK RESULTS           |
 6. CHECK FILES             |
 7. DELETE STORED GAMES     |
 8. INSTRUCTIONS            |
============================'

Please, enter option: "
o = gets.chomp

if o == "1" # GENERATE NEW GAMES *****************************************************************

print "\nPlease, insert the lowest value: "
min = (gets.chomp).to_i

print "Please, insert the highest value: "
max = (gets.chomp).to_i

print "Please, insert and the total amount of sorted numbers: "
num = (gets.chomp).to_i

print "Please, insert and the total number of games: "
g = (gets.chomp).to_i

print "Please, insert and the numbers to avoid (separate by commas) or press ENTER: "
avoid = (gets.chomp).split(",")
for v in (0..avoid.length-1)
  avoid[v] = avoid[v].to_i
end

print "Please, insert and the numbers to include (separate by commas) or press ENTER: "
include = (gets.chomp).split(",")
for v in (0..include.length-1)
  include[v] = include[v].to_i
end

if File.file?('games.txt') # creating array of stored games
  print "Avoid stored games (Y/N): "
  cg = (gets.chomp).upcase
  if cg == "Y"
    games = []
    File.readlines('games.txt').each do |line|
      line = line[1..-2]
      array = line.split(",")
      (array.length).times do
        array << array[0].to_i
        array.shift
      end
    games << array
    end
  end
end

puts "\nMinimum = #{min}", "Maximum = #{max}", "Numbers = #{num}", "Avoid: #{avoid}", "Include: #{include}", "\n"
sleep(1)

pgames = [] # creating the array of avoided combinations from txt file:
if File.file?('avoid.txt')
  File.readlines('avoid.txt').each do |line|
    array = line.split("	")
    (array.length).times do
      array << array[0].to_i
      array.shift
    end
    pgames << array
  end
end

file = File.new("games.txt", 'a') # creating file of sorted games

c = 1 # game counter
allgames = []

while allgames.length < g do
  eq = false
  prem = [] + include
  x = prem.length # counter

  while x < num
    y = rand(min..max) # sorted value
    if !prem.include?(y) && !avoid.include?(y)
      prem << y
      x += 1
    end
  end
  
  prem.sort!
  
  for z in (0..allgames.length-1) # checking if the game is duplicated
    eq = true if prem == allgames[z]
    break if eq == true
  end
  redo if eq == true

  for a in (0..pgames.length-1) # checking avoid.txt duplicates
    eq = true if prem == pgames[a]
    break if eq == true
  end
  redo if eq == true

  if games != nil
    for a in (0..games.length-1) # checking games.txt duplicates
      eq = true if prem == games[a]
      break if eq == true
    end
  end
  redo if eq == true

  allgames << prem
  
  puts "Game ##{c}"
  print prem, "\n \n"
  file.write(prem, "\n")
  c += 1
end

file.close
puts "\nAll games created successfully and written to file <<games.txt>>\n\n"
sleep (5)
puts ul

elsif o == "5" # CHECK RESULTS *************************************************************************

print "\nPlease, insert the numbers (separate by commas): "
game = (gets.chomp).split(",")
(game.length).times do
  game << game[0].to_i
  game.shift  
end

if File.file?('games.txt')
  games = []
  File.readlines('games.txt').each do |line|
    line = line[1..-2]
    array = line.split(",")
    (array.length).times do
      array << array[0].to_i
      array.shift
    end
  games << array
  end
else
  print "\nERROR: there is no <<games.txt>> file!\n\n"
  exit
end

win = [0, 0, 0, 0]
nwin = [[], [], [], []]
ng = 0
games.each do |gx| # comparing games
  w = 0
  ng += 1
  game.each do |n|
    w += 1 if gx.include?(n)
  end
  if w == game.length
    win[0] += 1
    nwin[0] << ng
  elsif w == game.length-1
    win[1] += 1
    nwin[1] << ng
  elsif w == game.length-2
    win[2] += 1
    nwin[2] << ng
  elsif w == game.length-3
    win[3] += 1
    nwin[3] << ng
  end
end

puts "\n#{win[0]} game(s) matching #{game.length} number(s): #{nwin[0]}

#{win[1]} game(s) matching #{game.length-1} number(s): #{nwin[1]}

#{win[2]} game(s) matching #{game.length-2} number(s): #{nwin[2]}

#{win[3]} game(s) matching #{game.length-3} number(s): #{nwin[3]}\n\n"

sleep (5)
puts ul

elsif o == "6" # CHECK FILES *********************************************************************

if File.file?('games.txt') # creating array of stored games
    games = []
    File.readlines('games.txt').each do |line|
      line = line[1..-2]
      array = line.split(",")
      (array.length).times do
        array << array[0].to_i
        array.shift
      end
    games << array
    end
  end

if File.file?('avoid.txt') # creating the array of avoided combinations from txt file:
  pgames = []
  File.readlines('avoid.txt').each do |line|
    array = line.split("	")
    (array.length).times do
      array << array[0].to_i
      array.shift
    end
    pgames << array
  end
end

puts "\nStored games (<<games.txt>>) = #{games.length}" if games != nil
puts "\nAvoided or PD (<<avoid.txt>>) = #{pgames.length}" if pgames != nil
print "\n"

sleep (2)
puts ul

elsif o == "7" # DELETE GAMES *********************************************************************

if File.exists?('games.txt')
  print "\nAre you sure? (Y/N) "
  del = (gets.chomp).upcase
  File.delete('games.txt') if del=="Y"
else
  puts "\nERROR: there is no <<games.txt>> file."
  exit
end
puts ul

elsif o == "8" # INSTRUCTIONS *******************************************************************************

puts "\nRandom numbers are between minimum and maximum values.
All the games are stored in a TXT file (<<games.txt>>).
You can insert avoided games in a TXT file, just insert one combination per
line and separate numbers using TAB. Name the file <<avoid.txt>>.
Check if you have won using option 2.

SIMPLE SYSTEM: no file required. All kind of games suported. You
    can avoid or include specific numbers.
DELTA SYSTEM: no file required. Only games up to 8 numbers.
SMART ANALYSIS SYSTEM: 5 or more past drawnings required (in the
    <<avoid.txt>>). All kind of games suported.
LEPRECHAUN SYSTEM: 5 or more past drawnings required and only games
    up to 8 numbers. It's the slowest system.

Files:
    <<avoid.txt>> => list of combinations to avoid or past drawnings (recent
        drawnings should be the last).
    <<games.txt>> => list of saved games.\n\n"

sleep (5)
puts ul

elsif o == "3" # SMART ANALYSIS SYSTEM ******************************************************************

print "\nPlease, insert the lowest value: "
min = (gets.chomp).to_i

print "Please, insert the highest value: "
max = (gets.chomp).to_i

print "Please, insert and the total amount of sorted numbers: "
num = (gets.chomp).to_i

print "Please, insert and the total number of games: "
g = (gets.chomp).to_i

games = nil # creating array of stored games
if File.file?('games.txt')
  print "Avoid stored games (Y/N): "
  cg = (gets.chomp).upcase
  if cg == "Y"
    games = []
    File.readlines('games.txt').each do |line|
      line = line[1..-2]
      array = line.split(",")
      (array.length).times do
        array << array[0].to_i
        array.shift
      end
    games << array
    end
  end
end

pgames = [] # creating the array of avoided combinations from txt file:
if File.file?('avoid.txt')
  File.readlines('avoid.txt').each do |line|
    array = line.split("	")
    (array.length).times do
      array << array[0].to_i
      array.shift
    end
    pgames << array
  end
  else
  puts "\nERROR: past drawnings required!\n"
  exit
end

if pgames.length < 5
  puts "\nERROR: at least 5 past drawnings required!\n"
  exit
end

puts "\nMinimum = #{min}", "Maximum = #{max}", "Numbers = #{num}", "Past drawnings = #{pgames.length}"

chances = {} # counting times of each number
chances.default = 0
for x in (min..max)
  pgames.each do |y|
    chances[x] += 1 if y.include?(x)
  end
end

puts "PD range = #{chances.keys[0]} - #{chances.keys[-1]}", "\n"
if chances.length < max
  puts "ERROR: past drawnings must include wider range of values!\n\n"
  exit
end
sleep(1)

mod = [10, 20, 30, 40, 50] # modifiers
(chances.keys).each do |mx| # aplying chances according to the last 5 games
  mult = 100.0 # multiplier
  if pgames[-5].include?(mx)
    mult -= mod[0]
  else
    mult += mod[0]
  end
  if pgames[-4].include?(mx)
    mult -= mod[1]
  else
    mult += mod[1]
  end
  if pgames[-3].include?(mx)
    mult -= mod[2]
  else
    mult += mod[2]
  end
  if pgames[-2].include?(mx)
    mult -= mod[3]
  else
    mult += mod[3]
  end
  if pgames[-1].include?(mx) # most recent result/game
    mult -= mod[4]
  else
    mult += mod[4]
  end
  chances[mx] = (chances[mx] * (mult/100)).round(0)
  chances[mx] = 1 if chances[mx] < 1
end

total = 0 # total numbers in avoid.txt file
(chances.values).each do |z|
  total = total + z
end

startx = 0 # starting point for each value in dice
dice = {} # dice for random number

for n in (min..max)
  dice[n] = [startx, startx + chances[n]] # starting point and last point for each number between min and max
  startx += chances[n]
end

c = 1 # game counter
rn = nil # random number
file = File.new("games.txt", 'a') # creating file of sorted games
allgames = []
while allgames.length < g do
  eq = false
  prem = []
  num.times do
    rn = rand(1..dice.values[-1][1])
    rnf=nil # random number final
    (dice.keys).each do |xxx|
      rnf = xxx if rn > dice[xxx][0] && rn <= dice[xxx][1]
      break if rnf != nil
    end
    redo if prem.include?(rnf)
    prem << rnf
  end
  prem.sort!
  
  for z in (0..allgames.length-1) # checking if the game is duplicated
    eq = true if prem == allgames[z]
    break if eq == true
  end
  redo if eq == true

  for a in (0..pgames.length-1) # checking avoid.txt duplicates
    eq = true if prem == pgames[a]
    break if eq == true
  end
  redo if eq == true

  if games != nil
    for a in (0..games.length-1) # checking games.txt duplicates
      eq = true if prem == games[a]
      break if eq == true
    end
  end
  redo if eq == true

  allgames << prem

  puts "Game ##{c}"
  print prem, "\n \n"
  file.write(prem, "\n")
  c += 1
end

file.close
puts "\nAll games created successfully and written to file <<games.txt>>\n\n"
 
#print "__________________________________________
#
#values = ", chances.keys, "\n\n", "chances = ", chances, "\n\n", "sum = ", total, "\n\n", "table = ", dice, "\n\n"

sleep (5)
puts ul

elsif o == "2" # DELTA SYSTEM *********************************************************************************

print "\nPlease, insert the lowest value: "
min = (gets.chomp).to_i

print "Please, insert the highest value: "
max = (gets.chomp).to_i

print "Please, insert and the total amount of sorted numbers: "
num = (gets.chomp).to_i

if num > 8
  puts "\nERROR: maximum value is 8!\n"
  exit
end

print "Please, insert and the total number of games: "
g = (gets.chomp).to_i

games = nil # creating array of stored games
if File.file?('games.txt')
  print "Avoid stored games (Y/N): "
  cg = (gets.chomp).upcase
  print "\n"
  if cg == "Y"
    games = []
    File.readlines('games.txt').each do |line|
      line = line[1..-2]
      array = line.split(",")
      (array.length).times do
        array << array[0].to_i
        array.shift
      end
    games << array
    end
  end
end

pgames = [] # creating the array of avoided combinations from txt file:
File.readlines('avoid.txt').each do |line|
  array = line.split("	")
  (array.length).times do
    array << array[0].to_i
    array.shift
  end
  pgames << array
end

puts "Minimum = #{min}", "Maximum = #{max}", "Numbers = #{num}", "\n"
sleep(1)

file = File.new("games.txt", 'a') # creating file of sorted games

c = 1 # game counter
allgames = []
tsd = (max/6).round(0) # threshold

while allgames.length < g do
  eq = false
  delta = []

  delta << rand(min..(max/10.0).round(0))
  delta << rand(tsd-1..tsd+1) if num > 1

  rest = num - delta.length

  (rest/2).times do
    if min > 0
      delta << rand(min..tsd)
    else
      delta << rand(1..tsd)
    end
  end

  (rest/2).times do
    delta << rand(tsd..((max/10.0).round(0))*3)
  end
 
  sum = 0
  delta.each do |dx|
    sum += dx
  end

  (rest%2).times do
    if min > 0
      vy = rand(min..max-sum)
      vy = min if vy == nil || vy < min
    else
      vy = rand(1..max-sum)
      vy = 1 if vy == nil || vy < min
    end
    delta << vy
  end

  sum = 0
  delta.each do |dx|
    sum += dx
  end

  if sum > max
    delta << delta.max - (sum - max) - rand(0..max/10)
    delta.delete(delta.max)
  end

  redo if delta.min < min || delta.count(0) > 1 || delta.length != num # redo if minimum is below MIN or if there is more than one 0

  delta.shuffle!
  if delta.include?(0)
    delta.delete(0)
    delta.unshift(0)
  end

  prem = []
  sum = 0
  delta.each do |dx|
    sum += dx
    prem << sum
  end

  prem.sort!

  for z in (0..allgames.length-1) # checking if the game is duplicated
    eq = true if prem == allgames[z]
    break if eq == true
  end
  redo if eq == true

  for a in (0..pgames.length-1) # checking avoid.txt duplicates
    eq = true if prem == pgames[a]
    break if eq == true
  end
  redo if eq == true

  if games != nil
    for a in (0..games.length-1) # checking games.txt duplicates
      eq = true if prem == games[a]
      break if eq == true
    end
  end
  redo if eq == true

  allgames << prem
  
  puts "Game ##{c}"
  print prem, "\n \n"
  file.write(prem, "\n")
  c += 1
end

file.close
puts "\nAll games created successfully and written to file <<games.txt>>\n\n"

sleep (5)
puts ul

elsif o.upcase == "EXIT" # EXIT **************************************************************

exit

elsif o == "4" # LEPRECHAUN SYSTEM **************************************************************

print "\nPlease, insert the lowest value: "
min = (gets.chomp).to_i

print "Please, insert the highest value: "
max = (gets.chomp).to_i

print "Please, insert and the total amount of sorted numbers: "
num = (gets.chomp).to_i

if num > 8
  puts "\nERROR: maximum value is 8!\n"
  exit
end

print "Please, insert and the total number of games: "
g = (gets.chomp).to_i

games = nil # creating array of stored games
if File.file?('games.txt')
  print "Avoid stored games (Y/N): "
  cg = (gets.chomp).upcase
  if cg == "Y"
    games = []
    File.readlines('games.txt').each do |line|
      line = line[1..-2]
      array = line.split(",")
      (array.length).times do
        array << array[0].to_i
        array.shift
      end
    games << array
    end
  end
end

if g > 2000
  print "Enable cooling down CPU (Y/N): "
  cd = (gets.chomp).upcase
end

pgames = [] # creating the array of avoided combinations from txt file:
if File.file?('avoid.txt')
  File.readlines('avoid.txt').each do |line|
    array = line.split("	")
    (array.length).times do
      array << array[0].to_i
      array.shift
    end
    pgames << array
  end
  else
  puts "\nERROR: past drawnings required!\n"
  exit
end

if pgames.length < 5
  puts "\nERROR: at least 5 past drawnings required!\n"
  exit
end

puts "\nMinimum = #{min}", "Maximum = #{max}", "Numbers = #{num}", "Past drawnings = #{pgames.length}"

chances = {} # counting times of each number
chances.default = 0
for x in (min..max)
  pgames.each do |y|
    chances[x] += 1 if y.include?(x)
  end
end

puts "PD range = #{chances.keys[0]} - #{chances.keys[-1]}", "\n"

if chances.length < max
  puts "ERROR: past drawnings must include wider range of values!\n\n"
  exit
end

sleep(1)

mod = [10, 20, 30, 40, 50] # modifiers
(chances.keys).each do |mx| # aplying chances according to the last 5 games
  mult = 100.0 # multiplier
  if pgames[-5].include?(mx)
    mult -= mod[0]
  else
    mult += mod[0]
  end
  if pgames[-4].include?(mx)
    mult -= mod[1]
  else
    mult += mod[1]
  end
  if pgames[-3].include?(mx)
    mult -= mod[2]
  else
    mult += mod[2]
  end
  if pgames[-2].include?(mx)
    mult -= mod[3]
  else
    mult += mod[3]
  end
  if pgames[-1].include?(mx) # most recent result/game
    mult -= mod[4]
  else
    mult += mod[4]
  end
  chances[mx] = (chances[mx] * (mult/100))
end

puts "Please, wait. This can take several minutes."

t = Time.now if cd == "Y" # initial time 
scores = {} # summing scores of each game
tsd = (max/6).round(0) # threshold
slp = 20 # time of cooling down
len = 0 # counter

while scores.length < g*2 do # creating the double of needed games
  eq = false
  delta = []
  delta << rand(min..(max/10.0).round(0)) # drawning 1st number
  delta << rand(tsd-1..tsd+1) if num > 1 # drawning 2nd number
  rest = num - delta.length # calculating left numbers

  (rest/2).times do # drawning half of left numbers (below threshold)
    if min > 0
      delta << rand(min..tsd)
    else
      delta << rand(1..tsd)
    end
  end

  (rest/2).times do  # drawning half of left numbers (above threshold)
    delta << rand(tsd..((max/10.0).round(0))*3)
  end
 
  sum = 0
  delta.each do |dx| # summing all numbers
    sum += dx
  end

  (rest%2).times do # drawning last number if NUM is odd
    if min > 0
      vy = rand(min..max-sum)
      vy = min if vy == nil || vy < min
    else
      vy = rand(1..max-sum)
      vy = 1 if vy == nil || vy < min
    end
    delta << vy
  end

  sum = 0
  delta.each do |dx|
    sum += dx
  end

  if sum > max # sum must be less or equal to maximum number
    delta << delta.max - (sum - max) - rand(0..max/10)
    delta.delete(delta.max)
  end

  redo if delta.min < min || delta.count(0) > 1 || delta.length != num # redo if minimum is below MIN or if there is more than one 0

  delta.shuffle!
  if delta.include?(0) # 0 must be the first
    delta.delete(0)
    delta.unshift(0)
  end

  prem = []
  sum = 0
  delta.each do |dx|
    sum += dx
    prem << sum
  end

  prem.sort!

  for z in (0..(scores.values).length-1) # checking if the game is duplicated
    eq = true if prem == scores.values[z]
    break if eq == true
  end
  redo if eq == true

  for a in (0..pgames.length-1) # checking avoid.txt duplicates
    eq = true if prem == pgames[a]
    break if eq == true
  end
  redo if eq == true

  if games != nil
    for a in (0..games.length-1) # checking games.txt duplicates
      eq = true if prem == games[a]
      break if eq == true
    end
  end
  redo if eq == true

  scr = 0
  prem.each do |e|
    scr += chances[e] 
  end

  scores[scr] = prem
  if scores.length/2 > len
    print scores.length/2, "/"
    len = scores.length/2
  end
  
  if cd == "Y" # CPU cooler
    if Time.now >= t + 300
      print "cooling down/"
      sleep(slp)
      t = Time.now
      slp += 1
    end
  end
end

scores = scores.sort
scores.shift(scores.length/2)

c = 1 # game counter
allgames = []
file = File.new("games.txt", 'a') # creating file of sorted games
puts "\n\n"

scores.each do |gm|
  allgames << gm[1]
  puts "Game ##{c}"
  print gm[1], "\n \n"
  file.write(gm[1], "\n")
  c += 1
end
file.close

puts "\nAll games created successfully and written to file <<games.txt>>\n\n"

sleep (5)
puts ul

else

puts "\nERROR: invalid option!\n"
exit

end
end # end of loop
