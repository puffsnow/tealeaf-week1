#This program simulate a blackjack game, user be player and computer be dealer.

require "pry"

def say msg

	puts("@Dealer: #{msg}")
end

def win_declare name
	say "Great, #{name}! You win this game!"
end

def lose_declare name
	say "Oops, sorry, #{name}. You lose this game. "
end

def draw_declare name
	say "#{name}, we draw :)"
end

def shuffle

	original_cards = Array.new(52) {|index| index}
	shuffle_cards = []
	i = 52

	until original_cards.empty?
		taking_num = rand(i)
		shuffle_cards.push(original_cards[taking_num])
		original_cards.delete_at(taking_num)
		i = i - 1
	end

	return shuffle_cards
end

def pick_card cards
	taking_num = rand(cards.count)
	return_value = cards[taking_num]
	cards.delete_at(taking_num)
	return return_value
end

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

def card_to_string card
	colors = ["club", "diamond", "heart", "spade"]
	numbers = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
	return colors[card / 13] + numbers[card % 13]
end

def cards_in_hand_to_string cards
	card_strings = []
	cards.each do |card|
		card_strings.push(card_to_string(card))
	end
	return card_strings.join(", ")
end

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
		lose_declare player_name
	elsif player_point == 21
		win_declare player_name
	elsif dealer_point > 21
		win_declare player_name
	elsif dealer_point == 21
		lose_declare player_name
	elsif dealer_point > player_point
		lose_declare player_name
	elsif dealer_point < player_point
		win_declare player_name
	else
		draw_declare player_name
	end

end

say "Nice match!!! Thanks playing!!!"
