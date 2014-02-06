#This program simulate a blackjack game, users be players and computer be dealer.
#Every card in the deck has an own number, club A is 0, club 2 is 1, diamond A is 13, spade K is 51 etc.
#When we have to print the card, we have card_to_string function to tell user what card it is.

require "pry"

#Global variable: Here is some variable we can edit to set
#USED_DECK_COUNT: To prevent against card counting players, we use multi decks, and you can set how many decks you want to use.

USED_DECK_COUNT = 3

#say:
#The program simulate a dealer, and every message from this program will call this function.
def say msg
	puts "@Dealer: #{msg}"
end

#result_declare:
#The program will declare game result for every player. Message is depend on the result.
def result_declare (name, result)
	say "Great, #{name}! You win this game!" if result == "win"
	say "Oops, sorry, #{name}. You lose this game." if result == "lose"
	say "#{name}, we draw. :)" if result == "draw"
end

#shuffle:
#This function will return an array that simulate deck which has been shuffled.
def shuffle
	shuffle_cards = []

	USED_DECK_COUNT.times do |x|
		i = 52
		original_cards = Array.new(52) {|index| index}
		until original_cards.empty?
			taking_num = rand(i)
			shuffle_cards.push(original_cards[taking_num])
			original_cards.delete_at(taking_num)
			i = i - 1
		end
	end
	return shuffle_cards
end

#pick_card:
#This function will pick a card from the deck in random and return the card number. Hmmm...so we have shuffled twice.
def pick_card deck
	taking_num = rand(deck.count)
	return_value = deck[taking_num]
	deck.delete_at(taking_num)
	return return_value
end

#cards_to_point:
#This function is count how many points is the cards in players hand.
#It will count the max possible number(If A can be 11, it will be.), but don't be busted if it can.
def cards_to_point cards
	
	point = 0
	cards_num = []

	cards.each { |card| cards_num.push(card % 13) }

	cards_num.sort.reverse.each do |num|
		if num >= 9
			point = point + 10
		elsif num > 0
			point = point + num + 1
		end
	end

	a_count = cards_num.count(0)

	point  = point + a_count

	a_count.times do
		point = point + 10 if point <= 11
	end

	return point
end

#card_to_string:
#Turn a number to string which is its real color and number.
#From 0 to 51, it means club 1, club 2, club 3, ... spade K.
def card_to_string card
	colors = ["club", "diamond", "heart", "spade"]
	numbers = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
	return colors[card / 13] + numbers[card % 13]
end

#cards_in_hand_to_string:
#input: an array of number
#output: a string which means which cards are they.
def cards_in_hand_to_string cards
	card_strings = []
	cards.each do |card|
		card_strings.push(card_to_string(card))
	end
	return card_strings.join(", ")
end


#main program:
#Here is the steps:
#1. shuffle, then we have a deck
#2. ask how many players, then ask their name. If any two of players name is conflict, the programe will warning and shut down.
#3. Deal two cards to every user then to dealer.
#4. Every player's turn, he/she should decide hit or stay. The turn will be end when he/she decide to stay, be busted or BLACKJACK.
#5. When players finish, dealer play its turn. This turn will end when its point is bigger than 17.
#6. Judge victory or defeat for every player, the shut down.


deck = shuffle

dealer_cards = []
players_name = []
players_cards = {}

say "How many players want join this game?"
players_count = gets.chomp.to_i

players_count.times do |x|
	
	player_num = x + 1
	say "Please type player" + player_num.to_s + "'s name:"
	input_name = gets.chomp
	
	if players_name.find_index(input_name)
		puts "Sorry, the name is repeated, please check and run this program one more time;)"
		exit
	end
	
	players_name.push(input_name)
	players_cards[input_name] = []
	card = pick_card deck
	players_cards[input_name].push(card)
	card = pick_card deck
	players_cards[input_name].push(card)

end

card = pick_card deck
dealer_cards.push(card)
card = pick_card deck
dealer_cards.push(card)

players_name.each do |player_name|
	say "Hello! " + player_name + "! It's your turn!"

	while true
		player_point = cards_to_point players_cards[player_name]
		say "Your current cards in hand are: " + cards_in_hand_to_string(players_cards[player_name])
		say "Your current score is: " + player_point.to_s

		if player_point > 21
			say "Oh! No! You busted!" 
			break
		elsif player_point == 21
			say "Blackjack! You play a nice game!"
			break
		end

		say "Do you want hit or stay?"
		say "1) Hit  2)Stay"

		command = gets.chomp.to_i

		if command == 2
			say "OK, please wait..."
			break
		end

		card = pick_card deck
		players_cards[player_name].push(card)
	end
end

say "It's my turn."

while true
	
	card = pick_card deck
	dealer_cards.push card

	dealer_point = cards_to_point dealer_cards
	say "My current cards in hand are: " + cards_in_hand_to_string(dealer_cards)
	say "My current score is: " + dealer_point.to_s

	if dealer_point > 21
		say "Oh! No! I busted!"
		break
	elsif dealer_point == 21
		say "Oh! Sorry! BLACKJACK! I win!;)"
		break
	elsif dealer_point > 17
		say "I should stay..."
		break
	end
end

players_name.each do |player_name|
	player_point = cards_to_point players_cards[player_name]

	if player_point > 21
		result_declare(player_name, "lose")
	elsif player_point == 21
		result_declare(player_name, "win")
	elsif dealer_point > 21
		result_declare(player_name, "win")
	elsif dealer_point == 21
		result_declare(player_name, "lose")
	elsif dealer_point > player_point
		result_declare(player_name, "lose")
	elsif dealer_point < player_point
		result_declare(player_name, "win")
	else
		result_declare(player_name, "draw")
	end

end

say "Nice match!!! Thanks playing!!!"
