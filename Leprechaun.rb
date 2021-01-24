puts "\nLEPRECHAUN 0.2b
coded by Milo_Draco \n \n"

puts Time.now, "\n"

print "--------------------

1. GENERATE NEW GAMES
2. CHECK RESULTS
3. DELETE STORED GAMES
4. INSTRUCTIONS

Please, enter option: "
o = gets.chomp

if o=="1" # GENERATE NEW GAMES

print "\nPlease, insert the lowest value: "
min = (gets.chomp).to_i

print "\nPlease, insert the highest value: "
max = (gets.chomp).to_i

print "\nPlease, insert and the total amount of sorted numbers: "
num = (gets.chomp).to_i

print "\nPlease, insert and the total number of games: "
g = (gets.chomp).to_i

print "\nPlease, insert and the numbers to avoid (separate by commas) or press ENTER: "
avoid = (gets.chomp).split(",")
for v in (0..avoid.length-1)
  avoid[v] = avoid[v].to_i
end

print "\nPlease, insert and the numbers to include (separate by commas) or press ENTER: "
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

puts "\nIf you would like to avoid specific games, put them in a file named <<avoid.txt>>"
sleep(2)

c = 1 # game counter
allgames = []

puts "\nMinimum = #{min}", "Maximum = #{max}", "Numbers = #{num}", "Avoid: #{avoid}", "Include: #{include}", "\n"

# creating the array of avoid combinations from txt file:
pgames = []
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

file = File.new("games.txt", 'a')

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
  if w==game.length
    win[0] += 1
    nwin[0] << ng
  elsif w==game.length-1
    win[1] += 1
    nwin[1] << ng
  elsif w==game.length-2
    win[2] += 1
    nwin[2] << ng
  elsif w==game.length-3
    win[3] += 1
    nwin[3] << ng
  end
end

puts "\n#{win[0]} game(s) matching #{game.length} number(s): #{nwin[0]}

#{win[1]} game(s) matching #{game.length-1} number(s): #{nwin[1]}

#{win[2]} game(s) matching #{game.length-2} number(s): #{nwin[2]}

#{win[3]} game(s) matching #{game.length-3} number(s): #{nwin[3]}\n\n"

elsif o=="3" # DELETE GAMES

print "\nAre you sure? (Y/N) "
del = (gets.chomp).upcase
File.delete('games.txt') if File.exists? 'games.txt' if del=="Y"
print "\n"

elsif o=="4" # INSTRUCTIONS

puts "\nRandom numbers are between minimum and maximum values.
You can generate up to 300 games at once.
All the games are stored in a TXT file (<<games.txt>>).
You can put avoided games in a TXT file, just insert one combination per
line and separate numbers using TAB. Name the file <<avoid.txt>>.
Check if you have won using option 2.\n\n"
sleep(5)
end
