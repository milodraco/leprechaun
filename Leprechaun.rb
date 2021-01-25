print "\n*$#*$#*$#* LEPRECHAUN *$#*$#*$#*
          version 0.3b
             coded by Milo_Draco

____________________________
 1. GENERATE NEW GAMES      |
 2. CHECK RESULTS           |
 3. DELETE STORED GAMES     |
 4. INSTRUCTIONS            |
============================

Please, enter option: "
o = gets.chomp

if o=="1" # GENERATE NEW GAMES

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
  print "\nAvoid stored games (Y/N): "
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

c = 1 # game counter
allgames = []

puts "\nMinimum = #{min}", "Maximum = #{max}", "Numbers = #{num}", "Avoid: #{avoid}", "Include: #{include}", "\n"

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

elsif o=="2" # CHECK RESULTS

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
  print "\nThere is no <<games.txt>> file.\n\n"
  exit
end

win = [0,0,0,0]
nwin = [[],[],[],[]]
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

elsif o=="3" # DELETE GAMES

if File.exists?('games.txt')
  print "\nAre you sure? (Y/N) "
  del = (gets.chomp).upcase
  File.delete('games.txt') if del=="Y"
else
  puts "\nThere's no <<games.txt>> file."
end
print "\n"

elsif o=="4" # INSTRUCTIONS

puts "\nRandom numbers are between minimum and maximum values.
All the games are stored in a TXT file (<<games.txt>>).
You can put avoided games in a TXT file, just insert one combination per
line and separate numbers using TAB. Name the file <<avoid.txt>>.
Check if you have won using option 2.
<<avoid.txt>> => list of combinations to avoid.
<<games.txt>> => list of stored games.\n\n"
sleep(5)

elsif o.upcase=="SSS"

puts "\nSECRET SMART SYSTEM\n"

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

chances = {} # counting times of each number
chances.default = 0
for x in (min..max)
  pgames.each do |y|
    chances[x] += 1 if y.include?(x)
  end
end

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
 
print "__________________________________________

values = ", chances.keys, "\n\n", "chances = ", chances, "\n\n", "sum = ", total, "\n\n", "table = ", dice, "\n\n"

end
