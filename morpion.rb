require 'colorize'

class BoardCase
    #TO DO : la classe a 2 attr_accessor, sa valeur (X, O, ou vide), ainsi que son numéro de case)
    attr_accessor :value, :case_number 
    
    def initialize (case_number)
      #TO DO doit régler sa valeur, ainsi que son numéro de case
        @value = value
        @case_number = case_number
    end
    
    #TO DO modifier? 
    def to_s
      #TO DO : doit renvoyer la valeur au format string
       return @value.to_s
    end
end

class Board
    include Enumerable
    #TO DO : la classe a 1 attr_accessor, une array qui contient les BoardCases
    attr_accessor :board
  
    def initialize
      #TO DO :
      #Quand la classe s'initialize, elle doit créer 9 instances BoardCases
      #Ces instances sont rangées dans une array qui est l'attr_accessor de la classe
      @board =  [*1..9].map { |i|  BoardCase.new(i).case_number }
    end

    def to_s
        #TO DO : afficher le plateau
        puts "\n Here is the board for playing Tic Tac Toe Game with the following rule : each number corresponds to a box index"
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end 

    def play(value)
    #TO DO : une méthode qui change la BoardCase jouée en fonction de la valeur du joueur (X, ou O)
        case_number = gets.chomp().to_i
        case_number = case_number -1
        @board.each_index { |e|
        e == case_number && @board[e] != 'X' && @board[e] != 'O' ? @board[e] = value : @board[e] }
    end

    def draw?
        if @board.all? { |e| e == "X" || e == "O" } 
            return true
        else 
          return false
        end
    end

    def victory?
        #TO DO : qui gagne ?
        if (@board[0] == @board[1] && @board[0] == @board[2]) || (@board[3] == @board[4] && @board[3] == @board[5]) || (@board[6] == @board[7] && @board[6] == @board[8] ) || (@board[0] == @board[3] && @board[0] == @board[6]) || (@board[1] == @board[4] && @board[1] == @board[7]) || (@board[2] == @board[5] && @board[2] == @board[8]) ||( @board[0] == @board[4] && @board[0] == @board[8]) || (@board[2] == @board[4] && @board[2] == @board[6])
          return true
        else
          return false
        end
    end
end 

class Player
    #TO DO : la classe a 2 attr_accessor, son nom, sa valeur (X ou O). Elle a un attr_writer : il a gagné ?
    attr_accessor :name, :value
    attr_writer :status

    def initialize(value)
      #TO DO : doit régler son nom, sa valeur, son état de victoire
        @name = gets.chomp
        puts ">Welcome #{@name}!".colorize(:magenta)
        @value = value
        @status = ">The game is in progress".colorize(:magenta)
    end
end 
  
class Game
    def initialize
      #TO DO : créé 2 joueurs, créé un board
      puts "\n Welcome to the Tic-Tac-Toe Game!".colorize(:magenta)
      @board = Board.new 
      puts "\n>Player 1 : What's your name?".colorize(:magenta)
      @player1 = Player.new("X")
      puts "\n>Player 2 : What's your name?".colorize(:magenta)
      @player2 = Player.new("O")
    end
 
    def go
    # TO DO : lance la partie
        while @board.victory? == false && @board.draw? == false
        self.turn
        end
   end

    def turn
    #TO DO : affiche le plateau, demande au joueur il joue quoi, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
    ObjectSpace.each_object(Player) do |obj|
    @board.to_s
    puts ""
        if @board.draw? == true
            @board.to_s
            puts ""
            puts "it s a draw, end of the game.\n A new game will automatically start. Press Ctrl+C to quit.".colorize(:yellow)
            # break
            @new_round = Game.new.go 
        end
    puts ">Now, #{obj.name} you need to play a number between 1 and 9 for replacing the box index by the symbol #{obj.value} ".colorize(:light_blue)
    @board.play(obj.value)
            if @board.victory? == true
        @board.to_s
        puts ""
        puts ">Congratulations #{obj.name}, YOU WIN! End of the game.\nA new game will automatically start. Press Ctrl+C to quit. ".colorize(:green)
            # break
            @new_round = Game.new.go 
            end
    end 
end 
end 
Game.new.go 


